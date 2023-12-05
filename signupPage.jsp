<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
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
        <form name="signupForm" action="action/userInsertAction.jsp">
            <div class="signupHeader">
                <h2>회원가입</h2>
            </div>
            <div class="signupMain">
                <div class="signupMainLeft">
                    <div class="inputBox">
                        <input id="doubleCheck" type="text" value="0" style="display: none;">
                        <span class="inputBoxText">아이디</span>
                        <input id="idValue" name="idValue" class="inputBoxInput" type='text' placeholder="6~30 영어,숫자" maxlength="30">
                        <input class="doubleCheckButton" type="button" value="중복확인" onclick="doubleCheckEvent()">
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
                        <input id="phonenumberValue" name="phonenumberValue" class="inputBoxInput" type='text' placeholder="(-)없이 11자리 숫자" maxlength="11">
                    </div>
                    <div class="inputBox">
                        <span  class="inputBoxText">이름</span>
                        <input id="nameValue" name="nameValue" class="inputBoxInput" type='text' placeholder="1~30 한글,영어" maxlength="30">
                    </div>
                </div>
                <div class="signupMainRight">
                    <div class="inputBox">
                        <span class="inputBoxText">직급</span>
                        <div class="radioText">팀장</div>
                        <input name="gradeValue" type='radio' value="leader">
                        <div class="radioText">팀원</div>
                        <input name="gradeValue" type='radio' value="member" checked>
                    </div>
                    <div class="inputBox">
                        <span class="inputBoxText">부서</span>
                        <select class="selectBox" name="teamValue">
                            <option value="develope">개발팀</option>
                            <option value="design">디자인팀</option>
                        </select>
                    </div>
                    <div class="signupButtonBox">
                        <input type="button" class="signupButton" value="회원가입" onclick="checkSignup()">
                        <input type="button" class="signupButton" value="뒤로가기" onclick="history.back()">
                    </div>
                </div>
            </div>
        </form>        
    </main>

     <script src="JavaScript/checkException.js"></script>
     <script src="JavaScript/doubleCheck.js"></script>
</body>
</html>