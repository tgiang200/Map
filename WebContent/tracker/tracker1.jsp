<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ page import = "control.tracker.*"%>
<%@ page import = "org.json.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tracker</title>
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#floating-panel {
	position: absolute;
	top: 10px;
	left: 25%;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
}
</style>
</head>
<body>
	<div id="floating-panel">
		<input onclick="clearMarkers();" type=button value="Hide Markers">
		<input onclick="showMarkers();" type=button value="Show All Markers">
		<input onclick="deleteMarkers();" type=button value="Delete Markers">
	</div>
	<div id="map"></div>
	<p>Click on the map to add markers.</p>
	<script>
		// In the following example, markers appear when the user clicks on the map.
		// The markers are stored in an array.
		// The user can then click an option to hide, show or delete the markers.
		var map;
		var markers = [];

		function initMap() {
			var haightAshbury = {
				lat : 10.030901,
				lng : 105.768846
			};

			map = new google.maps.Map(document.getElementById('map'), {
				zoom : 15,
				center : haightAshbury,
				mapTypeId : 'terrain'
			});

			// This event listener will call addMarker() when the map is clicked.
			map.addListener('click', function(event) {
				addMarker(event.latLng);
			});

			// Adds a marker at the center of the map.
			addMarker(haightAshbury);
		}

		// Adds a marker to the map and push to the array.
		function addMarker(location, iconUrl) {
			var marker = new google.maps.Marker({
				position : location,
				map : map,
				icon : {
					scaledSize : {
						height : 50,
						width : 50
					},
					url : iconUrl
				}
			});
			markers.push(marker);
		}

		// Sets the map on all markers in the array.
		function setMapOnAll(map) {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(map);
			}
		}

		// Removes the markers from the map, but keeps them in the array markers[].
		function clearMarkers() {
			setMapOnAll(null);
		}

		// Shows any markers currently in the array.
		function showMarkers() {
			setMapOnAll(map);
		}

		// Deletes all markers in the array by removing references to them.
		function deleteMarkers() {
			clearMarkers();
			markers = [];
		}
		
		function tracker(){
			//Create moving object to track
			var myVar = setInterval(myTimer, 1000); //update after 1 second
			//Object 1
			var latTracker1 = 10.030901;
			var lngTracker1 = 105.768846;
			var icon1 = 'https://cdn4.iconfinder.com/data/icons/car-service-1/512/park-512.png';
			//Object 2
			var latTracker2 = 10.030901;
			var lngTracker2 = 105.768846;
			var icon2 = 'https://www.gtagam3r.com/icons/motorbikes.png';
			//function update position and show mark
			function myTimer() {
				deleteMarkers();
				
				//last position of tracker 1
				positionLast1 = {
					lat : latTracker1,
					lng : lngTracker1
				};
				//update position tracker1
				latTracker1 = latTracker1 + 0.0001;
				lngTracker1 = lngTracker1 + 0.0001;
				positionTracker1 = {
					lat : latTracker1,
					lng : lngTracker1
				};
				
				//last position of tracker 2 
				positionLast2 = {
					lat : latTracker2,
					lng : lngTracker2
				};
				//update position tracker2
				latTracker2 = latTracker2 + 0.0001;
				lngTracker2 = lngTracker2 + 0.00015;
				positionTracker2 = {
					lat : latTracker2,
					lng : lngTracker2
				};
				//add marker on map
				addMarker(positionTracker1, icon1);
				addMarker(positionTracker2, icon2);
	
				//draw line moving
				drawLine(positionLast1, positionTracker1);
				drawLine(positionLast2, positionTracker2);		
			}
		}

		//draw a line 
		function drawLine(position1, position2){
			var line = new google.maps.Polyline({
				path : [ position1, position2],
				strokeColor : "#FF0000",
				strokeOpacity : 1.0,
				strokeWeight : 5,
				map : map
			});
		}
		//tracker();
		
		function trackerUsers() {
			var myVar = setInterval(myTimer, 5000); // update after 1 second
			// Object 1
			var name1, name2
			//lay vi tri lan dau tu so so du lieu
			var x
			function myTimer() {
				deleteMarkers();
				<%
				
				%>
				
				// last position of tracker 1
				positionLast1 = {
					lat : latTracker1,
					lng : lngTracker1
				};
				// update position tracker1
				latTracker1 = updateLat(latTracker1);
				lngTracker1 = updateLng(lngTracker1);
				positionTracker1 = {
					lat : latTracker1,
					lng : lngTracker1
				};
	
				// last position of tracker 2
				positionLast2 = {
					lat : latTracker2,
					lng : lngTracker2
				};
				// update position tracker2
				latTracker2 = updateLat(latTracker2);
				lngTracker2 = updateLng(lngTracker2);
				positionTracker2 = {
					lat : latTracker2,
					lng : lngTracker2
				};
				// add marker on map
				addMarker(positionTracker1, icon1);
				addMarker(positionTracker2, icon2);
	
				// draw line moving
				drawLine(positionLast1, positionTracker1);
				drawLine(positionLast2, positionTracker2);

		}
	}
		
		
		
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&callback=initMap">
	</script>

</body>
</html>