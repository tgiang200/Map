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
<title>List producer</title>
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

<div id="content">
<center>

<script>
	var info = ${producer};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<th class=\"title\" colspan=\"7\"><center><h2>Danh sách producer đã duyệt</h2></center></th>");
	document.write("<h4>${message}</h4>");
	document.write("<tr><th><center>Họ tên</center></th>");
	document.write("<th><center>Tên cửa hàng</center></th>");
	document.write("<th><center>Địa chỉ</center></th>");
	document.write("<th><center>CMND</center></th>");
	document.write("<th><center>Điện thoại</center></th>");
	document.write("<th><center>Email</center></th>");
	document.write("<th><center>Lựa chọn</center></th></tr>");
	
	for (var i=0; i<info.length; i++){
		document.write("<tr>");
		document.write("<td>"+info[i].fullname+"</td>");
		document.write("<td>"+info[i].storeName+"</td>");
		document.write("<td>"+info[i].address+"</td>");
		document.write("<td>"+info[i].idCard+"</td>");
		document.write("<td>"+info[i].phone+"</td>");
		document.write("<td>"+info[i].email+"</td>");
		document.write("<td><a href=\"/Map/producer/producerID="+info[i].phone+"\">Select</a></td>");
		document.write("</tr>");
	}
	
	document.write("</table>");
	document.write("</div>");
</script>
<br>
<a href="/Map/producer/listConfirm.html" style="font-size: 20px">Producer chờ duyệt</a>
</center>
</div>
</body>
</html>