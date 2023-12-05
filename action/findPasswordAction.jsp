<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<% 
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("idValue");
    String nameValue = request.getParameter("nameValue");
    String phonenumberValue = request.getParameter("phonenumberValue");
    nameValue = nameValue.replaceAll("\\s", "");
    phonenumberValue = phonenumberValue.replaceAll("\\s", "");
    if(idValue.length()<=5){
        out.println("<script>alert('오류'); history.back();</script>");
        return;       
    }
    if(idValue.length()>30){
        out.println("<script>alert('오류'); history.back();</script>");
        return;
    }
    if(nameValue.length()==0){
        out.println("<script>alert('오류'); history.back();</script>");
        return;       
    }
    if(nameValue.length()>30){
        out.println("<script>alert('오류'); history.back();</script>");
        return;
    }
    if(phonenumberValue.length()!=11){
        out.println("<script>alert('오류'); history.back();</script>");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");
    String sql = "SELECT * FROM user WHERE name = ? AND phonenumber = ? AND id = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, nameValue);
    query.setString(2, phonenumberValue);
    query.setString(3, idValue);
    ResultSet result = query.executeQuery();
    String password = "";
    if(result.next()){
        password = result.getString(2);
    }
    else{
        out.println("<script>alert('비밀번호가 존재하지 않습니다.'); history.back();</script>");
        return;
    }
    query.close();
    connect.close();
%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>


    <script>
        alert("비밀번호는 "+ '<%=password%>' +" 입니다.");
        location.href="../loginPage.jsp";
    </script>
</body>