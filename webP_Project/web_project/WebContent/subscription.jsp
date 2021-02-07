<%@ page contentType="text/html ; charset=utf-8" errorPage="DBError.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	
	request.setCharacterEncoding("utf-8");
	int maxSize = 1024*1024*10;
	String uploadPath = "";
	String encType = "utf-8";
	String savefile = "imgFile";
	ServletContext scontext = getServletContext();
	uploadPath = scontext.getRealPath(savefile);
	MultipartRequest multi = null;
	multi = new MultipartRequest(request, uploadPath, maxSize,
			encType, new DefaultFileRenamePolicy());
	
	String userid = (String)session.getAttribute("userid");
	System.out.println(uploadPath+"가 경로");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	

	try {
		
		String Date = multi.getParameter("Date");
		String Title = multi.getParameter("Title");
		String Text = multi.getParameter("Text");
		
		Enumeration files = multi.getFileNames();
		
		String file = (String)files.nextElement();
		String name = multi.getOriginalFileName(file);
		
		if (Title == null) {
			throw new Exception("제목을 입력하세요");
		} else if (Text == null) {
			throw new Exception("내용을 입력하세요");
		}
				
		   Date today2 = new Date(); //java.util 패키지의 Date 클래스를 이용
		   out.println(today2.toString());
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/picorhood", "web", "project");
		if (conn == null) 
			throw new Exception ("DB ERROR");
		stmt = conn.prepareStatement(
				"INSERT INTO picture(Title, Text, pictureName, userid, Date) " +
				"VALUES(?, ?, ?, ?, now())"
				);
		stmt.setString(1,  Title);
		stmt.setString(2,  Text);
		stmt.setString(3,  name);
		stmt.setString(4,  userid);
		
	//	String command = String.format("insert into Picture"
		//		+ "(Title, Text, pictureName, userid, ) values ('%s', '%s', '%s', '%s'", Title, Text, name, userid + ", now())");
		System.out.println(stmt);
		int rownum = stmt.executeUpdate();
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
	response.sendRedirect("mainPage.jsp");
%>