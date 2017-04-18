<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.i1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/list.png" />
<link href="/Map/css/cssList.css" rel="stylesheet">
<style type="text/css">

</style>
<title>List order</title>
</head>
<body>
<%
	String userType = session.getAttribute("userType").toString();
	pageContext.setAttribute("userType", userType);
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
<script>
	var info = ${listOrder};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<th class=\"title\" colspan=\"8\"><center><h2>Đơn hàng chờ xác nhận hoàn thành vận chuyển</h2></center></th>");
	document.write("<tr>");
	document.write("<th><center>Mã đơn hàng</center></th>");
	document.write("<th><center>SĐT producer</center></th>");
	document.write("<th><center>Shipper</center></th>");
	document.write("<th><center>SĐT shipper</center></th>");
	document.write("<th><center>Khách hàng</center></th>");
	document.write("<th><center>SĐT khách hàng</center></th>");
	document.write("<th><center>Địa chỉ</center></th>");
	document.write("<th><center>Giá vận chuyển</center></th>");
	document.write("<th><center>Lựa chọn</center></th></tr>");
	
	for (var i=0; i<info.length; i++){
		//if (info[i].statusConfirm=="waiting"){
			document.write("<tr>");
			document.write("<td>"+info[i]._id.$oid+"</td>");
			document.write("<td>"+info[i].producer.phone+"</td>");
			document.write("<td>"+info[i].shipper.fullname+"</td>");
			document.write("<td>"+info[i].shipper.phone+"</td>");
			document.write("<td>"+info[i].customerName+"</td>");
			document.write("<td>"+info[i].customerPhone+"</td>");
			document.write("<td>"+info[i].customerAddress+"</td>");
			document.write("<td>"+info[i].shippingPrice+"</td>");
			document.write("<td><a href=\"/Map/order/completeOrder/idOrder="+info[i]._id.$oid+"/\">Xác nhận</a></td>");
			document.write("</tr>");
		//}
	}
	document.write("</table>");
	document.write("</div>");
</script>
<br>
<a href="/Map/order/listConfirm.html" style="font-size: 20px">Đơn hàng chờ duyệt |</a>
<a href="/Map/order/orderFindingShipper.html" style="font-size: 20px">Đơn hàng đang tìm shipper |</a>
<a href="/Map/order/listTransporting.html" style="font-size: 20px">Đơn hàng đang vận chuyển |</a>
<a href="/Map/order/orderCompleted.html" style="font-size: 20px">Đơn hàng đã hoàn thành giao dịch</a>
</center>
</body>
</html>