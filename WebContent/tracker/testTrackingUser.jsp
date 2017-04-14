<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="control.tracker.*"%>
<%@ page import="org.json.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<title>Test function</title>
<link href="/Map/css/mapCSS.css" rel="stylesheet">
<script src="/Map/function/function.js" /></script>
<script src="/Map/function/Sha1Digest.js" /></script>
<style>
body {
	top: 50px;
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
	
	<!--<div id="floating-panel">
		<input onclick="clearMarkers();" type=button value="Hide Markers">
		<input onclick="showMarkers();" type=button value="Show All Markers">
		<input onclick="deleteMarkers();" type=button value="Delete Markers">
	</div> -->
	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	<div id="map"></div>
	<!-- <p>Click on the map to add markers.</p>  -->

<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript">

		var latCenter = 10.032414580381667;
		var lngCenter = 105.7749938964843;
		var icon = "/Map/img/blue_gps.png";
		var iconPosition = "/Map/img/red-location-icon.png";
		var username = "${username}";
		var saltKey = "1234"
		var salt = getSalt("getAllUser",username,saltKey);
		//document.write(username+"<br>"+salt);
		//INIT MAP
		function initMap() {
			var ctu = {
				lat : latCenter,
				lng : lngCenter
			};

			map = new google.maps.Map(document.getElementById('map'), {
				zoom : 15,
				center : ctu,
				mapTypeId : 'terrain'
			});

			// This event listener will call addMarker() when the map is clicked.
			map.addListener('click', function(event) {
				addMarker(event.latLng, iconPosition, null, event.latLng.lat() + "<br>"
						+ event.latLng.lng());
			});

			//map.setCenter(new google.maps.LatLng(latCenter, lngCenter));
			//tracker();
			
			var listObj={};
			function startTime() {				
				//Lay danh sach user 
				//var listObj=${listObj};
				deleteMarkers();
				
				$.getJSON('http://localhost:8080/Map/api/getAllUserTrack/',
						function(data) {
							listObj = data;
						});
				for (var i=0; i<listObj.length; i++){
					//neu trang thai la on
					if (listObj[i].status=="on"){
						var nameObj = listObj[i].name;
						var latObj = parseFloat(listObj[i].lat);
						var lngObj = parseFloat(listObj[i].lng);
						var locationObj = {
								lat : latObj,
								lng : lngObj
						};
						addMarker(locationObj, icon , nameObj+"", "<a href=\"/Map/user/"+nameObj+"\">"+nameObj+"</a><br>"+locationObj.lat+"<br>"+locationObj.lng);
					}
				}
					
				var t = setTimeout(startTime, 10000);
			}
			startTime();
			
			//Hien thi search box
			searchBox();

		}

	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=initMap">		
	</script>
	
</body>
</html>