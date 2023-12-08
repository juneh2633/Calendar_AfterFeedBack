<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %> 
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<% 
    request.setCharacterEncoding("utf-8"); //전페이지 request 
    String idValue = request.getParameter("idValue");
    String passwordValue = request.getParameter("passwordValue");
    String passwordCheckValue = request.getParameter("passwordCheckValue");
    String phonenumberValue = request.getParameter("phonenumberValue");
    String nameValue = request.getParameter("nameValue");
    String gradeValue = request.getParameter("gradeValue");
    String teamValue = request.getParameter("teamValue");
    String pattern = "^[a-zA-Z0-9]{6,30}$";
    String numPattern = "^\\d{11}$";
    String namePattern = "^[가-힣a-zA-Z]{1,30}$";

    try{
        idValue = idValue.replaceAll("\\s", "");
        passwordValue = passwordValue.replaceAll("\\s", "");
        phonenumberValue = phonenumberValue.replaceAll("\\s", "");
        nameValue = nameValue.replaceAll("\\s", "");
        
        //정규표현식으로 간결화- (백엔드에서도 정규식 사용가능)
        if(!Pattern.matches(pattern,idValue)||!Pattern.matches(pattern, passwordValue)||!passwordValue.equals(passwordCheckValue)||!Pattern.matches(numPattern,phonenumberValue)||!Pattern.matches(namePattern, nameValue) ){
            response.sendRedirect("../signupPage.jsp");   
            return;    
        }

        Class.forName("com.mysql.jdbc.Driver");
        Date currentDate = new Date();
        Timestamp currentTimestamp = new Timestamp(currentDate.getTime());
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar_fb", "juneh","2633");

        String sqlDouble = "SELECT * FROM user WHERE id = ? ";
        PreparedStatement queryDouble = connect.prepareStatement(sqlDouble);
        queryDouble.setString(1, idValue);
        ResultSet resultDouble = queryDouble.executeQuery();
        if(resultDouble.next()){
            response.sendRedirect("../signupPage.jsp");
            return; 
        }

        String sql = "INSERT INTO user (id, password, phonenumber, name, grade_number, team_number, user_deleted) VALUES (?, ?, ?, ?, ?, ? , 0)";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, idValue);
        query.setString(2, passwordValue);
        query.setString(3, phonenumberValue);
        query.setString(4, nameValue);
        query.setInt(5, Integer.parseInt(gradeValue));
        query.setInt(6, Integer.parseInt(teamValue));
        query.executeUpdate();
        query.close();
        connect.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("../signupPage.jsp");
        return;
    }

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
        location.href="../index.jsp"
    </script>
</body>