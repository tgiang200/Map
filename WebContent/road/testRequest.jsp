<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Snap Road</title>
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

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

	<script>
		// In the following example, markers appear when the user clicks on the map.
		// The markers are stored in an array.
		// The user can then click an option to hide, show or delete the markers.
		var placeArray = [];
		//array coordinates to draw line
		var snappedCoordinates = [];
		var parameter;
		
		function initMap() {
			var center = {
				lat : 10.030901,
				lng : 105.768846
			};

			map = new google.maps.Map(document.getElementById('map'), {
				zoom : 15,
				center : center,
				mapTypeId : 'terrain'
			});
			
			map.addListener('click', function(event) {
				parameter = event.latLng.lat()+","+event.latLng.lng()+"|";				
			});
			
			map.addListener('ondblclick', function(event) {
		
				getJSON();
			});

			// draw a line
			function drawLine(position1, position2) {
				var line = new google.maps.Polyline({
					path : [ position1, position2 ],
					strokeColor : "#FF0000",
					strokeOpacity : 1.0,
					strokeWeight : 3,
					map : map
				});
			}

			//draw line with path
			function drawLinePath(path) {
				var line = new google.maps.Polyline({
					path : path,
					strokeColor : "#FF0000",
					strokeOpacity : 1.0,
					strokeWeight : 3,
					map : map
				});
			}


			function getJSON() {
				$
						.getJSON(
								'https://roads.googleapis.com/v1/snapToRoads?path=10.0306,105.75221|10.030901,105.764486|10.03157,105.78236&interpolate=true&key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ',
								function(data) {
									//data is the JSON string
									//document.write("data.length f: "+data.snappedPoints.length);
									processSnapToRoadResponse(data);
									drawLinePath(snappedCoordinates);

								});
			}

			getJSON();

			//covert from JSON to array coordinates
			function processSnapToRoadResponse(data) {
				snappedCoordinates = [];
				placeIdArray = [];
				for (var i = 0; i < data.snappedPoints.length; i++) {
					var latlng = new google.maps.LatLng(
							data.snappedPoints[i].location.latitude,
							data.snappedPoints[i].location.longitude);
					snappedCoordinates.push(latlng);
					placeIdArray.push(data.snappedPoints[i].placeId);
					//document.writeln("lat: "+data.snappedPoints[i].location.latitude);
				}
			}
			;

		}
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&callback=initMap">
		
	</script>


</body>
</html>