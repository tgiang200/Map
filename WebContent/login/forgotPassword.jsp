<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/error-icon.png" />
<title>Confirm</title>
</head>
<body style="background-color: #ffff99">
<center>
<h1 style="color:red">Nhập thông tin tài khoản để tạo mới mật khẩu</h1>
<h2 style="color:red">Lưu ý phải nhập đúng số điện thoại và email được dùng để đăng kí</h2>
<div class="form-style-3">
	<form method="post" name="login" onsubmit="return validateForm()"
		action="/Map/account/getCode.html">
		<table>
			<tr>
				<h2></h2>
			</tr>
			<tr>
				<td></td>
				<td><select name="userType">
						<option value="producer" selected>Producer</option>
						<option value="shipper">Shipper</option>
				</select></td>
			</tr>
			<tr>
				<td  style="color: blue; font-weight: bold">Số điện thoại</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td style="color: blue; font-weight: bold">Email</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Tạo mới mật khẩu" style="font-size: 16px"></td>
			</tr>
			<tr>
				<td>&ensp;</td>
				<td></td>
			</tr>
		</table>
	</form>
	</div>
	<h2>Mật khẩu mới sẽ được gởi đến email của bạn</h2>
	</center>
</body>
</html>