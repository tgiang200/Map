<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Roads API Demo</title>
<style>
html, body, #map {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#panel {
	position: absolute;
	top: 5px;
	left: 50%;
	margin-left: -180px;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
}

#bar {
	width: 240px;
	background-color: rgba(255, 255, 255, 0.75);
	margin: 8px;
	padding: 4px;
	border-radius: 4px;
}

#autoc {
	width: 100%;
	box-sizing: border-box;
}
</style>

<link rel="shortcut icon" href="">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places"></script>
<script>
	var apiKey = 'AIzaSyCDC4g4geThbsfUtCd9Vj9i7firr9q59SM';

	var map;
	var drawingManager;
	var placeIdArray = [];
	var polylines = [];
	var snappedCoordinates = [];

	function initialize() {
		var mapOptions = {
			zoom : 17,
			center : {
				lat : -33.8667,
				lng : 151.1955
			}
		};
		map = new google.maps.Map(document.getElementById('map'), mapOptions);

		// Adds a Places search box. Searching for a place will center the map on that
		// location.
		map.controls[google.maps.ControlPosition.RIGHT_TOP].push(document
				.getElementById('bar'));
		var autocomplete = new google.maps.places.Autocomplete(document
				.getElementById('autoc'));
		autocomplete.bindTo('bounds', map);
		autocomplete.addListener('place_changed', function() {
			var place = autocomplete.getPlace();
			if (place.geometry.viewport) {
				map.fitBounds(place.geometry.viewport);
			} else {
				map.setCenter(place.geometry.location);
				map.setZoom(17);
			}
		});

	$(window).load(initialize);
	
</script>
</head>

<body>
	<div id="map"></div>
	<div id="bar">
		<p class="auto">
			<input type="text" id="autoc" />
		</p>
		<p>
			<a id="clear" href="#">Click here</a> to clear map.
		</p>
	</div>
</body>
</html>



