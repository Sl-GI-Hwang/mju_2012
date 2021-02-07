<%@ page contentType="text/html ; charset=utf-8" errorPage="DBError.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	request.setCharacterEncoding("utf-8");
	int maxSize = 1024*1024*10;
	String realFolder = "";
	String encType = "utf-8";
	String savefile = "file";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath(savefile);
	MultipartRequest multi = null;
	multi = new MultipartRequest(request, realFolder, maxSize,
			encType, new DefaultFileRenamePolicy());
	
	
	Connection conn = null;
	Statement stmt = null;
	

	try {
		
		String Date = multi.getParameter("Date");
		String Title = multi.getParameter("Title");
		String Text = multi.getParameter("Text");
		
		Enumeration files = multi.getFileNames();
		
		String file = (String)files.nextElement();
		String name = multi.getFilesystemName(file);

		Enumeration params = multi.getParameterNames();
		
		if (Title == null) {
			throw new Exception("제목을 입력하세요");
		} else if (Text == null) {
			throw new Exception("내용을 입력하세요");
		}
				
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/webPj", "root", "tiger");
		if (conn == null) 
			throw new Exception ("DB ERROR");
		stmt = conn.createStatement();
		String command = String.format("insert into Picture"
				+ "(Title, Text) values ('%s', '%s');", Title, Text);
		int rownum = stmt.executeUpdate(command);
		if (rownum < 1)
			throw new Exception("Data를 DB에 입력불가");
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
	response.sendRedirect("subscriptionResult.jsp");
%>