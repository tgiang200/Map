<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title>Create Order</title>
<script>
function validateForm() {
    var type = document.forms["create"]["type"].value;
    var name = document.forms["create"]["name"].value;
    var address = document.forms["create"]["address"].value;
    var phone = document.forms["create"]["phone"].value;
    var vehicle = document.forms["create"]["vehicle"].value;
   	
    if (type =="") {
    	document.getElementById("message").innerHTML = "Loại hàng không được trống";
        return false;
    }
    if (name =="") {
    	document.getElementById("message").innerHTML = "Tên người nhận không được trống";
        return false;
    }
    if (address=="") {
    	document.getElementById("message").innerHTML = "Địa chỉ người nhận không được trống";
        return false;
    }
    if (phone == "") {
    	document.getElementById("message").innerHTML = "Số điện thoại người nhận không được trống";
        return false;
    }
    if (vehicle == "") {
    	document.getElementById("message").innerHTML = "Phương tiện vận chuyển không được trống";
        return false;
    }
}
</script>
</head>
<body>
<center>
<div class="form-style-3">
	<h2>Nhập thông tin đơn hàng cần vận chuyển</h2>
	<form name="create" onsubmit="return validateForm()" method="post" action="/Map/order/createOrder.html">
		<table>
			<tr>
				<h3 id="message">
					${message }
				</h3>
			</tr>
			<tr>
				<td>Loại hàng</td>
				<td><input type="text" name="type"> *</td>
			</tr>
			<tr>
				<td>Tên người nhận</td>
				<td><input type="text" name="name"> *</td>
			</tr>
			<tr>
				<td>Địa chỉ người nhận</td>
				<td><input type="text" name="address" id="address" onblur="getPrice()"> *</td>
			</tr>
			<tr>
				<td>Số điện thoại người nhận</td>
				<td><input type="text" name="phone"> *</td>
			</tr>
			<tr>
				<td>Thông tin đo lường</td>
				<td><input type="text" name="meansure"></td>
			</tr>
			<tr>
				<td>Loại xe vận chuyển</td>
				<td>
					<select id="selecttag" name="vehicle">
						  <option  value="bike">Bike</option>
						  <option  value="moto" selected>Motor</option>
						  <option  value="truck">Truck</option>
					</select> *
				</td>
			</tr>
			<tr>
				<td>Mô tả thêm</td>
				<td><textarea name="describe"></textarea></td>
			</tr>
			<tr>
				<td>Khoảng cách/giá vận chuyển</td>
				<td><input type="text" name="price"></td>
			</tr>		
			<tr>
				<td></td>
				<td><input type="submit" value="Create"><input type="reset" value="Clear"></td>
			</tr>
		</table>
	</form>
	</div>
</center>

<script type="text/javascript">
//event nhap dia chi
function getPrice(){
	
	var producerLocation = {lat: 10.02531496690251, lng: 105.74727058410645};
	var addr = document.forms["create"]["address"].value;
	var address = addr.replaceAll(' ', '+');
	$.getJSON('https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ',
			function(data) {
				var distance = getDistance(producerLocation, data.results[0].geometry.location);
				document.forms["create"]["price"].value = parseFloat(distance+distance*0.3).toFixed(2)+" km";
				findRoad(producerLocation, data.results[0].geometry.location)
			});
}

function findRoad(startP, endP) {
	var directionsService = new google.maps.DirectionsService();
	var directionsDisplay = new google.maps.DirectionsRenderer();

	var request = {
		origin : startP,
		destination : endP,
		travelMode : google.maps.DirectionsTravelMode.DRIVING
	};

	directionsService.route(request, function(response, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(response);
			var myroute = directionsDisplay.directions.routes[0];
            var distance = 0;
            for (i = 0; i < myroute.legs.length; i++) {
                distance += myroute.legs[i].distance.value;
                //for each 'leg'(route between two waypoints) we get the distance and add it to the total
            }
            document.forms["create"]["describe"].value = distance +" km";
		}
	});
}

function getDistance(p1, p2) {
	var rad = function(x) {
		  return x * Math.PI / 180;
		};
  	var R = 6378137; // Earth’s mean radius in meter
	var dLat = rad(p2.lat - p1.lat);
	var dLong = rad(p2.lng - p1.lng);
	var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(rad(p1.lat)) * Math.cos(rad(p2.lat)) *
    Math.sin(dLong / 2) * Math.sin(dLong / 2);
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	var d = R * c;
	return d/1000; // returns the distance in km
};

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};
</script>
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=getPrice">		
	</script>
</body>
</html>