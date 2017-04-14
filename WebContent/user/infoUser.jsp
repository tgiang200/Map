<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="/Map/css/cssTable.css" rel="stylesheet">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
<%@include file="../include/menu.jsp"%> 
<script>
	var info = ${user};
	document.write("<div id=\"info\">");
	for (var i=0; i<info.length; i++){
		document.write("<table>");
		document.write("<h3>Infomation</h3>");
		document.write("<tr><td>Name</td>");
		document.write("<td>"+info[i].name+"</td></tr>");
		document.write("<tr><td>Status</td>");
		document.write("<td>"+info[i].status+"</td></tr>");
		document.write("<tr><td>Latitude</td>");
		document.write("<td>"+info[i].lat+"</td></tr>");
		document.write("<tr><td>Longitude</td>");
		document.write("<td>"+info[i].lng+"</td></tr>");
		document.write("<tr><td>Date of birth</td>");
		document.write("<td>"+""+"</td></tr>");
		document.write("<tr><td>Phone</td>");
		document.write("<td>"+""+"</td></tr>");
		document.write("<tr><td>Email</td>");
		document.write("<td>"+""+"</td></tr>");
		document.write("<tr><td>Address</td>");
		document.write("<td>"+""+"</td></tr>");
		document.write("</table>");
	}
	document.write("</div>");
</script>
</body>
</html>