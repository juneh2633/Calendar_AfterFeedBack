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
    String nameValue = request.getParameter("nameValue");
    String phonenumberValue = request.getParameter("phonenumberValue");
    nameValue = nameValue.replaceAll("\\s", "");
    phonenumberValue = phonenumberValue.replaceAll("\\s", "");
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
    String sql = "SELECT * FROM user WHERE name = ? AND phonenumber = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, nameValue);
    query.setString(2, phonenumberValue);
    ResultSet result = query.executeQuery();
    Boolean idExist = false;
    String id = "";

    if(result.next()){
        idExist = true;
        id = result.getString(1);
    }
    if(idExist == false){
        out.println("<script>alert('아이디가 존재하지 않습니다.'); history.back();</script>");
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
        alert("아이디는 "+ '<%=id%>' +" 입니다.");
        location.href="../loginPage.jsp";
    </script>
</body>