<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"
	import="org.apache.commons.lang3.StringUtils"%>
<%
	String sessionID = (String)session.getAttribute("userid");
	int sessID = 0;
	if(session.getAttribute("id") != null){
		sessID = (Integer)session.getAttribute("id");
	}  

  String errorMsg = null;

  String actionUrl;
    
  // 사용자 정보를 위한 변수 초기화
  String getUserLocation = "";
  int getCount = 0;
  
  // Request로 ID가 있는지 확인
  int pictureId = 0;
  
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
	content="width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<script src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	
</script>

<title>회원 관리</title>
<link href="css/main.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body onload="showData()">
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

		<div class="siteName" style="float: right">
			<a href="mainPage.jsp"><img src="imgs/SiteLogo.png"
				alt="Site Logo"></a>
		</div>
	</div>
	<div id="login">
		<p class="mainbutton">
			<a href="pictureUploadPage.jsp" class="btn" type="button"> 사진 업로드
			</a>
			<% if(sessionID == null){ %>
			<a href="loginPage.jsp"><button class="btn" type="button">
					로그인</button></a>
			<% } else {%>
			<a href="logout.jsp"><button class="btn" type="button">
					로그아웃</button></a>
			<% }%>
		</p>
	</div>
	<br />
	<%
	//DB 접속을 위한 준비
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    pictureId = Integer.parseInt(request.getParameter("pictureid"));
  } catch (Exception e) {}

  if (pictureId > 0) {
    try {
      Class.forName("com.mysql.jdbc.Driver");

      // DB 접속
      conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/picorhood", "web", "project");

      // 질의 준비
      stmt = conn.prepareStatement("SELECT name1, name2, name3 FROM user WHERE userid = ?");
      stmt.setString(1, name1);
      
      // 수행
      rs = stmt.executeQuery();
      
      if (rs.next()) {
        getUserLocation = rs.getString("name1");
      }
      
      stmt = conn.prepareStatement("SELECT pictureID, pictureName FROM picture WHERE upload_Location Like '%"+ getUserLocation +"%' ORDER BY pictureID DESC");
      rs = stmt.executeQuery();
      
      rs.last();
      getCount = rs.getRow();
      
      rs.first();
      System.out.println(getCount);
  	
  %>
	<div id="photoFilter">
		<ul style="list-style-type: none" class="thumbnalils">
			<%while(rs.next()){ %>
			<li class="span3"><a
				href="pictureExpand.jsp?pictureid=<%=rs.getInt("pictureid") %>"
				class="thumbnail"> <img
					src="imgFile/<%=rs.getString("pictureName") %>" alt="사진"></a></li>
			<%} %>
		</ul>
	</div>

	<%

	 	} catch (SQLException e) {
			// SQL 에러의 경우 에러 메시지 출력
			out.print("<div class='alert'>" + e.getLocalizedMessage() + "</div>");
		}finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}

%>

</body>
</html>


