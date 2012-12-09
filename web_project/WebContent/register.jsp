s<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
String[][] genders = {{"M", "남성"}, {"F", "여성"}};

	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	String pwd_confirm = request.getParameter("pwd_confirm");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (userid == null || userid.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	} else{	
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement("SELECT userid FROM users WHERE userid = ?");
			stmt.setString(1, userid);
			rs = stmt.executeQuery();
			if(rs.next()){
				errorMsgs.add("중복된 ID입니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
	
		
	if (pwd == null || pwd.length() < 6) {
			errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
	} 	
	
	if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	}
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	if (errorMsgs.size() == 0) {
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO users(userid, name, pwd, email, gender) " +
					"VALUES(?, ?, ?, ?, ?)"
					);
			stmt.setString(1,  userid);
			stmt.setString(2,  name);
			stmt.setString(3,  pwd);
			stmt.setString(4,  email);
			stmt.setString(5,  gender);
					
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
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
	<% if (errorMsgs.size() > 0) { %>
			<div class="alert alert-error">
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>

 			 <form class="form-horizontal" action="signup.jsp" method="post">
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
					<a href="loginPage.jsp" class="btn">목록으로</a>
					
						<input type="submit" class="btn btn-primary" value="가입"/>
						<input type="reset" class="btn btn-danger" value="입력 취소"/>

				</div>
		  </form>
 			
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= name %></b>님 등록해주셔서 감사합니다.
	 		</div>
		 	<div class="form-action">
		 		<a href="userManage.jsp" class="btn">목록으로</a>
		 	</div>
	 		
	 	<%}%>
	
</body>
</html>