<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<link href="/Map/css/mapCSS.css" rel="stylesheet">
<script src="/Map/function/function.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/register_purple.png" />
<title>Register Producer</title>
<style>
body {
	padding: 0px 0px 0px 0px;
	background-color: #F0FFFF;
}
#formRegister{
	position: fixed;
	float: left;
	width: 60%;
	border-right: 2px solid black;
}
#mapAddress{
	position: fixed;
	left: 60%;
	float: right;
	width: 40%;
	height: 65%;
}
#map{
	left: 5px;
}
td:nth-child(even){
	color: red;
	font-size: 20px;
}

input[type=submit],
input[type=reset],
input[type=button]{
    font-size: 14px;
    width: 130px;
}
</style>
<script>
function validateForm() {
    //var password = document.forms["register"]["password"].value;
    //var rePassword = document.forms["register"]["rePassword"].value;
    var fullname = document.forms["register"]["fullname"].value;
    var address = document.forms["register"]["address"].value;
    var idCard = document.forms["register"]["idCard"].value;
    var phone = document.forms["register"]["phone"].value;
    var email = document.forms["register"]["email"].value;
    var lat = document.forms["register"]["lat"].value;
    var lng = document.forms["register"]["lng"].value;
	
    if (phone == "") {
    	document.getElementById("message").innerHTML = "Số điện thoại không được trống";
        return false;
    } else {
    	if (!validatePhone(phone)){
    		document.getElementById("message").innerHTML = "Số điện thoại không hợp lệ";
            return false;
    	}
    }
    
    if (fullname=="") {
    	document.getElementById("message").innerHTML = "Họ tên không được trống";
        return false;
    }
    if (address=="") {
    	document.getElementById("message").innerHTML = "Địa chỉ không được trống";
        return false;
    }
    if (idCard=="") {
    	document.getElementById("message").innerHTML = "CMND không được trống";
        return false;
    }
       
    /*if (password == "") {
    	document.getElementById("message").innerHTML = "Mật khẩu không được trống";
        return false;
    }
    if (password != rePassword) {
    	document.getElementById("message").innerHTML = "Mật khẩu không trùng khớp";
        return false;
    }*/

    if (lat == "" || lng =="") {
    	document.getElementById("message").innerHTML = "Chưa lấy được vị trí, vui lòng bật chia sẽ vị trí và thử lại";
        return false;
    }
    
    if (email==""){
    	document.getElementById("message").innerHTML = "Email không được trống";
    } else {
    	if (!validateEmail(email)){
    		document.getElementById("message").innerHTML = "Email không hợp lệ";
            return false;
    	}
    }
    
    function validateEmail(email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }
    
    function validatePhone(phone) {
        var filter = /^[0-9-+]+$/;
        return filter.test(phone);
    }
}

function changeForm() {
    var x = document.getElementById("mySelect").value;
    window.location.href = "/Map/shipper/formRegister.html";
}

function haveAccount(){
	window.location.href = "/Map/account/loginForm.html";
}
</script>

</head>
<body>
<script>
		var lat;
		var lng;
		function showPosition(position) {
			latf = position.coords.latitude;
			lngf = position.coords.longitude;
			window.lat=latf;
			window.lng=lngf;
			document.forms["register"]["lat"].value = latf;
			document.forms["register"]["lng"].value = lngf;
			
		}
		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(showPosition);
				
			} else {
				document.getElementById("message").innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		getLocation();
	</script>
<div id="formRegister">
<center>
<div class="form-style-3">
	<h2>Nhập thông tin đăng kí của Producer</h2>
	<form name = "register" onsubmit="return validateForm()" method="post" action="/Map/producer/register.html">
		<table>
			<tr>
				<h3 id="message">
					${message }
				</h3>
			</tr>
			<tr>
				<td></td>
				<td>
					<select id="mySelect" onchange="changeForm()">
						  <option value="producer" selected>Producer</option>
						  <option value="shipper">Shipper</option>					
					</select>
				</td>
			</tr>
			<tr>
				<td>Số điện thoại</td>
				<td><input type="text" name="phone"> *</td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email"> *</td>
			</tr>
			<tr>
				<td>Họ tên</td>
				<td><input type="text" name="fullname"> *</td>
			</tr>
			<tr>
				<td>Địa chỉ</td>
				<td><input type="text" name="address"> *</td>
			</tr>
			<tr>
				<td>CMND</td>
				<td><input type="text" name="idCard"> *</td>
			</tr>
			<tr>
				<td>Tên cửa hàng</td>
				<td><input type="text" name="storeName"> *</td>
			</tr>
			<tr>
				<td>Facebook</td>
				<td><input type="text" name="facebook"></td>
			</tr>
			<tr>
				<td>Lĩnh vực kinh doanh</td>
				<td><input type="text" name="businessType"></td>
			</tr>
			<!-- <tr>
				<td>Mật khẩu</td>
				<td><input type="password" name="password"> *</td>
			</tr>
			<tr>
				<td>Nhập lại mật khẩu</td>
				<td><input type="password" name="rePassword"> *</td>
			</tr> -->
			<tr>
				<td>Latitude</td>
				<td><input type="text" name="lat" value =""></td>
			</tr>
			<tr>
				<td>Longitude</td>
				<td><input type="text" name="lng" value=""></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Đăng kí">
					<input type="button" value="Đã có tài khoản" onclick="haveAccount()"></td>
			</tr>
		</table>
	</form>
	</div>
</center>
</div>
<div id="mapAddress">
	<center>
		<h2>Vị trí cửa hàng</h2>
		<h3>(Nếu vi trí chưa chính xác, vui lòng tìm và click vào vị trí <br>cửa hàng của bạn trên bản đồ)</h3>
	</center>	
	<div id="map"></div>
	
</div>

<script type="text/javascript"> 
function initMap() {
	var iconProducer = "/Map/img/producer.png";
	var iconPosition = "/Map/img/red-location-icon.png";
	function showPosition(position) {
		latf = position.coords.latitude;
		lngf = position.coords.longitude;
		window.lat=latf;
		window.lng=lngf;
		document.forms["register"]["lat"].value = latf;
		document.forms["register"]["lng"].value = lngf;
		
		var producerLocation = {
				lat : latf,
				lng : lngf
			};
		
		var iconPosition = "/Map/img/red-location-icon.png";
		var iconProducer = "/Map/img/producer.png";
		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 15,
			center : producerLocation,
			mapTypeId : 'terrain'
		});
	    
		addMarker(producerLocation, iconProducer, "vị trí cửa hàng", producerLocation.lat + "<br>"
				+ producerLocation.lng);
		
		// This event listener will call addMarker() when the map is clicked.
		map.addListener('click', function(event) {
			deleteMarkers();
			addMarker(event.latLng, iconProducer, "vị trí cửa hàng", event.latLng.lat() + "<br>"
					+ event.latLng.lng());
			document.forms["register"]["lat"].value = event.latLng.lat();
			document.forms["register"]["lng"].value = event.latLng.lng();
		});
		
		//searchBox();
		
	}
	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
			
		} else {
			document.getElementById("message").innerHTML = "Geolocation is not supported by this browser.";
		}
	}
	getLocation();	
}
</script>
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=initMap">		
	</script>
	
</body>
</html>