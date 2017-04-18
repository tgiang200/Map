<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<title>Confirm</title>
</head>
<body>
<center>
<h1>Nhập thông tin tài khoản để tạo mới mật khẩu</h1>
<div class="form-style-3">
	<form method="post" name="login" onsubmit="return validateForm()"
		action="/Map/account/getCode.html">
		<table>
			<tr>
				<h2>${message }</h2>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" name="phone" value = "${phone }"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Lấy mã xác nhận"></td>
			</tr>
			<tr>
				<td>&ensp;</td>
				<td></td>
			</tr>
		</table>
	</form>
	</div>
	<h2>Mã xác nhận sẽ được gởi đến email đăng kí của bạn</h2>
	</center>
</body>
</html>