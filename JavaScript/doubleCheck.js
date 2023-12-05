function doubleCheckEvent() {
    var idValue = document.getElementById("idValue").value;
    var pattern = /^[a-zA-Z0-9]{6,30}$/;
    if (!pattern.test(idValue)) {
        alert("아이디 형식이 올바르지 않습니다.");
        return;
    }   
    window.location.href = "../Calendar/action/doubleCheckAction.jsp?idValue=" + idValue;
    var idBox = document.getElementById("idValue");
    idBox.readOnly = true;
    idBox.style.backgroundColor = "white";
    idBox.style.color = "black";
    document.getElementById("doubleCheck").value = 1;    
}
