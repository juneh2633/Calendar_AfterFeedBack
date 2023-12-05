<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<%
    String id = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");
    if(id != null){
%>
<script>
    alert("이미 로그인 되어있습니다");
    location.href = "mainPage.jsp?idValue=" + '<%=id%>' + "&nameValue=" + '<%=name%>';
</script>
<%
        return;
    } 

%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/element.css">
    <link type="text/css" rel="stylesheet" href="CSS/loginPage.css">
    <title>Document</title>
</head>
<body>
    <main class="loginBox">
            <div class="loginHeader">
                <h2>로그인</h2>
            </div>
            <div class="loginMain">
            <form name="loginForm" action="action/loginAction.jsp">
                <div class="inputBox">
                    <span class="inputBoxText">아이디</span>
                    <input id="idValue" name="idValue" class="inputBoxInput" type='text' maxlength="30">
                </div>
                <div class="inputBox">
                    <span class="inputBoxText">비밀번호</span>
                    <input id="passwordValue" name="passwordValue"  class="inputBoxInput" type='password' maxlength="30">
                </div>
            </form>
            </div>
            <div class="loginFooter">
                <div class="loginPageTextArea">
                    <div>
                        <a href="findIdPage.jsp">아이디</a>
                        <a href="findPasswordPage.jsp">비밀번호</a>
                        찾기
                    </div>
                    <div>
                        <a href="signupPage.jsp">회원가입</a>
                    </div>
                </div>
                <input type="button" class="loginButton" value="로그인" onclick="checkLogin()">
            </div>
    </main>
    <script src="JavaScript/checkException.js"></script>
</body>
</html>