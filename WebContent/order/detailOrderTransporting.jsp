<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.i1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
    font-size: 18px;
    overflow: auto;
    
}

th {
	font-size: 22px;
	background-color: #00FA9A;
	color: blue;
}

tr:nth-child(odd){background-color: #E6E6FA}
tr:nth-child(even){background-color: #E0FFFF}

td:nth-child(odd){
	text-align:right;
	padding: 2px 10px 2px 0px;
	font-weight: bold;
}

td:nth-child(even){
	padding: 2px 0px 2px 10px;
	border-left: 1px solid RebeccaPurple;
}
#info {
	position: fixed;
	top: 55px;
	left: 1%;
	font-size: 25px;
	width: 98%;
	height: 100%;
	overflow: auto;
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
		document.write("<th bgcolor=\"#5cb85c\" colspan=\"2\"><center><h3>Thông chi tiết đơn hàng</h3></center></th>");
		
		document.write("<tr><td align=\"right\">Mã đơn hàng</td>");
		document.write("<td>"+info[i]._id.$oid+"</td></tr>");
		
		document.write("<tr><td align=\"right\">Họ tên producer</td>");
		document.write("<td>"+info[i].producer.fullname+"</td></tr>");
		document.write("<tr><td align=\"right\">Địa chỉ producer</td>");
		document.write("<td>"+info[i].producer.address+"</td></tr>");
		document.write("<tr><td align=\"right\">Tên cửa hàng</td>");
		document.write("<td>"+info[i].producer.storeName+"</td></tr>");
		document.write("<tr><td align=\"right\">Số điện thoại producer</td>");
		document.write("<td>"+info[i].producer.phone+"</td></tr>");
		
		document.write("<tr><td align=\"right\">Họ tên shipper</td>");
		document.write("<td>"+info[i].shipper.fullname+"</td></tr>");
		document.write("<tr><td align=\"right\">Địa chỉ shipper</td>");
		document.write("<td>"+info[i].shipper.address+"</td></tr>");
		document.write("<tr><td align=\"right\">Số điện thoại producer</td>");
		document.write("<td>"+info[i].producer.phone+"</td></tr>");
		document.write("<tr><td align=\"right\">Phương tiện</td>");
		document.write("<td>"+info[i].shipper.vehicle+"</td></tr>");
		
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
		document.write("</table>");
		
		document.write("<center>");
		document.write("&ensp;&ensp;<a href=\"/Map/order/listTransporting.html\">Trở lại</a>");
		document.write("</center><br><br><br>");
		
		//document.write("&ensp;<button onclick=\"confirm("+info[i]._id.$oid+")\">Find shipper</button>");
		//document.write("&ensp;<button onclick=\"notConfirm("+info[i]._id.$oid+")\">Not confirm</button>");
		//document.write("&ensp;<button onclick=\"cancel("+info[i]._id.$oid+")\">Cancel</button>");
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