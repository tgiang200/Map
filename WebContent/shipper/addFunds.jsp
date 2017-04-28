<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/formCSS.css" rel="stylesheet">
<style type="text/css">
body{
	padding: 70px 0px 0px 0px;
}
</style>
<title>Add funds</title>
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
<center>
<div class="form-style-3">
<h2>Thêm quỹ cho shipper</h2>
<form name="register" onsubmit="return validateForm()" method="post" action="/Map/shipper/addFunds.html">
		<table>
			<tr>
				<h3 id="message">
					${message }
				</h3>
			</tr>
			<tr>
				<td>Số điện thoại</td>
				<td><input type="text" name="phone" ></td>
			</tr>
			<tr>
				<td>Thêm quỹ</td>
				<td><input type="text" name="funds">VND</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Thêm"></td>
			</tr>
		</table>
	</form>
</div>
</center>
</body>
</html>