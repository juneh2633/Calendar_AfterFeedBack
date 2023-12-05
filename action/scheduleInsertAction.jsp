<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 

<% 
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    String id = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");
    String scheduleDay = request.getParameter("scheduleDay");
    String scheduleMonth = request.getParameter("scheduleMonth");
    String scheduleYear = request.getParameter("scheduleYear");
    String modalInputTime = request.getParameter("modalInputTime");
    String modalInputSchedule = request.getParameter("modalInputSchedule");
    String inputDate = scheduleYear+"-"+scheduleMonth+"-"+scheduleDay+" "+modalInputTime;
    Class.forName("com.mysql.jdbc.Driver");
    Date currentDate = new Date();
    Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");
    String sql = "INSERT INTO schedule (id, schedule_date, main_text, deleted_schedule) VALUES (?, ?, ?, 0)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, inputDate);
    query.setString(3, modalInputSchedule);
    try{
        query.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류'); history.back();</script>");
        return;
    }
    query.close();
    connect.close();

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>loading</div>
    <script>
        location.href = '../mainPage.jsp?idValue=<%=id%>&nameValue=<%=name%>';
    </script>
</body>