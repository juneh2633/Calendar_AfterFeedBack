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
    String passwordValue = request.getParameter("passwordValue");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");
    String sql = "UPDATE schedule SET deleted_schedule = 1 WHERE schedule_uid = ? ";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, uid);
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
