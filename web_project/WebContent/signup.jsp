<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<% 
	String[][] genders = {{"M", "남성"}, {"F", "여성"}};
	
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	String userid = "";
	String name = "";
	String pwd = "";
	String email = "";
	String gender = "";
	
	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "update.jsp";
		try {
		    Class.forName("com.mysql.jdbc.Driver");

		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
			stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				userid = rs.getString("userid");
				name = rs.getString("name");
				pwd = rs.getString("pwd");
				email = rs.getString("email");
				gender = rs.getString("gender");
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	} else {
		actionUrl = "register.jsp";
	}
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content = "width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>회원등록</title>
	<link href="css/main.css" rel="stylesheet">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<div class = "header">
	<span class= "menuButton"><a href="url"><img src ="imgs/menuButton.png" alt = "MenuBar"></a></span>
	<span class = "siteName"><a href="mainPage.jsp"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>
	<div id = "explain">
		회원 등록
	</div>
	
	  <div>
	 	<%
		 if (errorMsg != null && errorMsg.length() > 0 ) {
				// SQL 에러의 경우 에러 메시지 출력
				out.print("<div class='alert'>" + errorMsg + "</div>");
		 }
		%>
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<div class="control-group">
					<label class="control-label" for="userid">ID</label>					
					<div class="controls">
						<input type="text" name="userid" value="<%=userid%>">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="name">Name</label>
					<div class="controls">
						<input type="text" placeholder="홍길동" name="name" value="<%=name%>">
					</div>
				</div>

				<% if (id <= 0) { %>
					<%-- 신규 가입일 때만 비밀번호 입력창을 나타냄 --%>
					<div class="control-group">
						<label class="control-label" for="pwd">Password</label>
						<div class="controls">
							<input type="password" name="pwd">
						</div>
					</div>
	
					<div class="control-group">
						<label class="control-label" for="pwd_confirm">Password Confirmation</label>
						<div class="controls">
							<input type="password" name="pwd_confirm">
						</div>
					</div>
				<% } %>
					
				<div class="control-group">
					<label class="control-label" for="email">E-mail</label>
					<div class="controls">
						<input type="email" placeholder="hong@abc.com" name="email" value="<%=email%>">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Gender</label>
					<div class="controls">
						<% for(String[] genderOption : genders) { %> 
							<label class="radio"> 
							  <input type="radio" value="<%=genderOption[0] %>" name="gender"
							  <% if (genderOption[0].equals(gender)) { out.print("checked");} %>
							  > 
							  <%=genderOption[1] %>
							</label>
						<% } %> 
					</div>
				</div>

				<div class="form-actions">
					<a href="mainPage.jsp" class="btn">목록으로</a>
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-primary" value="가입"/>
						<input type="reset" class="btn btn-danger" value="입력 취소"/>
					<% } else { %>
						<input type="submit" class="btn btn-primary" value="수정">
					<% } %>
						
				</div>
		  </form>
    </div>

</body>
</html>