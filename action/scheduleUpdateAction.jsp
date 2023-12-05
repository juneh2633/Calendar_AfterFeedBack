<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<% //jsp 작성 
    request.setCharacterEncoding("utf-8");
    String id = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");
    String uid = request.getParameter("uid");
    String scheduleUpdateTime = request.getParameter("scheduleUpdateTime");
    String scheduleUpdateText = request.getParameter("scheduleUpdateText");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");
    
    String sqlFindDate = "SELECT schedule_date FROM schedule WHERE schedule_uid = ? ";
    PreparedStatement queryFindDate = connect.prepareStatement(sqlFindDate);
    queryFindDate.setString(1, uid);
    ResultSet resultFindDate = queryFindDate.executeQuery();
    

    String updatedScheduleDate = "";
    if (resultFindDate.next()) {
        String oldScheduleDate = resultFindDate.getString("schedule_date");
        updatedScheduleDate = oldScheduleDate.substring(0, 11) + scheduleUpdateTime + oldScheduleDate.substring(16);
    }
    queryFindDate.close();

    // schedule_date를 업데이트
    String sql = "UPDATE schedule SET schedule_date = ?, main_text = ? WHERE schedule_uid = ? ";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, updatedScheduleDate);
    query.setString(2, scheduleUpdateText);
    query.setString(3, uid);

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
