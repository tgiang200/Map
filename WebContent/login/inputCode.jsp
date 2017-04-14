<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/Map/css/formCSS.css" rel="stylesheet">
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #99ffcc;
	margin: auto;
	padding: 20px;
	border: 10px solid #33cc33;
	width: 80%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
button{
    background: #99ff66;
    border: 1px solid blue;
    padding: 5px 15px 5px 15px;
    color: #003399;
    box-shadow: inset -1px -1px 3px #FF62A7;
    -moz-box-shadow: inset -1px -1px 3px #FF62A7;
    -webkit-box-shadow: inset -1px -1px 3px #FF62A7;
    border-radius: 3px;
    border-radius: 3px;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;    
    font-weight: bold;
    font-size: 20px;
}
</style>
</head>
<body>

	<!-- The Modal -->
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>
				<center>
					<h1 style="color:blue">${result }</h1>
					<form method="post" name="login" onsubmit="return validateForm()" action="/Map/account/login.html">
							<table>
								<tr>
									<td>Mã xác nhận</td>
									<td><input type="text" name="code"></td>
								</tr>
								<tr>
									<td>Mật khẩu mới</td>
									<td><input type="password" name="password"></td>
								</tr>
								<tr>
									<td>Nhập lại mật khẩu</td>
									<td><input type="password" name="rePassword"></td>
								</tr>
								<tr>
									<td></td>
									<td><input type="submit" value="Đăng nhập"></td>
								</tr>
								<tr><td>&ensp;</td><td></td></tr>
							</table>
						</form>
				</center>
			</p>
		</div>

	</div>

	<script>
	
		function redirect(){
			window.location.href = "/Map/account/loginForm.html";
		}
		// Get the modal
		var modal = document.getElementById('myModal');

		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks the button, open the modal 
		function show() {
			modal.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
			window.location.href = "/Map/account/loginForm.html";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onload = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
		
		show();
	</script>

</body>
</html>
