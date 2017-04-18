<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="control.order.OrderModel" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/register_purple.png" />

<link href="/Map/css/mapCSS.css" rel="stylesheet">
<script src="/Map/function/function.js" /></script>

<title>Create Order</title>
<style>
body{
	padding: 70px 0px;
	background-color: #F0FFFF;
}
#createForm{
	position: fixed;
	float: left;
	width: 60%;
	border-right: 2px solid black;
	bottom: 10px;
}
#mapAddress{
	position: fixed;
	left: 60%;
	float: right;
	width: 40%;
	height: 65%;
}
#selecttag{
	width: 250px;
	color: #F072A9;
	font-size: 16px;
	margin: 2px 0px 2px 0px;
}

td:nth-child(even){
	color: red;
	font-size: 20px;
}

td:nth-child(odd){
	font-size: 18px;
}

input[type=submit],
input[type=reset],
input[type=button]{
    font-size: 14px;
    width: 125px;
    margin-top: 14px;
}
.form-style-3 input[type=text],
.form-style-3 input[type=date],
.form-style-3 input[type=datetime],
.form-style-3 input[type=number],
.form-style-3 input[type=search],
.form-style-3 input[type=time],
.form-style-3 input[type=url],
.form-style-3 input[type=password],
.form-style-3 input[type=email],
.form-style-3 textarea{
	margin: 2px 0px 2px 0px;
}
select{
	
}
</style>
<script>
function validateForm() {
    var type = document.forms["create"]["type"].value;
    var name = document.forms["create"]["name"].value;
    var address = document.forms["create"]["address"].value;
    var phone = document.forms["create"]["phone"].value;
    var vehicle = document.forms["create"]["vehicle"].value;
    var price = document.forms["create"]["price"].value;
   	
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
    } else {
    	if (!validatePhone(phone)){
    		document.getElementById("message").innerHTML = "Số điện thoại không hợp lệ";
            return false;
    	}
    }
    
    if (price =="") {
    	document.getElementById("message").innerHTML = "Vui lòng chọn vị trí khách hàng trên bản đồ";
        return false;
    }
    
    function validatePhone(phone) {
        var filter = /^[0-9-+]+$/;
        return filter.test(phone);
    }
}
</script>
</head>
<body style="background-color:#F0FFFF">
<%
try {
	String userType = session.getAttribute("userType").toString();
	pageContext.setAttribute("userType", userType);
} catch (Exception ex){
	String useType = ""; 
}
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

<div id="createForm">
<center>
<div class="form-style-3">
	<h2 style="color:#00008B">Nhập thông tin đơn hàng cần vận chuyển</h2>
	<form name="create" onsubmit="return validateForm()" method="post" action="/Map/order/createOrder.html">
		<table>
			<tr>
				<h3 id="message" style="color:red">
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
				<td><input type="text" name="address" id="address"> *</td> <!-- onblur="eventAddress()" -->
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
					<select id="selecttag" name="vehicle" onchange="eventVehicle()">
						  <option  value="bike">Bike</option>
						  <option  value="motor" selected>Motor</option>
						  <option  value="truck">Truck</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Mô tả thêm</td>
				<td><textarea name="describe"></textarea></td>
			</tr>
			<tr>
				<td>Khoảng cách</td>
				<td><input type="text" name="distance" value="">Km</td>
			</tr>
			<tr>
				<td>Giá vận chuyển đề xuất</td>
				<td><input type="text" name="price">VND</td>
			</tr>
					
			<tr>
				<td></td>
				<td><input type="submit" value="Create"><input type="reset" value="Clear"></td>
			</tr>
		</table>
	</form>
	</div>
</center>
</div>
<div id="mapAddress">
	<center>
		<h3 style="color:red">Tìm địa chỉ người nhận</h3>
		<h4 style="color:red">Vui lòng click chọn vị trí khách hàng trên bản đồ</h4>
	</center>
	<input id="pac-input" name="pac-input" class="controls" type="text" placeholder="Nhập địa chỉ khách hàng">
	<div id="map"></div>
</div>
<script type="text/javascript">
//event chon phuong tien van chuyen
<%
	OrderModel orderModel = new OrderModel();
	double priceBike = orderModel.getPriceTransport("bike");
	double priceMotor = orderModel.getPriceTransport("motor");
	double priceTrunk = orderModel.getPriceTransport("trunk");
	String lat = request.getAttribute("latProducer").toString();
	String lng = request.getAttribute("lngProducer").toString();
%>

var latProducer=<%=lat%>;
var lngProducer=<%=lng%>;

function vehicleType(vehicle){
	if (vehicle == "bike"){
		price = <%=priceBike%>
	} else if (vehicle == "truck" ){
		price = <%=priceTrunk%>
	} else {
		price = <%=priceMotor%>
	}
	return price;
}
function selectVehicle(){
	var vehicle = document.forms["create"]["selecttag"].value;
	//document.forms["create"]["describe"].value = vehicle +" v";
	var price = vehicleType(vehicle);
	return price;
}

function searchAddress(){
	var sAddress = document.getElementById("pac-input").value;
	document.forms["create"]["address"].value = sAddress;
}
var producerLocation = {lat: latProducer, lng: lngProducer}; //location cua producer
var cLat;
var cLng;

function getPrice(){
	
	selectVehicle();
	
	var iconPosition = "/Map/img/red-location-icon.png";
	var iconProducer = "/Map/img/producer.png";
	map = new google.maps.Map(document.getElementById('map'), {
		zoom : 14,
		center : producerLocation,
		mapTypeId : 'terrain'
	});
    
	addMarker(producerLocation, iconProducer, "vị trí cửa hàng", producerLocation.lat + "<br>"
			+ producerLocation.lng);
	
	// This event listener will call addMarker() when the map is clicked.
	map.addListener('click', function(event) {
		deleteMarkers();
		addMarker(event.latLng, iconPosition, null, event.latLng.lat() + "<br>"
				+ event.latLng.lng());
		addMarker(producerLocation, iconProducer, "vị trí cửa hàng", producerLocation.lat + "<br>"
				+ producerLocation.lng);
		findRoad(producerLocation, event.latLng);
		cLocation = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());
	});
	searchBox();
	
	
	/*var addr = document.forms["create"]["address"].value;
	var address = addr.replaceAll(' ', '+');
	$.getJSON('https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ',
			function(data) {
				var distance = getDistance(producerLocation, data.results[0].geometry.location);
				//document.forms["create"]["price"].value = parseFloat(distance+distance*0.3).toFixed(2)+" km";
				findRoad(producerLocation, data.results[0].geometry.location)
			});*/
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
                
            }
            distance=distance/1000;
            document.forms["create"]["distance"].value = distance;
            document.forms["create"]["price"].value = Math.ceil(distance*price);
		}
	});
}

var cLocation = {lat: parseFloat(cLat), lng: parseFloat(cLng)};
function eventVehicle(){
	selectVehicle();
	findRoad(producerLocation, cLocation);
	//document.forms["create"]["describe"].value = selectVehicle()+"||"+cLocation.lat();
	//document.getElementById("message").innerHTML = "Vui lòng chọn vị trí khách hàng trên bản đồ";
}

function eventAddress(){
	selectVehicle();
	getPrice();
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