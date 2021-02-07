<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	request.setCharacterEncoding("utf-8");
	String rs_pictureid = "";
	String userid = request.getParameter("sessionID");
	 int pictureid = 0;
	  try {
	    pictureid = Integer.parseInt(request.getParameter("pictureid"));
	  } catch (Exception e) {}
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (errorMsgs.size() == 0) {
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO interest(pictureid, userid, interest_flag) " +
					"VALUES(?, ?, 1)"
					);
			stmt.setInt(1,  pictureid);
			stmt.setString(2,  userid);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
	
	try {
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement(
				"SELECT * FROM comment WHERE pictureid = ?"
				);
		stmt.setInt(1,  pictureid);
		rs = stmt.executeQuery();
		while(rs.next()){
			rs_pictureid = rs.getString("pictureid");
		}
		
	} catch (SQLException e) {
		errorMsgs.add("SQL 에러: " + e.getMessage());
	} finally {
	// 무슨 일이 있어도 리소스를 제대로 종료
	if (rs != null) try{rs.close();} catch(SQLException e) {}
	if (stmt != null) try{stmt.close();} catch(SQLException e) {}
	if (conn != null) try{conn.close();} catch(SQLException e) {}
	}

	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
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
	회원 등록
</div>
	<% if (errorMsgs.size() > 0) { %>
			<div class="alert alert-error">
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>

	 	<% } else if (result == 1) { 
	 		
	 		response.sendRedirect("pictureExpand.jsp?pictureid="+rs_pictureid); 
	 		
	 	}%>
	
</body>
</html>