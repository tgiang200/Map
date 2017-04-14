<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/tracker.png" />
<style type="text/css">
#logout{
	position: absolute;
	right: 20px;
	top: 0px; 
	font-size: 20;
}
</style>
</head>
<body >
<h1>Welcome <script>document.write(self.location.host)</script></h1>
<div id="logout">
	<% 
		if (session.getAttribute("username")==null){
			out.println("<script type=\"text/javascript\">");
		    out.println("window.location = \"/Map/account/logout.html\"");
			out.println("</script>");
		}
	%>
	<h3 style="color:ForestGreen;"><a href="/Map/user/${username }/">${username }</a>
	<a href="/Map/account/logout.html">Log out</a></h3>
</div>
</body>
</html>