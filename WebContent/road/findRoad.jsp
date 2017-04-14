<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>

</style>
<script src="/Map/function/function.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link href="/Map/css/roadCSS.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/direction.png" />
<title>Direction</title>
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

	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	<div id="map"></div>
	<div id="panel"></div>
	<script type="text/javascript">
		var iconPosition = "/Map/img/pointer.png";
		var ctu = {lat: 10.029752243559091, lng: 105.76855659484863 };
			
		//INIT MAP
		function initMap() {
			map = new google.maps.Map(document.getElementById('map'), {
				zoom : 14,
				center : ctu,
				mapTypeId : 'terrain'
			});
			
			//Dich vu tim duong google
			var directionsService = new google.maps.DirectionsService();
			var directionsDisplay = new google.maps.DirectionsRenderer();
			
			var i=0; //Trang thai diem dau cuoi: i=0-> diem bat dau, i=1-> diem cuoi
			
			//them marker khi click chuot tren ban do
			map.addListener('click', function(event) {
				addMarker(event.latLng, iconPosition, null, event.latLng.lat()
							+ "<br>" + event.latLng.lng());
				if (i==0){
					hideShowPath(directionsDisplay);
					startPoint=event.latLng;
					i=1;
				} else {
					endPoint=event.latLng;
					findRoad(startPoint, endPoint, directionsService, directionsDisplay);
					deleteMarkers();
					i=0;
				}
			});
			
			searchBox();
		}
		
		//tim duong di
		function findRoad(startP, endP) {
			var directionsService = new google.maps.DirectionsService();
			var directionsDisplay = new google.maps.DirectionsRenderer();
			directionsDisplay.setMap(map);
			directionsDisplay.setPanel(document.getElementById('panel'));

			var request = {
				origin : startP,
				destination : endP,
				travelMode : google.maps.DirectionsTravelMode.DRIVING
			};

			directionsService.route(request, function(response, status) {
				if (status == google.maps.DirectionsStatus.OK) {
					directionsDisplay.setDirections(response);
				}
			});
		}

		//an duong di da ve
		function hideShowPath(directionsDisplay) {
		    directionsDisplay.setMap(null);
		}  
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=initMap">		
	</script>
</body>
</html>