<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="control.tracker.*"%>

<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%@ page import="java.util.*, java.io.*"%>
<%@ page import="control.api.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="/Map/function/Sha1Digest.js" /></script>
<title>Insert title here</title>
</head>
<body>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script>
	var user = "user1";
	var pass = "user1"
	var lat = 10.0271321466666;
	var lng = 105.77692508697555;
	
	//login	
	//salt = sha1("api/login/username=<user>&password=<password>")
	var loginStr = "api/login/username="+user+"&password="+pass;
	//var str = getSalt("updateLocation", user, "1234");
	var loginSalt = sha1(loginStr);
	var urlLogin = 'http://localhost:8080/Map/api/login/username='+user+'&salt='+loginSalt;
	
	//update
	var updateSalt = getSalt("updateLocation",user,"1234");
	var urlUpdate= 'http://localhost:8080/Map/api/updateLocation/username='+user+'&lat='+lat+'&lng='+lng+'&salt='+updateSalt;
	
	
	
	var update=null;
	var u = $.getJSON(urlUpdate,
			function(data) {
				update = data;
				//document.write("<br>update: "+ update.result);
				document.getElementById("demo").innerHTML = update.result;
			});
	function getSalt(method, username, salt){
		return sha1(method+username+salt);
	}	
</script>
	<% 
		/*if (session.getAttribute("username")==null){
			out.println("<script type=\"text/javascript\">");
		    out.println("window.location = \"/Map/account/loginForm.html\"");
			out.println("</script>");
		}*/
	%>
	<p id="demo"></p>
	<h3><%out.println(session.getAttribute("username"));
			out.print(session.getAttribute("ip")); %>
	<a href="/Map/account/logout.html">Log out </a>ip: ${ip }</h3>

	
</body>

</html>