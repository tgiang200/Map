<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.i1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/list.png" />
<link href="/Map/css/cssTable.css" rel="stylesheet">
<title>Confirm producer</title>
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
	var info = ${producer};
	document.write("<div id=\"info\">");
	for (var i=0; i<info.length; i++){
		document.write("<table>");
		document.write("<th bgcolor=\"#5cb85c\" colspan=\"2\"><center><h2>Thông chi tiết Producer</h2></center></th>");
		document.write("<tr><td align=\"right\">Họ tên</td>");
		document.write("<td>"+info[i].fullname+"</td></tr>");
		document.write("<tr><td align=\"right\">Địa chỉ</td>");
		document.write("<td>"+info[i].address+"</td></tr>");
		document.write("<tr><td align=\"right\">CMND</td>");
		document.write("<td>"+info[i].idCard+"</td></tr>");
		document.write("<tr><td align=\"right\">Tên cửa hàng</td>");
		document.write("<td>"+info[i].storeName+"</td></tr>");
		document.write("<tr><td align=\"right\">Số điện thoại</td>");
		document.write("<td>"+info[i].phone+"</td></tr>");
		document.write("<tr><td align=\"right\">Email</td>");
		document.write("<td>"+info[i].email+"</td></tr>");
		document.write("<tr><td align=\"right\">Facebook</td>");
		document.write("<td>"+info[i].facebook+"</td></tr>");
		document.write("<tr><td align=\"right\">Lĩnh vực kinh doanh</td>");
		document.write("<td>"+info[i].businessType+"</td></tr>");
		document.write("<tr><td align=\"right\">Latitude</td>");
		document.write("<td>"+info[i].lat+"</td></tr>");
		document.write("<tr><td align=\"right\">Longitude</td>");
		document.write("<td>"+info[i].lng+"</td></tr>");
		document.write("</table><br>");
		
		document.write("<center>");
		if (info[i].statusConfirm=="confirmed"){
			document.write("<a href=\"/Map/producer/listProducerConfirmed.html\">Trở lại</a>");
		} else {
			document.write("<a href=\"/Map/producer/resultConfirm/action=confirmed&producerID="+info[i].phone+"\">Xác nhận</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/producer/resultConfirm/action=notConfirm&producerID="+info[i].phone+"\">Không xác nhận</a>");
			document.write("&ensp;|&ensp;<a href=\"/Map/producer/resultConfirm/action=cancel&producerID="+info[i].phone+"\">Trở lại</a>");

			//document.write("&ensp;<button onclick=\"confirm("+info[i].phone+")\">Confirm</button>");
			//document.write("&ensp;<button onclick=\"notConfirm("+info[i].phone+")\">Not confirm</button>");
			//document.write("&ensp;<button onclick=\"cancel("+info[i].phone+")\">Cancel</button>");
		}
		document.write("</center>");		
	}
	document.write("</div>");
	function confirm(phone) {
		location.href='/Map/producer/resultConfirm/action=confirmed&producerID='+phone;
     }
	function notConfirm(phone) {
		location.href='/Map/producer/resultConfirm/action=notConfirm&producerID='+phone;
     }
	function cancel(phone) {
		location.href='/Map/producer/resultConfirm/action=cancel&producerID='+phone;
     }
</script>
</body>
</html>