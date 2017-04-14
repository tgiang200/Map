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
	<h1>Getting your location...</h1>
	<h2>Share your location?</h2>
	<p id="demo"></p>
	<script>
		var lat;
		var lng;
		var x = document.getElementById("demo");
		function showPosition(position) {
			latf = position.coords.latitude;
			lngf = position.coords.longitude;
			window.lat=latf;
			window.lng=lngf;
			/*var f = document.createElement("form");
			f.setAttribute('method',"post");
			f.setAttribute('action',"/Map/tracker/showMap.html");

			var i = document.createElement("input"); //input element, text
			i.setAttribute('type',"lable");
			i.setAttribute('name',"lat");
			i.setAttribute('value',lat);

			var j = document.createElement("input"); //input element, text
			j.setAttribute('type',"lable");
			j.setAttribute('name',"lng");
			j.setAttribute('value',lng);

			
			var s = document.createElement("input"); //input element, Submit button
			s.setAttribute('type',"submit");
			s.setAttribute('value',"Accept");

			f.appendChild(i);
			f.appendChild(j);
			f.appendChild(s);

			//and some more input elements here
			//and dont forget to add a submit button

			document.getElementsByTagName('body')[0].appendChild(f);
			*/
			x.innerHTML = ("<h2><a href=\"/Map/tracker/showMap.html?lat="+lat+"&lng="+lng+"\">Accept</a></h2>"
							+"<h2><a href=\"/Map/tracker/mapTracker.html\">Cancel</a></h2>");
			//x.innerHTML = lat+"-"+lng;
		}
		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(showPosition);
				
			} else {
				x.innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		getLocation();

	</script>
</center>
</body>
</html>