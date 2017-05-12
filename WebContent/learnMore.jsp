<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/Map/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="/Map/bootstrap/css/bootstrap-theme.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/tracker.png" />
<title>About</title>
<style>
body{
	padding: 70px 100px 100px 100px;
}
p{
	font-size: 20px;
}
h1{
	color: blue;
}
#a{
	font-size: 30px;
}
</style>
</head>
<body>
<%
try {
	String userType = session.getAttribute("userType").toString();
	pageContext.setAttribute("userType", userType);
} catch (Exception ex){
	String useType = "nonUser"; 
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
    	<%@include file="../include/menuNonUser.jsp"%>
    </c:otherwise>
</c:choose>

<center><h1>Mạng xã hội vận chuyển hàng hóa</h1></center>
<p>
Mạng xã hội vận chuyển hàng hóa là ứng dụng có ứng dụng hệ thống theo vết đa mục tiêu để quản lý người dùng. 
</p>
<p>
Mạng xã hội hàng hóa là ứng dụng giúp cho việc vận chuyển hàng hóa trở nên đơn giản hơn. Các chủ cửa hàng sẽ không phải lo lắng việc tìm shipper cho đơn hàng của mình. Ứng dụng sẽ cung cấp chứa năng tìm shipper. Các chủ cửa hàng chỉ cận nhập thông tin của đơn hàng, các đơn hàng sẽ từ động được hệ thống tìm shipper sau khi được trung tâm điều khiển duyệt. Vị trí của các của hàng cũng sẽ được hiển thị trên bản đồ, giúp mọi người có thể dễ dàng tím được vị trí của cửa hàng, góp phần quảng bá của hàng đến với mọi người.
</p>
<p>
Mạng xã hội hàng hóa giúp cho shipper có thể tìm được thêm đơn hàng để vận chuyển để tăng thêm thu nhập. Shipper chỉ cần sử dụng một chiếc điện thoại thông minh cái cài đặt ứng dụng, đăng nhập vào hệ thống. Khi có đơn hàng cần vận chuyển, hệ thống sẽ gởi đơn hàng đến shipper.
</p>
<center>
<p>
<a href="/Map/homepage.html">Trang chủ</a>
</p>
</center>
</body>
</html> 
