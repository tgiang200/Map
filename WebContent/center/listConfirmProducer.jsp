<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/cssTable.css" rel="stylesheet">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<script>
	var listProducer = ${listProducer};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<tr> <th>Store name</th> <th>Address</th> <th>Full name</th> </tr>")
	for (var i=0; i<listProducer.length; i++){
		document.write("<tr>");
		document.write("<td>"+listProducer[i].storeName+"</td>");
		document.write("<td>"+listProducer[i].address+"</td>");
		document.write("<td>"+listProducer[i].fullname+"</td>");
		document.write("</tr>");
	}
	document.write("</table>");
	document.write("</div>");
</script>
</body>
</html>