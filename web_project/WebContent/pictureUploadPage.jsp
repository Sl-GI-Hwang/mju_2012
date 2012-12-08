<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
    <%
    	String id = (String)session.getAttribute("userid");
    int sessID = 0;
	if(session.getAttribute("id") != null){
		sessID = (Integer)session.getAttribute("id");
	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>회원 관리</title>
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
    			<li><a href="#">사진 관리</a></li>
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
	<span class = "siteName"><a href="mainPage.jsp"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>
<div id = "explain">
		사진을 올리는 페이지 입니다. 
	</div>
	<div id = "logout">
	<% if(id != null){ %>
		<p class = "mainbutton">
			<a href="logout.jsp" class="btn" type="button"> 로그아웃 </a>
		</p>
		<% } else {%>
			
		<% }%>
	</div><br/>
	
	<% if(id != null){ %>
		<div id = "imageLoad">
			<form action = "subscription.jsp" method = "post" enctype="multipart/form-data">
				<p>제목 : <input type="Text" name = "Title" style = "width:60%"></p>
				<p>파일 : <input type="File" name = "File" style = "width:82%"></p>
				<p><textarea cols="50" rows="10" name = "Text" style ="width:98%; padding:1%" placeholder="사진에 대해" name="aboutPicture"></textarea></p> <!--  style ="width:98%; padding = 1%" 이부분 추가함-> css파일로 옮김  -->
				<p><input class="btn" type="Reset" style="float:right" value="취 소"> <input class="btn" type="Submit" style="float:right" value="사진 업로드"> </p>
			</form>
		</div>
	<% } else {%>
		<div class = "alter">로그인을 하셔야 이용하실 수 있습니다.</div>	
		<a href="loginPage.jsp"><button class="btn" type="button"> 로그인 </button></a>	
	<% }%>
</body>
</html>