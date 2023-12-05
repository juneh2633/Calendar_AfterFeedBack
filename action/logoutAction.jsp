<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<% 
    session.invalidate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div>loading</div>
    <script>
        alert("로그아웃 되었습니다.")
        location.href = "../loginPage.jsp"
    </script>
</body>