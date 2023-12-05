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
    if(id == null){
        out.print("<script>alert('로그인 해주세요.'); window.location.href='loginPage.jsp';</script>");
        return;
    } 
    String phonenumber = (String)session.getAttribute("phonenumber");
    String name = (String)session.getAttribute("name");
    String grade = (String)session.getAttribute("grade");
    String team = (String)session.getAttribute("team");
    String gradeLeaderCheck ="";
    String gradeMemberCheck = "";
    if(grade.equals("leader")){
        gradeLeaderCheck="checked"; 
    }
    else{
        gradeMemberCheck="checked";
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="CSS/element.css">
    <link type="text/css" rel="stylesheet" href="CSS/signupPage.css">
    <title>Document</title>
</head>
<body>
    <main class="signupBox">
        <form name="userUpdateForm" action="action/userUpdateAction.jsp">
            <div class="signupHeader">
                <h2>내 정보 수정</h2>
            </div>
            <div class="signupMain">
                
                <div class="signupMainLeft">
                    <div class="inputBox">
                        <span class="inputBoxText">아이디</span>
                        <input id="idValue" name="idValue" class="inputBoxInput" type='text' placeholder="6~30 영어,숫자" maxlength="30" value=<%=id%> >
                    </div>
                    <div class="inputBox">
                        <span class="inputBoxText">비밀번호</span>
                        <input id="passwordValue" name="passwordValue" class="inputBoxInput" type='password' placeholder="6~30 영어,숫자" maxlength="30">
                    </div>
                    <div class="inputBox">
                        <span class="inputBoxText">확인</span>
                        <input id="passwordCheckValue" name="passwordCheckValue" class="inputBoxInput" type='password' placeholder="6~30 영어,숫자" maxlength="30">
                    </div>
                    <div class="inputBox">
                        <span  class="inputBoxText">전화번호</span>
                        <input id="phonenumberValue" name="phonenumberValue" class="inputBoxInput" type='text' placeholder="(-)없이 11자리 숫자" maxlength="11" value= <%=phonenumber%>>
                    </div>
                    <div class="inputBox">
                        <span  class="inputBoxText">이름</span>
                        <input id="nameValue" name="nameValue" class="inputBoxInput" type='text' placeholder="6~30 한글,영어" maxlength="30" value= <%=name%> >
                    </div>
                </div>
                <div class="signupMainRight">
                    <div class="inputBox">
                        <span class="inputBoxText">직급</span>
                        <div class="radioText">팀장</div>
                        <input name="grade" type='radio' value="팀장" <%=gradeLeaderCheck%> >
                        <div class="radioText">팀원</div>
                        <input name="grade" type='radio' value="팀원" <%=gradeMemberCheck%> >
                    </div>
                    <div class="inputBox">
                        <span class="inputBoxText">부서</span>
                        <select class="selectBox" name="team">
                            <option value="develop">개발팀</option>
                            <option value="design">디자인팀</option>
                        </select>
                    </div>
                    <div class="signupButtonBox">
                        <input type="button" class="signupButton" value="수정하기" onclick="checkUserUpdate()">
                        <input type="button" class="signupButton" value="뒤로가기" onclick="history.back()">
                    </div>
                </div>

            </div>
        </form>
        
    </main>
    

    <script src="JavaScript/checkException.js"></script>
    <script>
        var idBox = document.getElementById("idValue");
        idBox.readOnly = true;
        idBox.style.backgroundColor = "white";
        idBox.style.color = "black";
    </script>
</body>
</html>