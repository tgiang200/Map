<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/inforFormCSS.css" rel="stylesheet">
<link href="/Map/css/mapCSS.css" rel="stylesheet">
<script src="/Map/function/function.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/register_purple.png" />
<title>Information Producer</title>
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
<style>
body {
	padding: 5px 0px 0px 0px;
	background-color: #F0FFFF;
}
#formRegister{
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
#map{
	left: 5px;
}
td:nth-child(even){
	color: red;
	font-size: 20px;
}
td:nth-child(odd){
	color: #191970;
	font-size: 18px;
}

input[type=submit],
input[type=reset],
input[type=button]{
    font-size: 14px;
    
}
</style>
<script>
function validateForm() {
    var password = document.forms["register"]["password"].value;
    var rePassword = document.forms["register"]["rePassword"].value;
    var fullname = document.forms["register"]["fullname"].value;
    var address = document.forms["register"]["address"].value;
    var idCard = document.forms["register"]["idCard"].value;
    var phone = document.forms["register"]["phone"].value;
    var email = document.forms["register"]["email"].value;
    var lat = document.forms["register"]["lat"].value;
    var lng = document.forms["register"]["lng"].value;
    var oldPassword = document.forms["register"]["oldPassword"].value;
    
    if (phone != '${phone}') {
    	document.getElementById("message").innerHTML = "Không được thay đổi số điện thoại";
        return false;
    }
    
    if (oldPassword=="") {
    	document.forms["register"]["password"].value = '${password}';
        return true;
    } else {
    	if (oldPassword=='{$password}'&&password==""){
    		document.forms["register"]["password"].value = '${password}';
            return true;
    	}
    	if (oldPassword != '${password}'){
    		document.getElementById("message").innerHTML = "Sai mật khẩu";
    		return false;
    	}
    	if (password == "") {
        	document.getElementById("message").innerHTML = "Mật khẩu không được trống";
            return false;
        }
        if (password != rePassword) {
        	document.getElementById("message").innerHTML = "Mật khẩu không trùng khớp";
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
    
    if (phone == "") {
    	document.getElementById("message").innerHTML = "Số điện thoại không được trống";
        return false;
    } else {
    	if (!validatePhone(phone)){
    		document.getElementById("message").innerHTML = "Số điện thoại không hợp lệ";
            return false;
    	}
    }
    
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

function cancel(){
	window.location.href = "/Map/homepage.html";
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
	<h2 style="color:blue;">Thông tin Producer</h2>
	<form name = "register" onsubmit="return validateForm()" method="post" action="/Map/producer/update.html">
		<table>
			<tr>
				<h3 id="message" style="color:red;">
					${message }
				</h3>
			</tr>
			<tr>
				<td>Số điện thoại</td>
				<td><input type="text" name="phone" value="${phone }" hidden>${phone }</td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value ="${email }"> *</td>
			</tr>
			<tr>
				<td>Họ tên</td>
				<td><input type="text" name="fullname" value ="${fullname }"> *</td>
			</tr>
			<tr>
				<td>Địa chỉ</td>
				<td><input type="text" name="address" value ="${address }"> *</td>
			</tr>
			<tr>
				<td>CMND</td>
				<td><input type="text" name="idCard" value ="${idCard }"> *</td>
			</tr>
			<tr>
				<td>Tên cửa hàng</td>
				<td><input type="text" name="storeName" value ="${storeName }"> *</td>
			</tr>
			<tr>
				<td>Facebook</td>
				<td><input type="text" name="facebook" value ="${facebook }"></td>
			</tr>
			<tr>
				<td>Lĩnh vực kinh doanh</td>
				<td><input type="text" name="businessType" value ="${businessType }"></td>
			</tr>
			<tr>
				<td>Latitude</td>
				<td><input type="text" name="lat" value ="${lat }"></td>
			</tr>
			<tr>
				<td>Longitude</td>
				<td><input type="text" name="lng" value ="${lng }"></td>
			</tr>
			<tr>
				<td>Mật khẩu</td>
				<td><input type="password" name="oldPassword"> </td>
			</tr>
			<tr>
				<td>Cập nhật mật khẩu mới</td>
				<td><input type="password" name="password"> </td>
			</tr>
			<tr>
				<td>Nhập lại mật khẩu mới</td>
				<td><input type="password" name="rePassword"> </td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Cập nhật thông tin">
					<input type="button" value="Trở lại" onclick="cancel()"></td>
			</tr>
			<tr><td></td></td></tr>
		</table>
	</form>
	</div>
</center>
</div>
<div id="mapAddress">
	<center>
		<h2 style="color:blue; margin-top: 50px;">Vị trí cửa hàng</h2>
		<h4 style="color:red">(Nếu vi trí chưa chính xác, vui lòng tìm và click vào vị trí <br>cửa hàng của bạn trên bản đồ)</h4>
	</center>	
	<div id="map"></div>
	
</div>

<script type="text/javascript"> 
function initMap() {
	var iconProducer = "/Map/img/producer.png";
	var iconPosition = "/Map/img/red-location-icon.png";
	function showPosition(position) {
		latf = ${lat };
		lngf = ${lng };
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