<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<link href="css/main.css" rel="stylesheet">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<div class = "header">
	<span class= "menuButton"><a href="url"><img src ="imgs/menuButton.png" alt = "MenuBar"></a></span>
	<span class = "siteName"><a href="url->main"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>
<div class = "line"></div>
	<div id = "explain">
		로그인 해주세요^ ^
	</div>
	<form class="form-horizontal" action="login.jsp" method="post">
	  <div class="control-group">
	    <label class="control-label" for="userid">ID</label>
	    <div class="controls">
	      <input type="text" name="userid" placeholder="ID">
	    </div>
	  </div>
	  <div class="control-group">
	    <label class="control-label" for="pwd">Password</label>
			<div class="controls">
				<input type="password" name="pwd" placeholder="Password">
				
			</div>
	  </div>
	  <div class="control-group">
	    <div class="controls">
	      <label class="checkbox">
	        <input type="checkbox"/> Remember me
	      </label>
	      <button type="submit" class="btn">Log in</button>
	      <a href="signup.jsp"><button type="button" class="btn">sign in</button></a>
	    </div>
	  </div>
	</form>
</body>
</html>