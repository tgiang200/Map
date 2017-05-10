<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="/Map/bootstrap/css/bootstrap-theme.css" rel="stylesheet">
<style>
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 200px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    padding: 12px 16px;
    z-index: 1;
}

.dropdown:hover .dropdown-content {
    display: block;
}
</style>
</head>
<body>

	<!-- nenu -->
	<nav class="navbar navbar-inverse navbar-fixed-top"> <%
 	if (session.getAttribute("username") == null) {
 		out.println("<script type=\"text/javascript\">");
 		out.println("window.location = \"/Map/account/logout.html\"");
 		out.println("</script>");
 	}
 %>
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/Map/homepage.html"><script>
				//document.write(self.location.host)
				document.write("<img src=\"/Map/img/trackingShipper.png\" alt=\"Search\" height=\"25\" width=\"25\" >")
			</script></a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="/Map/homepage.html">Trang chủ</a></li>
				<li></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Tracking<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/Map/producer/mapProducer.html">Producer</a></li>
						<li role="separator" class="divider"></li>
						<li class="dropdown-header">Bản đồ</li>
                  		<li><a href="/Map/tracker/mapTracker.html">Xem bản đồ</a></li>
						<li><a href="/Map/tracker/road.html">Tìm đường</a></li>
						<li><a href="/Map/tracker/shareLocation.html">Chia sẻ vị trí</a></li>
					</ul></li>
				
				<li><a href="http://localhost:8080/Map/call/callPage.html">Call & SMS</a></li>

			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><div class="dropdown">
					  <span><img src="/Map/img/search-icon.png" alt="Search" height="25" width="25" style="margin: 10px 10px"></span>
					  <div class="dropdown-content">
					    <p><form method="get" action="/Map/user/search.html">
					    	<input type="text" name="keyword" value="" placeholder="Tìm kiếm">
					    	<input type="submit" value="Tìm">
					    </form></p>
					  </div>
					</div>
				</li>
				<li></li>
				<li><a href="/Map/user/userType=shipper&username=<%out.print(session.getAttribute("username"));%>/"><%out.print(session.getAttribute("username"));%></a></li>
				<li><a href="/Map/account/logout.html">Đăng xuất</a></li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	</nav>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/Map/bootstrap/js/bootstrap.js"></script>
</body>
</html>