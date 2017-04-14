<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body> 
	<script type="text/javascript">
		var iconPosition = "/Map/img/pointer.png";
		var ctu = {lat: 10.029752243559091, lng: 105.76855659484863 };
		var s = {lat: 10.015869704339611, lng: 105.75995206832886};
		var e = {lat: 10.027343443770915, lng: 105.76967239379883};
			
		//INIT MAP
		function initMap() {
			
			var calcRoute = function(origin,destination,cb) {
			    var dist;
			    var directionsDisplay;
			    var directionsService = new google.maps.DirectionsService();
			    directionsDisplay = new google.maps.DirectionsRenderer();
			  var request = {
			    origin:origin,
			    destination:destination,
			    travelMode: google.maps.DirectionsTravelMode.DRIVING
			  };
			  directionsService.route(request, function(response, status) {
			    if (status == google.maps.DirectionsStatus.OK) {
			      directionsDisplay.setDirections(response);
			      cb(null, response.routes[0].legs[0].distance.value / 1000);
			    }
			    else {
			      cb('pass error information');
			    }
			  });
			};
			/*calcRoute("-7.048357, 110.418877","-7.048443, 110.441022", function (err, dist) {
			    if (!err) {        
			    	$scope.resto = dist;
			    }
			    document.getElementById('distance').innerHTML = resto +" km";
			});*/
		}
		
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=initMap">		
	</script>
	<div id="distance"></div>
	<div id="distanceReturn"></div>
</body>
</html>