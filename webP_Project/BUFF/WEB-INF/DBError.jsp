<%@ page language="java" contentType="text/html; charset=UTF-8"
   isErrorPage = "true"%>
<% response.setStatus(200); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ERROR</title>
</head>
<body>
	<h3> DB ERROR</h3>
	ERROR MSG : <%= exception.getMessage() %>
</body>
</html>