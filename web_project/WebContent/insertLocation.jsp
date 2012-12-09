<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%

	String sessionID = (String) session.getAttribute("userid");
	int sessID = 0;
	if (session.getAttribute("id") != null) {
		sessID = (Integer) session.getAttribute("id");
	}

	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String getSessionID = sessionID;
	String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
	String dbUser = "web";
	String dbPassword = "project";
	
	request.setCharacterEncoding("utf-8");
	String name1 = request.getParameter("name1");
	String name2 = request.getParameter("name2");
	String name3 = request.getParameter("name3");
	String address = request.getParameter("address");
	String lat = request.getParameter("lat");
	String lon = request.getParameter("lon");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			stmt.setString(1,  name1);
			stmt.setString(2,  name2);
			stmt.setString(3,  name3);
			stmt.setString(4,  address);
			stmt.setString(5,  lat);
			stmt.setString(6,  lon);
					
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>