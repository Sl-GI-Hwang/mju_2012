<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>     
<%
int sessID = 0;
if(session.getAttribute("id") != null){
	sessID = (Integer)session.getAttribute("id");
}
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