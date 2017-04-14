<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/loginFormCSS.css" rel="stylesheet">
<style type="text/css">
#loginZone {
	position: relative; width : 496;
	height: 255;
	background-color: red;
	width: 496;
}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
	<!-- Save for Web Slices (Untitled-3) -->
	<center>
		<table id="Table_01" width="1024" height="660" border="0"
			cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="3"><img src="images/login_01.gif" width="1024"
					height="343" alt=""></td>
			</tr>
			<tr>
				<td rowspan="2"><img src="images/login_02.gif" width="484"
					height="317" alt=""></td>
				<td bgcolor="#B0E0E6">
					<center>
					<div class="form-style-3">
						<form method="post" action="/Map/account/login.html">
							<table>
								<tr>
									<h2>${message }</h2>
								</tr>
								<tr>
									<td></td>
									<td><select name="userType">
											<option value="center" selected>Center</option>
											<option value="producer">Producer</option>
											<option value="shipper">Shipper</option>
									</select></td>
								</tr>
								
								<tr>
									<td>Tài khoản</td>
									<td><input type="text" name="username"></td>
								</tr>
								<tr>
									<td>Mật khẩu</td>
									<td><input type="password" name="password"></td>
								</tr>
								<tr>
									<td></td>
									<td><input type="submit" value="Login"> <input
										type="button" value="Register" onclick="register()" /></td>
								</tr>
							</table>
						</form>
					</div>
					</center>
				</td>
				<td rowspan="2"><img src="images/login_04.gif" width="44"
					height="317" alt=""></td>
			</tr>
			<tr>
				<td><img src="images/login_05.gif" width="496" height="62"
					alt=""></td>
			</tr>
		</table>
	</center>
	<!-- End Save for Web Slices -->
</body>
</html>