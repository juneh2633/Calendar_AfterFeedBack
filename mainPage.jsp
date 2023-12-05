<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
    class Schedule {
        private String scheduleTime;
        private String scheduleText;
        private int scheduleUid;
        public Schedule(String scheduleTime, String scheduleText, int scheduleUid) {
            this.scheduleTime = scheduleTime;
            this.scheduleText = scheduleText;
            this.scheduleUid = scheduleUid;
        }
        public String getScheduleTime() {
            return scheduleTime;
        }
        public String getScheduleText() {
            return scheduleText;
        }
        public int getScheduleUid() {
            return scheduleUid;
        }
        public String toString() {
            return "{\"scheduleTime\":\"" + scheduleTime + "\", \"scheduleText\":\"" + scheduleText + "\",\"scheduleUid\":\"" + scheduleUid + "\"}";
        }
    }

    String id = (String)session.getAttribute("id");
    if(id == null){
        out.print("<script>alert('로그인 해주세요.'); window.location.href='loginPage.jsp';</script>");
        return;
    } 

    String phonenumber = (String)session.getAttribute("phonenumber");
    String name = (String)session.getAttribute("name");
    String grade = (String)session.getAttribute("grade");
    String team = (String)session.getAttribute("team");
    String gradeKr ="팀원";
    String teamKr ="";
    if(grade.equals("leader")){
        gradeKr = "팀장";
    }
    if(team.equals("develope")){
        teamKr = "개발팀";
    }
    else if(team.equals("design")){
        teamKr = "디자인팀";
    }

    //일정수정권한부여
    Boolean grantWriteCheck = false;
    String pageId = request.getParameter("idValue");
    String pageName = request.getParameter("nameValue");
    if(pageId.equals(id)){
        grantWriteCheck = true;
    }

    //스케줄표 전처리
    Class.forName("com.mysql.jdbc.Driver");
    LocalDate today = LocalDate.now();
    int currentMonth = today.getMonthValue();
    int currentYear = today.getYear();
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");
    String sql = "SELECT * FROM schedule WHERE id = ? ORDER BY schedule_date ASC";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, pageId);
    ResultSet result = query.executeQuery();
    TreeMap<String,ArrayList<Schedule>> scheduleTree = new TreeMap<>();
    while(result.next()){
        int deletedCheck = result.getInt(6);
        if(deletedCheck == 1){
            continue;
        }
        String scheduleDate = result.getString(3);
        String[] parts = scheduleDate.split(" ");
        String datePart = parts[0];
        String timePart = parts[1]; 
        String uidPart = (parts.length > 2) ? parts[2] : "";
        String[] dateParts = parts[0].split("-");
        int year = Integer.parseInt(dateParts[0]);
        int month = Integer.parseInt(dateParts[1]);
        int day = Integer.parseInt(dateParts[2]);
        Schedule scheduleElement = new Schedule(timePart, result.getString(4), result.getInt(1));
        if (scheduleTree.containsKey(datePart)) {
            ArrayList<Schedule> getList = scheduleTree.get(datePart);
            getList.add(scheduleElement);
        } 
        else {
            ArrayList<Schedule> newList = new ArrayList<>();
            newList.add(scheduleElement);
            scheduleTree.put(datePart, newList);
        }
    }
    query.close();
    JSONObject scheduleTreeJson = new JSONObject(scheduleTree);
    String scheduleTreeJsonString = scheduleTreeJson.toJSONString();
    //
    ArrayList<String>teamId = new ArrayList<>();
    ArrayList<String>teamName = new ArrayList<>();
    //팀장만 목록 가져오기
    if(grade.equals("leader")){
        String teamSql = "SELECT * FROM user WHERE team = ? AND grade = 'member' AND user_deleted = 0 ORDER BY name ASC";
        PreparedStatement teamQuery = connect.prepareStatement(teamSql);
        teamQuery.setString(1, team);
        ResultSet teamResult = teamQuery.executeQuery();
        while(teamResult.next()){
            teamId.add("'"+teamResult.getString(1)+"'");
            teamName.add("'"+teamResult.getString(4)+"'");
        }
        teamQuery.close();
    }
    connect.close();
%>
<script>
    var scheduleTreeJson = <%=scheduleTreeJson%>;
    var pageYear = <%=currentYear%>;
    var pageMonth = <%=currentMonth%>;
    var teamId = <%=teamId%>;
    var teamName = <%=teamName%>;
    var grantWrite = <%=grantWriteCheck%>;
    console.log(grantWrite);
    console.log(pageYear);
    console.log(pageMonth);
    console.log(scheduleTreeJson); 
