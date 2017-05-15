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
<title>Info Shipper</title>
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
<script>
	var info = ${shipper};
	document.write("<div id=\"info\">");
	for (var i=0; i<info.length; i++){
		document.write("<table>");
		document.write("<th bgcolor=\"#5cb85c\" colspan=\"2\"><center><h2>Thông chi tiết Shipper</h2></center></th>");
		document.write("<tr><td>Họ tên</td>");
		document.write("<td>"+info[i].fullname+"</td></tr>");
		document.write("<tr><td>Địa chỉ</td>");
		document.write("<td>"+info[i].address+"</td></tr>");
		document.write("<tr><td>CMND</td>");
		document.write("<td>"+info[i].idCard+"</td></tr>");
		document.write("<tr><td>Số điện thoại</td>");
		document.write("<td>"+info[i].phone+"</td></tr>");
		document.write("<tr><td>Email</td>");
		document.write("<td>"+info[i].email+"</td></tr>");
		document.write("<tr><td>Ngày sinh</td>");
		document.write("<td>"+info[i].dateOfBirth+"</td></tr>");
		document.write("<tr><td>Facebook</td>");
		document.write("<td>"+info[i].facebook+"</td></tr>");
		document.write("<tr><td>Phương tiện</td>");
		document.write("<td>"+info[i].vehicle+"</td></tr>");
		document.write("<tr><td>Biển số</td>");
		document.write("<td>"+info[i].vehicleNumber+"</td></tr>");
		document.write("<tr><td>Qũy còn lại</td>");
		document.write("<td>"+info[i].funds+"</td></tr>");
		document.write("</table><br>");
		
		document.write("<center>");
		if (info[i].statusConfirm=="confirmed"){
			document.write("<a href=\"/Map/shipper/listShipperConfirmed.html\">Trở lại</a>");
		} else {
			document.write("<a href=\"/Map/shipper/resultConfirm/action=confirmed&shipperID="+info[i].phone+"\">Xác nhận</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/shipper/resultConfirm/action=notConfirm&shipperID="+info[i].phone+"\">Không xác nhận</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/shipper/resultConfirm/action=cancel&shipperID="+info[i].phone+"\">Trở lại</a>");
			document.write("</center>");
			//document.write("&ensp;<button onclick=\"confirm("+info[i].phone+")\">Confirm</button>");
			//document.write("&ensp;<button onclick=\"notConfirm("+info[i].phone+")\">Not confirm</button>");
			//document.write("&ensp;<button onclick=\"cancel("+info[i].phone+")\">Cancel</button>");
		}
	}
	document.write("</div>");
	function confirm(idCard) {
		location.href='/Map/shipper/resultConfirm/action=confirmed&shipperID='+idCard;
     }
	function notConfirm(idCard) {
		location.href='/Map/shipper/resultConfirm/action=notConfirm&shipperID='+idCard;
     }
	function cancel(idCard) {
		location.href='/Map/shipper/resultConfirm/action=cancel&shipperID='+idCard;
     }
</script>
</body>
</html>