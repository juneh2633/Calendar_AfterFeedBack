var pattern = /^[a-zA-Z0-9]{6,30}$/;
var numPattern = /^\d{11}$/ 
var namePattern = /^[가-힣a-zA-Z]{1,30}$/;
function checkSignup() {
    var doubleCheckValue = document.getElementById("doubleCheck").value;
    var idValue = document.getElementById("idValue").value;
    var passwordValue = document.getElementById("passwordValue").value;
    var passwordCheckValue = document.getElementById("passwordCheckValue").value;
    var phonenumberValue = document.getElementById("phonenumberValue").value;
    var nameValue = document.getElementById("nameValue").value;
    if (doubleCheckValue == "0") {
        alert("중복확인을 해주세요.");
        return;        
    }
    if (!pattern.test(idValue)) {
        alert("아이디 형식이 올바르지 않습니다.");
        return;
    }
    if (!pattern.test(passwordValue)) {
        alert("비밀번호 형식이 올바르지 않습니다.");
        return;
    }
    if (passwordValue!=passwordCheckValue) {
        alert("비밀번호와 비밀번호확인이 동일하지 않습니다.");
        return;
    }    
    if (!pattern.test(passwordValue)) {
        alert("비밀번호 형식이 올바르지 않습니다.");
        return;
    }
    if (!numPattern.test(phonenumberValue)) {
        alert("전화번호 형식이 올바르지 않습니다.")
        return;
    }
    if (!namePattern.test(nameValue)) {
        alert("이름 형식이 올바르지 않습니다.")
        return;
    }    
    document.signupForm.submit();
}
function checkFindId() {
    var nameValue = document.getElementById("nameValue").value;
    var phonenumberValue = document.getElementById("phonenumberValue").value;
    if (!namePattern.test(nameValue)) {
        alert("이름 형식이 올바르지 않습니다.")
        return;
    }        
    if (!numPattern.test(phonenumberValue)) {
        alert("전화번호 형식이 올바르지 않습니다.")
        return;
    }
    document.findIdForm.submit();
}
function checkFindPassword() {
    var idValue = document.getElementById("idValue").value;
    var phonenumberValue = document.getElementById("phonenumberValue").value;
    var nameValue = document.getElementById("nameValue").value;
    if (!pattern.test(idValue)) {
        alert("아이디 형식이 올바르지 않습니다.");
        return;
    }
    if (!numPattern.test(phonenumberValue)) {
        alert("전화번호 형식이 올바르지 않습니다.")
        return;
    }
    if (!namePattern.test(nameValue)) {
        alert("이름 형식이 올바르지 않습니다.")
        return;
    }    
    document.findPasswordForm.submit();
}
function checkLogin() {
    var idValue = document.getElementById("idValue").value;
    var passwordValue = document.getElementById("passwordValue").value;
    if (!pattern.test(idValue)) {
        alert("아이디를 확인해주세요");
        return;
    }
    if (!pattern.test(passwordValue)) {
        alert("비밀번호를 확인해주세요");
        return;
    }
    document.loginForm.submit();
}
function checkUserUpdate() {
    var passwordValue = document.getElementById("passwordValue").value;
    var passwordCheckValue = document.getElementById("passwordCheckValue").value;
    var phonenumberValue = document.getElementById("phonenumberValue").value;
    var nameValue = document.getElementById("nameValue").value;
    if (!pattern.test(passwordValue)) {
        alert("비밀번호 형식이 올바르지 않습니다.");
        return;
    }
    if (passwordValue!=passwordCheckValue) {
        alert("비밀번호와 비밀번호확인이 동일하지 않습니다.");
        return;
    }    
    if (!pattern.test(passwordValue)) {
        alert("비밀번호 형식이 올바르지 않습니다.");
        return;
    }
    if (!numPattern.test(phonenumberValue)) {
        alert("전화번호 형식이 올바르지 않습니다.")
        return;
    }
    if (!namePattern.test(nameValue)) {
        alert("이름 형식이 올바르지 않습니다.")
        return;
    }    
    document.userUpdateForm.submit();
}