</script>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/element.css">
    <link type="text/css" rel="stylesheet" href="CSS/mainPage.css">
    <link type="text/css" rel="stylesheet" href="CSS/navigation.css">
    <link type="text/css" rel="stylesheet" href="CSS/modalPage.css">
    <title>Document</title>
</head>
<body>
    <header>
        <div class="headerHigh">
            <div class="nameAreaId"><%=pageId%></div>
            <div class="nameAreaName"><%=pageName%></div>
            <div class="yearButtonArea">
                <input class="yearButtonUp" type="button" value="↑" onclick="yearUpEvent()">
                <input class="yearButtonDown" type="button" value="↓" onclick="yearDownEvent()">
            </div>
            <div id="yearArea" class="yearArea"><%=currentYear%>년</div>
            <div id="monthArea" class="monthArea"></div>
            <input class="navAppearButton" type="button" value="메뉴" onclick="navAppearEvent()">
        </div>
        <div class="headerLow">
            <input id="saveCheck" type="text" value="0" style="display: none;">
            <input class="monthBox" type="button" value="1" onclick="makeDateBoxEvent(1)">
            <input class="monthBox" type="button" value="2" onclick="makeDateBoxEvent(2)">
            <input class="monthBox" type="button" value="3" onclick="makeDateBoxEvent(3)">
            <input class="monthBox" type="button" value="4" onclick="makeDateBoxEvent(4)">
            <input class="monthBox" type="button" value="5" onclick="makeDateBoxEvent(5)">
            <input class="monthBox" type="button" value="6" onclick="makeDateBoxEvent(6)">
            <input class="monthBox" type="button" value="7" onclick="makeDateBoxEvent(7)">
            <input class="monthBox" type="button" value="8" onclick="makeDateBoxEvent(8)">
            <input class="monthBox" type="button" value="9" onclick="makeDateBoxEvent(9)">
            <input class="monthBox" type="button" value="10" onclick="makeDateBoxEvent(10)">
            <input class="monthBox" type="button" value="11" onclick="makeDateBoxEvent(11)">
            <input class="monthBox" type="button" value="12" onclick="makeDateBoxEvent(12)">
        </div>
    </header>
    <main id="calendarBox" class="calendarBox">
        <div class="daysBox"></div>
        <div class="daysBox"></div>
        <div class="daysBox"></div>
        <div class="daysBox"></div>
        <div class="daysBox"></div>
        <div class="daysBox"></div>
        <div class="daysBox"></div>
    </main>
    <nav id="navigation">
        <input class="disappearButton" type="button" value="X" onclick="navDisappearEvent()">
        <div class="infoArea">
            <div class="infoBox">
                <div class="infoTextBox">아이디</div>
                <div class="infoOutputBox"><%=id%></div>
            </div>
            <div class="infoBox">
                <div class="infoTextBox">이름</div>
                <div class="infoOutputBox"><%=name%></div>
            </div>
            <div class="infoBox">
                <div class="infoTextBox">직급</div>
                <div class="infoOutputBox"><%=gradeKr%></div>
            </div>
            <div class="infoBox">
                <div class="infoTextBox">부서</div>
                <div class="infoOutputBox"><%=teamKr%></div>
            </div>
            <div class="infoBox">
                <div class="infoTextBox">전화번호</div>
                <div class="infoOutputBox"><%=phonenumber%></div>
            </div>
            <div class="infoButtonBox">
                <input class="infoButton" type="button" value="내 정보 수정" onclick="location.href='infoUpdatePage.jsp'">
                <input class="infoButton" type="button" value="로그아웃" onclick="location.href='action/logoutAction.jsp'">
            </div>
            <div class="infoButtonBox">
                <input class="myInfoButton" type="button" value="내 일정 보기" onclick="location.href='mainPage.jsp?idValue=<%=id%>&nameValue=<%=name%>'">
            </div>
        </div>
        <div id="myTeamArea" class="myTeamArea">
        </div>
    </nav>
    <div id="modalOverlay"></div>
    <div id="modalPage">
        <div class="modalHeader">
            <input class="disappearButton" type="button" value="X" onclick="modalDisappearEvent()">
            <div id="modalDate" class="modalDateBox"></div>
        </div>

    </div>
    <script src="JavaScript/makeCalendar.js"></script>
    <script src="JavaScript/nav.js"></script>
    <script src="JavaScript/modal.js"></script>
    <script>makeDateBoxEvent(pageMonth)</script>
    <script>makeTeamArea()</script>

</body>

</html>