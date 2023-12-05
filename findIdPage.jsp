<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/element.css">
    <link type="text/css" rel="stylesheet" href="CSS/findPage.css">
    <title>Document</title>
</head>

<body>
    <main class="findBox">
        <div class="findHeader">
            <h2>아이디 찾기</h2>
        </div>
        <div class="findMain">
            <form name="findIdForm" action="action/findIdAction.jsp">
            <div class="inputBox">
                <span class="inputBoxText">이름</span>
                <input id="nameValue" name="nameValue" class="inputBoxInput" type='text' placeholder="1~30 한글,영어" maxlength="30">
            </div>
            <div class="inputBox">
                <span class="inputBoxText">전화번호</span>
                <input id="phonenumberValue" name="phonenumberValue" class="inputBoxInput" type='text' placeholder="(-)없이 11자리 숫자" maxlength="11">
            </div>                
            </form>
        </div>
        <div class="findFooter">
            <input type="button" class="findButton" value="찾기" onclick="checkFindId()">
            <input type="button" class="findButton" value="뒤로가기" onclick="history.back()">
        </div>
    </main>
    <script src="JavaScript/checkException.js"></script>
</body>

</html>