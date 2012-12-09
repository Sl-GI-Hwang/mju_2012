<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	session.invalidate();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name = "viewport" content = "width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>로그인</title>
	<link href="css/main.css" rel="stylesheet">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
</head>
<body>
<div class = "header">
	<span class= "menuButton"><a href="url"><img src ="imgs/menuButton.png" alt = "MenuBar"></a></span>
	<span class = "siteName"><a href="mainPage.jsp"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>
	<div class="alert alert-success">
		정상적으로 로그아웃 되었습니다.
	</div>
	<a href="mainPage.jsp" class="btn">HOME</a>
</body>
</html>