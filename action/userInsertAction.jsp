<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<% 
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    String idValue = request.getParameter("idValue");
    String passwordValue = request.getParameter("passwordValue");
    String passwordCheckValue = request.getParameter("passwordCheckValue");
    String phonenumberValue = request.getParameter("phonenumberValue");
    String nameValue = request.getParameter("nameValue");
    String gradeValue = request.getParameter("gradeValue");
    String teamValue = request.getParameter("teamValue");
    
    //try시작 애러가 발생할 수 있는 부분부터
    idValue = idValue.replaceAll("\\s", "");
    passwordValue = passwordValue.replaceAll("\\s", "");
    phonenumberValue = phonenumberValue.replaceAll("\\s", "");
    nameValue = nameValue.replaceAll("\\s", "");

    if(idValue.length() <= 5){
        out.println("<script>alert('오류'); history.back();</script>");       
    }
    if(idValue.length()>30){
        out.println("<script>alert('오류'); history.back();</script>");      
    }
    if(passwordValue.length()<=5){
        out.println("<script>alert('오류'); history.back();</script>");
    }
    if(passwordValue.length()>30){
        out.println("<script>alert('오류'); history.back();</script>");
    }
    if (!passwordValue.equals(passwordCheckValue)) {        
        out.println("<script>alert('오류'); history.back();</script>");
    }
    if(phonenumberValue.length()!=11){
        out.println("<script>alert('오류'); history.back();</script>");
    }
    if(nameValue.length()==0){
        out.println("<script>alert('오류'); history.back();</script>");
    }
    if(nameValue.length()>30){
        out.println("<script>alert('오류'); history.back();</script>");
    }

    Class.forName("com.mysql.jdbc.Driver");
    Date currentDate = new Date();
    Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar", "juneh","2633");

    String sqlDouble = "SELECT * FROM user WHERE id = ? ";
    PreparedStatement queryDouble = connect.prepareStatement(sqlDouble);
    queryDouble.setString(1, idValue);
    ResultSet resultDouble = queryDouble.executeQuery();
    if(resultDouble.next()){
        out.println("<script>alert('오류'); history.back();</script>");
    }

    String sql = "INSERT INTO user (id, password, phonenumber, name, grade, team, user_deleted) VALUES (?, ?, ?, ?, ?, ? , 0)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, passwordValue);
    query.setString(3, phonenumberValue);
    query.setString(4, nameValue);
    query.setString(5, gradeValue);
    query.setString(6, teamValue);

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
    <script>console.log("sign up well")</script>
    <%
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>loading</div>
    <script>
        console.log("hi");
        alert("회원가입에 성공하였습니다. 로그인 해주세요.")
        location.href="../loginPage.jsp"
    </script>
</body>