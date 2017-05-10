<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/Map/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="/Map/bootstrap/css/bootstrap-theme.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/tracker.png" />
<title>Homepage</title>
<style>
body{
	padding: 70px 0px;
}
</style>
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
    	<%@include file="../include/menuNonUser.jsp"%>
    </c:otherwise>
</c:choose>

 <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Mạng xã hội vận chuyển hàng hóa</h1>
        <p>Mạng xã hội vận chuyển hàng hóa là nơi giúp cho việc giao trở nên dễ dàng và đơn giản hơn.</p>
        <p><a class="btn btn-primary btn-lg" href="/Map/account/loginForm.html" role="button">Đăng nhập &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Producer</h2>
          <p>Mạng xã hội hàng hóa là ứng dụng giúp cho việc vận chuyển hàng hóa trở nên đơn giản hơn. Các chủ cửa hàng sẽ không phải lo lắng việc tìm shipper cho đơn hàng của mình. Ứng dụng sẽ cung cấp chứa năng tìm shipper. </p>
          <p><a class="btn btn-default" href="/Map/producer/formRegister.html" role="button">Đăng kí producer &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Shipper</h2>
          <p>Mạng xã hội hàng hóa giúp cho shipper có thể tìm được thêm đơn hàng để vận chuyển để tăng thêm thu nhập. Shipper chỉ cần sử dụng một chiếc điện thoại thông minh cái cài đặt ứng dụng, đăng nhập vào hệ thống, bật chế độ onwork và chờ nhận đơn hàng</p>
          <p><a class="btn btn-default" href="/Map/shipper/formRegister.html" role="button">Đăng kí shipper &raquo;</a></p>
       </div>
        <div class="col-md-4">

        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; 2016 Company, Inc.</p>
      </footer>
    </div> <!-- /container -->

</body>
</html> 
