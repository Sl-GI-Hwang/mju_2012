<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
  
  String errorMsg = null;

  String actionUrl;
  // DB 접속을 위한 준비
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
    
  // 사용자 정보를 위한 변수 초기화
  String name = "";
  String title = "";
  String content = "";

  // Request로 ID가 있는지 확인
  int id = 0;
  try {
    id = Integer.parseInt(request.getParameter("id"));
  } catch (Exception e) {}

  if (id > 0) {
    try {
      Class.forName("com.mysql.jdbc.Driver");

      // DB 접속
      conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/picorhood", "web", "tiger");

      // 질의 준비
      stmt = conn.prepareStatement("SELECT * FROM letters WHERE id = ?");
      stmt.setInt(1, id);
      
      // 수행
      rs = stmt.executeQuery();
      
      if (rs.next()) {
        name = rs.getString("name");
        title = rs.getString("title");
        content = rs.getString("content");
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
    errorMsg = "ID가 지정되지 않았습니다.";
  }
%>    

<!DOCTYPE html>
<html lang = "ko">
<head>
	<meta charset = "utf-8"/>
	<meta meta name = "viewport" content = "width = device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>pictureManage.html</title>
	<link href="main.css" rel="stylesheet" type = "text/css">
</head>
<body>
	<div id = "header">
		<span id= "menuButton"><a href="url"><img src ="./imgs/menuButton.png" alt = "MenuBar" width = "40" height = "40"></a></span>
		<span id = "siteName"><a href="url->main"><img src = "./imgs/siteLogo.png" alt = "Site Logo"  width = "230"></a></span>
	</div>
	<div id = "line"></div>
	<div id = "logout">
		<p class = "mainbutton">
			<button class="btn" type="button"> 사진 업로드 </button> <button class="btn" type="button"> 로그아웃 </button>
		</p>
	</div><br/>
	<div id = "explain">
		사진 관리 페이지 입니다. 
	</div>
	<div id = "photoFilter">
		<p class="style">
			<p>
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
				<img src ="./imgs/defaultImage.PNG" alt = "임시 디폴트 이미지"  style ="width:75px"; style="height:75px">
			</p>
			
		</p>
		 </div>
	
		</p>
	</div>
	<div class="reply"></div>
</body>
</html>