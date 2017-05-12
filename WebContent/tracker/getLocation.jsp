<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/tracker.png" />
<title>Getting location...</title>
<!-- <meta http-equiv="refresh" content="10;/Map/tracker/showMap.html"> -->
<style type="text/css">
#get{
	position: absolute;
	top: 20px;
	left: 50px;
}
body {
	height: 100%;
	margin: 0;
	padding: 100px 0px 0px 0px;
}
</style>
</head>
<body>

<%
	String userType = session.getAttribute("userType").toString();
	pageContext.setAttribute("userType", userType);
%>
<c:choose>
    <c:when test="${userType == 'center'}">
        <%@include file="../include/menu.jsp"%>
    </c:when>
    <c:when test="${userType == 'producer'}">
        <%@include file="../include/menuProducer.jsp"%>
    </c:when>
    <c:when test="${userType == 'shipper'}">
        <%@include file="../include/menuShipper.jsp"%>
    </c:when>
    <c:otherwise>
    	<%@include file="../include/menuShipper.jsp"%>
    </c:otherwise>
</c:choose> 

<center>	
	<h1>Cho phép chia sẽ vị trí?</h1>
	<p id="accept"></p>
	<p id="cancel"></p>
	<script>
		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(getSuccess);
				
			} else {
				x.innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		
		function getSuccess(location){
			//xử lý tọa độ nhận được
			var lat = location.coords.latitude;
			var lng = location.coords.longitude;
			//chuyển kết quả đến controller để hiển thị bản đồ
			document.getElementById("accept").innerHTML = ("<h2><a href=\"/Map/tracker/mapLocation.html?lat="+lat+"&lng="+lng+"\">"+
							"Chia sẽ vị trí</a></h2>");
			document.getElementById("cancel").innerHTML = ("<h2><a href=\"/Map/tracker/mapLocation.html?lat=10.029752243559091&lng=105.76988697052002\">Bỏ qua</a></h2>");
		}
		getLocation();

	</script>
</center>
</body>
</html>