<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	String sessionID = (String)session.getAttribute("userid");
	int sessID = 0;
	if(session.getAttribute("id") != null){
		sessID = (Integer)session.getAttribute("id");
	}  

  String errorMsg = null;

  String actionUrl;
  // DB 접속을 위한 준비
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
    
  // 사용자 정보를 위한 변수 초기화
  String name = "";
  String title = "";
  String date = "";
  String fileName = "";
  
  // Request로 ID가 있는지 확인
  int pictureId = 0;
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
      stmt = conn.prepareStatement("SELECT * FROM picture WHERE pictureid = ?");
      stmt.setInt(1, pictureId);
      
      // 수행
      rs = stmt.executeQuery();
      
      if (rs.next()) {
        name = rs.getString("Title");
        title = rs.getString("Text");
        date = rs.getString("Date");
        fileName = rs.getString("pictureName");
      }
    }catch (SQLException e) {
      errorMsg = "SQL 에러: " + e.getMessage();
    } finally {
      // 무슨 일이 있어도 리소스를 제대로 종료
      if (rs != null) try{rs.close();} catch(SQLException e) {}
      if (stmt != null) try{stmt.close();} catch(SQLException e) {}
      if (conn != null) try{conn.close();} catch(SQLException e) {}
    }
  } else {
    errorMsg = "사진이 지정되지 않았습니다.";
  }
%>    

<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset = "utf-8"/>
	<meta name = "viewport" content = "width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<title>pictureExpand.html</title>
	<link href="main.css" rel="stylesheet" type = "text/css">
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
</div><br/>
	<div id = "explain">
		클릭한 해당 사진 입니다. 
	</div>
	<div id = "imageExpand">
		<p><img src ="imgFile/<%=fileName%>" alt = "사진"  style ="width:65%" style="height:65%"></p>
		<p class="pictureInfo">
			<div style="float:left"><img src="./imgs/star.png" alt = "관심마크" width="15" height="15">INTEREST수   
			<button class="btn-interest" type="button">관 심</button>  </div>
			 <!--  시간이랑 거리는 소스를 찾아봐야합니다. java scrip나 jsp서야할 듯? -->
			<div style="float:right"><%=date%>   <img src="./imgs/globe_af.png" alt = "지구-거리표시아이콘" width="15" height="15">"거리"</div>
		<%
		if (pictureId > 0) {
		    try {
		      Class.forName("com.mysql.jdbc.Driver");

		      // DB 접속
		      conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/picorhood", "web", "project");

		      // 질의 준비
		      stmt = conn.prepareStatement("SELECT * FROM comment WHERE pictureid = ?");
		      stmt.setInt(1, pictureId);
		      
		      // 수행
		      rs = stmt.executeQuery();
		      
		%>
		<br/>
		<div style="text-align:left">
		<%while(rs.next()){ %>
		<table class = table>
			<tbody>
				<tr>
					<td><%=rs.getString("userid")%> :  <%=rs.getString("Text")%> -    <%=rs.getString("date") %></td>
				</tr>
			</tbody>
		</table>
		<%}%>
		</div>
		<form action="comment.jsp" method="post">
		<input type="hidden" value="<%=pictureId %>" name="pictureid"/>
		<p>댓글 : <input type="Text" name="text" placeholder="댓글 달기..." style = "width:60%"> <button class="btn" type="Submit">확인</button></p>
		</form>
		<%
		    }catch (SQLException e) {
		        errorMsg = "SQL 에러: " + e.getMessage();
		      } finally {
		        // 무슨 일이 있어도 리소스를 제대로 종료
		        if (rs != null) try{rs.close();} catch(SQLException e) {}
		        if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		        if (conn != null) try{conn.close();} catch(SQLException e) {}
		      }
		    } else {
		      errorMsg = "댓글 오류 ";
		    }
		%>
	</div>
	<div class="reply"></div>
</body>
</html>