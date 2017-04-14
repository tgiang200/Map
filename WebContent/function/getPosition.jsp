<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h2>Position</h2>
	<p>Click the button to get your coordinates.</p>

	<button onclick="getLocation()">Try It</button>

	<p id="demo"></p>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.js"></script>
 <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
	
	<script>
		var x = document.getElementById("demo");
		var pp;
		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(showPosition);
			} else {
				x.innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		
		var pp = new google.maps.LatLng();
		function showPosition(position){
			var g = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			//document.writeln("lat: "+g);
			pp=g;
			//x.innerHTML = "lat: "+g;
			//x.innerHTML = "lat p: "+pp;
			//return pp;
		}
		//var p = new google.maps.LatLng(getLocation());
		getLocation();
		//showLocation(pp);
		x.innerHTML="pp: "+pp;

	</script>
</body>
</html>