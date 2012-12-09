<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"
	import="org.apache.commons.lang3.StringUtils"%>

<%
	String sessionID = (String) session.getAttribute("userid");
	int sessID = 0;
	if (session.getAttribute("id") != null) {
		sessID = (Integer) session.getAttribute("id");
	}
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String getSessionID = sessionID;
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<link href="css/main.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<div class="header">
		<div class="btn-group" style="float: left">
			<a class="btn btn-success dropdown-toggle" data-toggle="dropdown"
				href="#"> <img src="imgs/menuButton.png" width="30" height="30"
				alt="MenuBar">
			</a>
			<ul class="dropdown-menu">
				<li><a href="#">MY PAGE</a></li>
				<li class="divider"></li>
				<li><a href="userShow.jsp?id=<%=sessID%>">개인 정보</a></li>
				<li><a href="#">위치 설정</a></li>
				<li><a href="pictureManage.jsp?id=<%=sessID%>">사진 관리</a></li>
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

		<div class="siteName" style="float: right">
			<a href="mainPage.jsp"><img src="imgs/SiteLogo.png"
				alt="Site Logo"></a>
		</div>
	</div>
	<div id="login">
		<p class="mainbutton">
			<a href="pictureUploadPage.jsp" class="btn" type="button"> 사진 업로드
			</a>
			<%
				if (sessionID == null) {
			%>
			<a href="loginPage.jsp"><button class="btn" type="button">
					로그인</button></a>
			<%
				} else {
			%>
			<a href="logout.jsp"><button class="btn" type="button">
					로그아웃</button></a>
			<%
				}
			%>
		</p>
	</div>
	<br />
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");

			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.createStatement();
			rs = stmt
					.executeQuery("SELECT pictureID, pictureName FROM picture WHERE userid = '" + sessionID+ "'");
	%>
	<div id="photoFilter">
		<ul style="list-style-type: none" class="thumbnalils">
			<%
				while (rs.next()) {
			%>
			<li class="span3"><a
				href="pictureExpand.jsp?pictureid=<%=rs.getInt("pictureid")%>"
				class="thumbnail"> <img
					src="imgFile/<%=rs.getString("pictureName")%>" width=75px height=75px alt="사진"></a></li>
			<%
				}
			%>
		</ul>
	</div>

	<%
		} catch (SQLException e) {
			// SQL 에러의 경우 에러 메시지 출력
			out.print("<div class='alert'>" + e.getLocalizedMessage()
					+ "</div>");
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
				}
		}
	%>

</body>
</html>