<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String errorMsg = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";

	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	
	
	 // 사용자 정보를 위한 변수 초기화
	  String dbuserid = "";
	  String dbname = "";
	  String dbpwd = "";
	  
	  List<String> errorMsgs = new ArrayList<String>();
	  int result = 0;
	  // Request로 ID가 있는지 확인
	try{
			Class.forName("com.mysql.jdbc.Driver");
	      // DB 접속
	      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	      // 질의 준비
	      stmt = conn.prepareStatement("SELECT * FROM users WHERE userid = ? AND pwd=?");
	      stmt.setString(1, userid);
	      stmt.setString(2, pwd);
	      // 수행
	      rs = stmt.executeQuery();
	      //System.out.println(rs);
	      if (rs.next()) {
	        dbuserid = rs.getString("userid");
	        dbname = rs.getString("name");
	        dbpwd = rs.getString("pwd");
	     		
	     		result = 1;
	     		
	      }else{
   			errorMsg = "로그인 실패";
   		 }
	}catch (SQLException e) {
		errorMsgs.add("SQL 에러: " + e.getMessage());
	} finally {
		// 무슨 일이 있어도 리소스를 제대로 종료
		if (rs != null) try{rs.close();} catch(SQLException e) {}
		if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		if (conn != null) try{conn.close();} catch(SQLException e) {}
	}

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
</head>
<body>
<div class = "header">
	<span class= "menuButton"><a href="url"><img src ="imgs/menuButton.png" alt = "MenuBar"></a></span>
	<span class = "siteName"><a href="url->main"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>
<div class = "line"></div>
	<%
 if (errorMsg != null && errorMsg.length() > 0 ) {
    // SQL 에러의 경우 에러 메시지 출력
    out.print("<div class='alert'>" + errorMsg + "</div>");
 } else if (result == 1){
 %>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 		<div class="alert alert-success">
	 			<b><%= dbname %></b>님 환영합니다.
	 		</div>
		 	<div class="form-action">
		 		<a href="userManage.jsp" class="btn">목록으로</a>
		 	</div>
	 		
<%}%>
</body>
</html>