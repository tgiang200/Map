<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.i1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/cssTable.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/list.png" />
<style type="text/css">
body{
	
}

td, th{
	width: 50%;
}

.title{
	background-color: #5cb85c;
	color: blue;
}
</style>
<title>Confirm producer</title>
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

<script type="text/javascript">
	var info = ${order};
	document.write("<div id=\"info\">");
	for (var i=0; i<info.length; i++){
		document.write("<table>");
		document.write("<th bgcolor=\"#5cb85c\" colspan=\"2\"><center><h2>Thông chi tiết đơn hàng</h2></center></th>");
		document.write("<tr><td align=\"right\">Họ tên producer</td>");
		document.write("<td>"+info[i].producer.fullname+"</td></tr>");
		document.write("<tr><td align=\"right\">Địa chỉ producer</td>");
		document.write("<td>"+info[i].producer.address+"</td></tr>");
		document.write("<tr><td align=\"right\">Tên cửa hàng</td>");
		document.write("<td>"+info[i].producer.storeName+"</td></tr>");
		document.write("<tr><td align=\"right\">Số điện thoại producer</td>");
		document.write("<td>"+info[i].producer.phone+"</td></tr>");
		document.write("<tr><td align=\"right\">Ngày tạo</td>");
		document.write("<td>"+info[i].timeCreate+"</td></tr>");
		document.write("<tr><td align=\"right\">Loại hàng</td>");
		document.write("<td>"+info[i].type+"</td></tr>");
		document.write("<tr><td align=\"right\">Tên người nhận</td>");
		document.write("<td>"+info[i].customerName+"</td></tr>");
		document.write("<tr><td align=\"right\">Địa chỉ người nhận</td>");
		document.write("<td>"+info[i].customerAddress+"</td></tr>");
		document.write("<tr><td align=\"right\">Số điện thoại người nhận</td>");
		document.write("<td>"+info[i].customerPhone+"</td></tr>");
		document.write("<tr><td align=\"right\">Thông tin đo lường</td>");
		document.write("<td>"+info[i].meansure+"</td></tr>");
		document.write("<tr><td align=\"right\">Loại phương tiện</td>");
		document.write("<td>"+info[i].vehicleType+"</td></tr>");
		document.write("<tr><td align=\"right\">Mô tả thêm</td>");
		document.write("<td>"+info[i].describe+"</td></tr>");
		document.write("<tr><td align=\"right\">Khoảng cách vận chuyển</td>");
		document.write("<td>"+info[i].distance+"</td></tr>");
		document.write("<tr><td align=\"right\">Giá vân chuyển</td>");
		document.write("<td>"+info[i].shippingPrice+"</td></tr>");
		document.write("</table><br>");
		
		document.write("<center>");
		if (info[i].status=="waitingConfirm"){
			document.write("<a href=\"/Map/order/findingShipper/action=confirmed&orderID="+info[i]._id.$oid+"\">Tìm shipper</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/order/findingShipper/action=notConfirm&orderID="+info[i]._id.$oid+"\">Không xác nhận</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/order/findingShipper/action=cancel&orderID="+info[i]._id.$oid+"\">Trở về</a>");
			
			//document.write("&ensp;<button onclick=\"confirm("+info[i]._id.$oid+")\">Find shipper</button>");
			//document.write("&ensp;<button onclick=\"notConfirm("+info[i]._id.$oid+")\">Not confirm</button>");
			//document.write("&ensp;<button onclick=\"cancel("+info[i]._id.$oid+")\">Cancel</button>");
		} else {
			document.write("<a href=\"/Map/order/listAllOrder.html\">Trở lại</a>");
		}
		document.write("</center>");
	}
	document.write("</div>");
	
	function confirm(id) {
		location.href='/Map/order/findShipper/action=confirmed&orderID='+id;
     }
	function notConfirm(id) {
		location.href='/Map/order/findShipper/action=notConfirm&orderID='+id;
     }
	function cancel(id) {
		location.href='/Map/order/findShipper/action=cancel&orderID='+id;
     }
</script>
</body>
</html>