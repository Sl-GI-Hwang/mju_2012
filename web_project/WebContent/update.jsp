<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	request.setCharacterEncoding("utf-8");

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	
	if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
		errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
	}

	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE users " +
					"SET  userid=?, name=?, email=?,  gender=?" +
					"WHERE id=?"
					);
			stmt.setString(1,  userid);
			stmt.setString(2,  name);
			stmt.setString(3,  email);
			stmt.setString(4,  gender);
			stmt.setInt(5,  id);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("변경에 실패하였습니다.");
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
<title>개인 정보 관리</title>
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
		정보 수정
	</div>
<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= name %></b>님 정보가 수정되었습니다.
	 		</div>
		 	<div class="form-action">
		 		<a href="userManage.jsp" class="btn">목록으로</a>
		 	</div>
<%}%>
</body>
</html>