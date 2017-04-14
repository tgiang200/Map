/**
 * 
 */
var map;
var markers = [];

// Adds a marker to the map and push to the array.
function addMarker(location, iconUrl, label, info) {
	var marker = new google.maps.Marker({
		position : location,
		map : map,
		icon : {
			scaledSize : {
				height : 50,
				width : 50
			},
			url : iconUrl
		},
		label : label,
		draggable : true
	});
	markers.push(marker);

	// Show information of position
	var infowindow = new google.maps.InfoWindow({
		content : info
	});

	marker.addListener('mouseover', function() {
		infowindow.open(map, marker);
	});

	// assuming you also want to hide the infowindow when user mouses-out
	// marker.addListener('mouseout', function() {
	// infowindow.close();
	// });
}

// Sets the map on all markers in the array.
function setMapOnAll(map) {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}

// Removes the markers from the map, but keeps them in the array
// markers[].
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

//remove line
function removeLine(flightPath) {
    flightPath.setMap(null);
  }

//hien thi hop thoai tim kim dia diem
function searchBox(){
	//SEARCH BOX
	// Create the search box and link it to the UI element.
    var input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }

      // Clear out the old markers.
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        if (!place.geometry) {
          console.log("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });
}

//Direction - tim duong di
function findRoad(startP, endP, directionsService, directionsDisplay) {
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

//Hide direction
function hideShowPath(directionsDisplay) {
    directionsDisplay.setMap(null);
}  



//function distanceRoad(startP, endP, directionsService, directionsDisplay) {
//	directionsDisplay.setMap(map);
//	directionsDisplay.setPanel(document.getElementById('panel'));
//
//	var request = {
//		origin : startP,
//		destination : endP,
//		travelMode : google.maps.DirectionsTravelMode.DRIVING
//	};
//
//	directionsService.route(request, function(response, status) {
//		if (status == google.maps.DirectionsStatus.OK) {
//			directionsDisplay.setDirections(response);
//			computeTotalDistance(response);
//		}
//	});
//}
//
//function computeTotalDistance(result) {
//	  var totalDist = 0;
//	  var totalTime = 0;
//	  var myroute = result.routes[0];
//	  for (i = 0; i < myroute.legs.length; i++) {
//	    totalDist += myroute.legs[i].distance.value;
//	    totalTime += myroute.legs[i].duration.value;
//	  }
//	  totalDist = totalDist / 1000.
//	  document.getElementById("total").innerHTML = "total distance is: " + totalDist + " km<br>total time is: " + (totalTime / 60).toFixed(2) + " minutes";
//	}

//Create moving object to track
/*function tracker() {
	var myVar = setInterval(myTimer, 1000); // update after 1 second
	// Object 1
	var latTracker1 = 10.030901;
	var lngTracker1 = 105.768846;
	var icon1 = '/Map/img/car.png';
	// Object 2
	var latTracker2 = 10.029889;
	var lngTracker2 = 105.770574;
	var icon2 = '/Map/img/motorbikes.png';
	// function update position and show mark
	function myTimer() {
		deleteMarkers();

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


function printString(string) {
	document.write(string + "<br>");
}

// update lat
function updateLat(lat) {
	var x = Math.floor((Math.random() * 100) - 30);
	lat = lat + x / 100000;
	return lat;
}

// update lng
function updateLng(lng) {
	var x = Math.floor((Math.random() * 100) - 30);
	lng = lng + x / 1000000;
	return lng;
}*/