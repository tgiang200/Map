<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/register_purple.png" />
<style type="text/css">
body {
	padding: 0px 0px 0px 0px;
	background-color: #F0FFFF;
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
<title>Register Shipper</title>
<script>
function validateForm() {
    var fullname = document.forms["register"]["fullname"].value;
    var email = document.forms["register"]["email"].value;
    var address = document.forms["register"]["address"].value;
    var idCard = document.forms["register"]["idCard"].value;
    var phone = document.forms["register"]["phone"].value;
    var vehicle = document.forms["register"]["vehicle"].value;
	var password = document.forms["register"]["password"].value;
    var rePassword = document.forms["register"]["rePassword"].value;
    
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
    if (password == "") {
    	document.getElementById("message").innerHTML = "Mật khẩu không được trống";
        return false;
    }
    if (password != rePassword) {
    	document.getElementById("message").innerHTML = "Mật khẩu không trùng khớp";
        return false;
    }
    
    //if (vehicle == "") {
    	//document.getElementById("message").innerHTML = "Phương tiện không được trống";
        //return false;
    //}

    if (email==""){
    	document.getElementById("message").innerHTML = "Email không được trống";
        return false;
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
    window.location.href = "/Map/producer/formRegister.html";
}

function haveAccount(){
	window.location.href = "/Map/account/loginForm.html";
}
</script>
</head>
<body>
<center>
<div class="form-style-3">
<h2>Nhập thông tin đăng kí của Shipper</h2>
	<form name="register" onsubmit="return validateForm()" method="post" action="/Map/shipper/register.html">
		<table>
			<tr>
				<h3 id="message">
					${message }
				</h3>
			</tr>
			<tr>
				<td>Type user</td>
				<td>
					<select id="mySelect" onchange="changeForm()">
						  <option value="producer">Producer</option>
						  <option value="shipper" selected>Shipper</option>					
					</select>
				</td>
			</tr>
			<tr>
				<td>Số điện thoại</td>
				<td><input type="text" name="phone" > *</td>
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
				<td>Phương tiện vận chuyển</td>
				<td>
					<select id="selecttag" name="vehicle">
						  <option  value="bike">Bike</option>
						  <option  value="moto" selected>Motor</option>
						  <option  value="truck">Truck</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email"> *</td>
			</tr>
			<tr>
				<td>Facebook</td>
				<td><input type="text" name="facebook"></td>
			</tr>
			<tr>
				<td>Biển số</td>
				<td><input type="text" name="numberVehicle"></td>
			</tr>
			<tr>
				<td>Mật khẩu</td>
				<td><input type="password" name="password"> *</td>
			</tr>
			<tr>
				<td>Nhập lại mật khẩu</td>
				<td><input type="password" name="rePassword"> *</td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="Register"> 
					<input type="button" value="Đã có tài khoản" onclick="haveAccount()"></td>
			</tr>
		</table>
	</form>
	</div>
</center>
</body>
</html>