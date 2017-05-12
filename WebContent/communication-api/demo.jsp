<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Communication</title>
<script src="/Map/communication-api/jquery-1.7.2.min.js" charset="utf-8"></script>
<script src="/Map/communication-api/api/param.js" charset="utf-8"></script>
<script src="/Map/communication-api/api/SIPml-api.js" charset="utf-8"></script>
<script src="/Map/communication-api/api/chat-api.js" charset="utf-8"></script>
<!-- <script src="demo.js" charset="utf-8"></script>  -->
<link href="/Map/css/formCSS.css" rel="stylesheet">
<style type="text/css">
body{
	padding-top: 70px; 
	padding-left: 100px;
}
</style>
<script type="text/javascript">
	var username = '${SIPUsername}';
	var password = '${SIPPasswork}';
	$(document).ready(function() {
		// Can khoi tao 2 Button login va logout trong HTML
		setLoginButton('btn-login', 'btn-logout');
		// --> Neu giao dien khong can 2 nut nay thi co the set trong css: "display: hidden;"

		// Can khoi tao 4 Button trong HTML de xu ly qua trinh call
		// --> 1: Call : goi
		// --> 2: Hangup : cup may
		// --> 3: Answer : tra loi cuoc goi
		// --> 4: Reject : tu choi cuoc goi
		setCallButtons('btn-call', 'btn-hangup', 'btn-answer', 'btn-reject');
		

		document.getElementById("txt-sipAccount").value = username;
		document.getElementById("txt-password").value = password;
		//document.getElementById("txt-password").value = password;
		
		
		prepare();

		// Dang nhap sip account : co the goi khi button onclick
		$('#btn-login').click(function() {
			// Thiet lap thong tin User
			var serverAddr = $('#txt-serverAddr').val();
			var sipAccount = $('#txt-sipAccount').val() + '@' + serverAddr;
			var password = $('#txt-password').val();

			setUserInfo('Chau Quoc Minh', sipAccount, password, serverAddr);

			// Thiet lap server:
			// --> Neu dung May ao Server thi dua vao dia chi server
			// --> Neu dung Remote Server thi set null
			setServerAddress(serverAddr);

			onClickLogin();
		});

		// Xu ly logout:
		$('#btn-logout').click(function() {
			onClickLogout();
		});

		// Goi thong qua SIP address:
		$('#btn-call').click(function() {
			makeVoiceCall($('#txt-sendTo').val());
		});

		// Lang nghe su kien cup may:
		$('#btn-hangup').click(function() {
			sipHangUp();
		});

		// Xu ly nut "Send message"
		$('#btn-send').click(function() {
			var msg = username +"/" + $('#txtMessage').val();

			// createMessageSession();
			sendMessage($('#txt-sendTo').val(), msg);

			displaySendMessage(msg);

			$('#txtMessage').val("");
		});
	});

	function displaySendMessage(message) {
		var displayName = "Chau Quoc Minh";
		$('#messageView').append("<p>" + displayName + ": " + message + "</p>");
	}

	// Xu ly tien trinh nhan tin nhan trong ham nay
	// VD: set tin nhan len giao dien, luu vao csdl ...
	// *** Ghi chu: dung su kien "e" de xu ly
	function handleMessaging(e) {
		displayReceivedMessage(e);
	}

	function displayReceivedMessage(e) {
		var displayName = 'cqm1';
		var message = e.getContentString();
		$('#messageView').append("<p>" + displayName + ": " + message + "</p>");
	}
	
	function onchangText(){
		var callTo = document.getElementById("txt-callToUSer").value;
		var server = document.getElementById("txt-serverAddr").value;
		document.getElementById("txt-sendTo").value = 'sip:'+callTo+'@'+server;
	} 
</script>
</head>
<body>
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
<table>
	<tr>
		<td>Tài khoản</td>
		<td>
			<input id="txt-sipAccount" type="text" value="cqm">
		</td>
	<tr>
		<td>Mật khẩu</td>
		<td>
		<input id="txt-password" type="password" value="cqmcqm">
		</td>
	</tr>
	<tr>
		<td>Server</td>
		<td>
		<input id="txt-serverAddr" type="text" onkeyup="onchangText()" value="192.168.201.200">
		</td></tr>
	<tr>
		<td>Gọi/SMS đến</td>
		<td>
		<input type="text" id="txt-callToUSer" onkeyup="onchangText()" value="cqm">
		</td></tr>
	<tr><td>	
		<input id="btn-login" type="button" value="Login">
		<input id="btn-logout" type="button" value="Logout">
		</td><td>
		<input id="btn-call" type="button" value="Call">
		<input id="btn-hangup" type="button" value="Hangup">
		<input id="btn-answer" type="button" value="Answer">
		<input id="btn-reject" type="button" value="Reject">
	</td></tr>
</table>
	<p>
		Status: <i><span id="status"></span></i>
	</p>

	<h3>MESSENGER</h3>
	<div id="msgContainer">
		<div id="messageView"></div>
		 Send to: <input type="text" id="txt-sendTo" value="sip:cqm@192.168.201.200"><br>
		<br>
		<textarea id="txtMessage" rows="4" cols="30"></textarea>
		<br> <input id="btn-send" type="button" value="Send Message">
	</div>

	<!-- Audio here -->
	<audio id="audio_remote" autoplay="autoplay" />
	<audio id="ringtone" loop src="/Map/communication-api/api/sounds/ringtone.wav">
	</audio>
	<audio id="ringbacktone" loop src="/Map/communication-api/api/sounds/ringbacktone.wav">
	</audio>
	<audio id="dtmfTone" src="/Map/communication-api/api/sounds/dtmf.wav">
	</audio>

</body>
</html>
