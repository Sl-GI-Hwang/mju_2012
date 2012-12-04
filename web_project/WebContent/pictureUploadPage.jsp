<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
    <%
    	String id = (String)session.getAttribute("userid");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
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
			<form action = "#" method = "post">
				<p>제목 : <input type="Text" style = "width:60%"></p>
				<p>파일 : <input type="File" style = "width:82%"></p>
				<p><textarea cols="50" rows="10" style ="width:98%; padding:1%" placeholder="사진에 대해" name="aboutPicture"></textarea></p> <!--  style ="width:98%; padding = 1%" 이부분 추가함-> css파일로 옮김  -->
				<p><input class="btn" type="Reset" style="float:right" value="취 소"> <input class="btn" type="Submit" style="float:right" value="사진 업로드"> </p>
			</form>
		</div>
	<% } else {%>
		<div id = "alter">로그인을 하셔야 이용하실 수 있습니다.</div>	
		<a href="loginPage.jsp"><button class="btn" type="button"> 로그인 </button></a>	
	<% }%>
</body>
</html>