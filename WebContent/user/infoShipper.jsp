<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/inforFormCSS.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/register_purple.png" />
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
<style type="text/css">
body {
	padding: 40px 0px 10px 0px;
	background-color: #F0FFFF;
}

td:nth-child(even){
	color: red;
	font-size: 18px;
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
.form-style-3 input[type=date]{
	height: 35px;
}
</style>
<title>Infomation Shipper</title>
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
    var oldPassword = document.forms["register"]["oldPassword"].value;
    
    if (phone != '${phone}') {
    	document.getElementById("message").innerHTML = "Không được thay đổi số điện thoại";
        return false;
    }
    
    if (oldPassword==""||oldPassword=='${password}') {
    	document.forms["register"]["password"].value = '${password}';
        return true;
    } else {
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

function cancel(){
	window.location.href = "/Map/homepage.html";
}
</script>
</head>
<body>
<center>
<div class="form-style-3">
<h2 style="color:blue">Thông tin Shipper</h2>
	<form name="register" onsubmit="return validateForm()" method="post" action="/Map/shipper/update.html">
		<table>
			<tr>
				<h3 id="message" style="color:red">
					${message }
				</h3>
			</tr>
			<tr>
				<td>Số điện thoại</td>
				<td><input type="text" name="phone" value="${phone }" hidden >${phone }</td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value="${email }"> *</td>
			</tr>
			<tr>
				<td>Họ tên</td>
				<td><input type="text" name="fullname" value="${fullname }"> *</td>
			</tr>
			<tr>
				<td>Địa chỉ</td>
				<td><input type="text" name="address" value="${address }"> *</td>
			</tr>
			<tr>
				<td>CMND</td>
				<td><input type="text" name="idCard" value="${idCard }"> *</td>
			</tr>
			<tr>
				<td>Ngày sinh</td>
				<td><input type="date" name="dateOfBirth" value="${dateOfBirth }"> *</td>
			</tr>
			<tr>
				<td>Phương tiện vận chuyển</td>
				<td>
					<input type="text" name="vehicle" value="${vehicle }"> *</td>
			</tr>
			<tr>
				<td>Biển số</td>
				<td><input type="text" name="vehicleNumber" value="${vehicleNumber }"></td>
			</tr>
			<tr>
				<td>Facebook</td>
				<td><input type="text" name="facebook" value="${facebook }"></td>
			</tr>
			<tr>
				<td>Mật khẩu</td>
				<td><input type="password" name="oldPassword"> *</td>
			</tr>
			<tr>
				<td>Tạo mật khẩu mới</td>
				<td><input type="password" name="password"> *</td>
			</tr>
			<tr>
				<td>Nhập lại mật khẩu mới</td>
				<td><input type="password" name="rePassword"> *</td>
			</tr>
			<tr>
				<td>Quỹ còn lại</td>
				<td><input type="text" name="funds" value="${funds }" hidden>${funds } VND</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Cập nhật thông tin"> 
					<input type="button" value="Trở về" onclick="cencel()"></td>
			</tr>
		</table>
	</form>
	</div>
</center>
</body>
</html>