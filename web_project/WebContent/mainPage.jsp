<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	String sessionID = (String)session.getAttribute("userid");
	int sessID = 0;
	if(session.getAttribute("id") != null){
		sessID = (Integer)session.getAttribute("id");
	}
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
/*	
	String dbLocation ="";
	int dbLocation_lat =0;
	int dbLocation_lon =0;
	*/
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name = "viewport" content = "width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<script src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
 
var address="";
var name1="";
var name2="";
var name3="";
var lat="";
var lon="";
function showData(){
		  navigator.geolocation.getCurrentPosition( success, fail );
}

 //현재 위치 정보 알아보는 메소드
 //성공시
 function success(position){
  lat=position.coords.latitude; //위도
  lon=position.coords.longitude; // 경도

  searchAddress(lat,lon);
 }
 function searchAddress(lat,lon){
	 $.ajax({
		 url:"http://apis.daum.net/local/geo/coord2addr",
		 type:"get",
		 dataType:"jsonp",
		 data:{
			 "latitude":lat,
			 "longitude":lon,
			 "apikey":"3c5381bd7c05f1688d59189b76328d15319f2fee",
			 "format":"simple",
			 "output":"json"
		 },
		 timeout: 300000,
		 
		 success: function(req){
			 name1 = req.name1;
			 name2 = req.name2;
			 name3 = req.name3;
			 
			 if(name1){
				 address += name1 + " ";
			 }
			 if(name2){
				 address += name2 + " ";
			 }
			 if(name3){
				 address += name3 + " ";
			 }

			 alert("위도는 "+lat+"\n경도는 "+lon+"\n주소는 \n"+address);
			 
		 },
		 
		 
		 error:function(xhr,textStatus,errorThrown){
			 alert("주소검색 실패-\n"+textStatus+"\n(HTTP-"+xhr.status+"/"+errorThrown+")");
		 }
	 
	 
	 });
 }

 //실패시
 function fail(error){
  alert("위치정보 확인 실패!"+error.message);
 }
 

 
</script>

<title>회원 관리</title>
	<link href="css/main.css" rel="stylesheet">
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body onload="showData()">
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
<div id = "login">
		<p class = "mainbutton">
			<a href="pictureUploadPage.jsp" class="btn" type="button"> 사진 업로드 </a> 
			<% if(sessionID == null){ %>
				<a href="loginPage.jsp"><button class="btn" type="button"> 로그인 </button></a>
			<% } else {%>
				<a href="logout.jsp"><button class="btn" type="button"> 로그아웃 </button></a>
			<% }%>
		</p>
</div>
<br/>
<%
	 	try {
		    Class.forName("com.mysql.jdbc.Driver");
	
		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM picture ORDER BY pictureid DESC");
			
%>
<div id = "photoFilter">
	<ul style="list-style-type:none" class ="thumbnalils">
		<%while(rs.next()){ %>
			<li class="span4"><a href="pictureExpand.jsp?pictureid=<%=rs.getInt("pictureid") %>" class="thumbnail">
			<img src="imgFile/<%=rs.getString("pictureName") %>" alt="사진"></a></li>
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