<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils" %>
<%
  String[][] genders = {{"M", "남성"}, {"F", "여성"}};
  
  String errorMsg = null;

  String actionUrl;
  // DB 접속을 위한 준비
  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
  
  String dbUrl = "jdbc:mysql://localhost:3306/picorhood";
  String dbUser = "web";
  String dbPassword = "project";
  
  // 사용자 정보를 위한 변수 초기화
  String userid = "";
  String name = "";
  String pwd = "";
  String email = "";
  String gender = "";


  // Request로 ID가 있는지 확인
  int id = 0;
  try {
    id = Integer.parseInt(request.getParameter("id"));
  } catch (Exception e) {}

  if (id > 0) {
    try {
        Class.forName("com.mysql.jdbc.Driver");

        // DB 접속
      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

      // 질의 준비
      stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
      stmt.setInt(1, id);
      
      // 수행
      rs = stmt.executeQuery();
      
      if (rs.next()) {
        userid = rs.getString("userid");
        name = rs.getString("name");
        pwd = rs.getString("pwd");
        email = rs.getString("email");
        gender = rs.getString("gender");
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
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 보기</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
</head>
<body>
<div class = "header">
	<span class= "menuButton"><a href="url"><img src ="imgs/menuButton.png" alt = "MenuBar"></a></span>
	<span class = "siteName"><a href="url->main"><img src = "imgs/SiteLogo.png" alt = "Site Logo"></a></span>
</div>

	<div id = "explain">
		회원 정보
	</div>
	<%
 if (errorMsg != null && errorMsg.length() > 0 ) {
    // SQL 에러의 경우 에러 메시지 출력
    out.print("<div class='alert'>" + errorMsg + "</div>");
 } else {
 %>
    <div>
      <!-- XSS (Cross-site scripting)의 위험이 있는 안좋은 코드의 예  --> 
      <h3><%=name %></h3>
      <ul>
        <li>User ID: <%=userid %></li>
        <li>Email: <a href="mailto:<%=email%>"><%=email %></a></li>
        <li>Gender: 
          <% for (String[] arr: genders) {
        	  if (arr[0].equals(gender)) {
        		  out.println(arr[1]);
        	  }
          } %>
        </li>
      </ul>
    </div>      
<% } %>
  
	  <div class="form-actions">
	    <a href="userManage.jsp" class="btn">목록으로</a>
	    <% if (id > 0) { %>
  	    <a href="signup.jsp?id=<%=id %>" class="btn btn-primary">수정</a>
	     <a href="#" class="btn btn-danger" data-action="delete" data-id="<%=id %>" >삭제</a>
	    <% } %>
	  </div>
		<script>
		  $("a[data-action='delete']").click(function() {
		    if (confirm("정말로 삭제하시겠습니까?")) {
		      location = 'delete.jsp?id=' + $(this).attr('data-id');
		    }
		    return false;
		  });
		</script>  
</body>
</html>