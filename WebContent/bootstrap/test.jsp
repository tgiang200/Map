<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href="/Map/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/Map/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet">

<style>
body {
	padding: 70px 0px;
}
</style>

<title>Test bootstrap</title>
</head>
<body>


	<!-- nenu -->
	<nav class="navbar navbar-inverse navbar-fixed-top"> 
		<%@include file="jsp/menu.jsp"%> 
	</nav>
	
	<div class="container">
		<%@include file="../road/findRoad.jsp"%> 
	</div>
	<!-- /.container -->


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/Map/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>