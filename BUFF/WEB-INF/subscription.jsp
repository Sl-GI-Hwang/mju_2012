<%@ page contentType="text/html ; charset=utf-8" errorPage="DBError.jsp" %>
<%@ page import="java.sql.*"%>
<%
	String Date = request.getParameter("Date");
	String Title = request.getParameter("Title");
	String Text = request.getParameter("Text");
	if (Title == null) {
		throw new Exception("제목을 입력하세요");
	} else if (Text == null) {
		throw new Exception("내용을 입력하세요");
	}
	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/webPj", "root", "tiger");
		if (conn == null) 
			throw new Exception ("DB ERROR");
		stmt = conn.createStatement();
		String command = String.format("insert into Picture"
				+ "(Title, Text) values ('%s', '%s');", Title, Text);
	} finally {
		try {
			stmt.close();
		} catch (Exception ignored) {
		} try {
			conn.close();
		}
		catch (Exception ignored) {
		}
	}
	response.sendRedirect("subscriptionresult.jsp");
%>