<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%

int sessID = 0;
if(session.getAttribute("id") != null){
	sessID = (Integer)session.getAttribute("id");
}
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
	String pwd = request.getParameter("pwd");
	String pwd_confirm = request.getParameter("pwd_confirm");
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
	
	if (pwd == null || pwd.length() < 6) {
		errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
	} 	
	
	if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	}
	
System.out.println(id);
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE users " +
					"SET  name=?, pwd=?, email=?, gender=?" +
					"WHERE userid=?"
					);
			stmt.setString(1,  name);
			stmt.setString(2,  pwd);
			stmt.setString(3,  email);
			stmt.setString(4,  gender);
			stmt.setString(5,  userid);
			
			System.out.println(stmt);
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
	<div class = "btn-group" style=float:left>
 		 <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" href="#">
   			<img src ="imgs/menuButton.png" width="30" height="30" alt = "MenuBar">
  		 </a>
  			<ul class="dropdown-menu">
    			<li><a href="#">MY PAGE</a></li>
    			<li class="divider"></li>
    			<li><a href="userShow.jsp?id=<%=sessID%>">개인 정보</a></li>
    			<li><a href="#">위치 설정</a></li>
    			<li><a href="pictureManager.jsp?id=<%=sessID%>">사진 관리</a></li>
    			<li><a href="#">이웃 관리</a></li>
    			<li><a href="#">회워 탈퇴</a></li>
    			<li class="divider"></li>
    			<li><a href="#">관심 위치 사진</a></li>
    			<li class="divider"></li>
    			<li><a href="#">주위 사진</a></li>
    			<li class="divider"></li>
    			<li><a href="#">이웃 사진</a></li>
    			<li class="divider"></li> 
    			<li><a href="userManage.jsp">회원 관리 페이지</a></li>   			
  			</ul>
	</div>
	
	<div class = "siteName" style=float:right><a href="mainPage.jsp"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></div>
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
		 		<a href="mainPage.jsp" class="btn">목록으로</a>
		 	</div>
<%}%>
</body>
</html>