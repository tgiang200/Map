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
<title>Result search</title>
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
	var info1 = ${producer};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<th class=\"title\" colspan=\"7\"><center><h2>Kết quả tìm kiếm theo producer</h2></center></th>");
	document.write("<h4>${message}</h4>");
	document.write("<tr><th><center>Họ tên</center></th>");
	document.write("<th><center>Tên cửa hàng</center></th>");
	document.write("<th><center>Địa chỉ</center></th>");
	document.write("<th><center>CMND</center></th>");
	document.write("<th><center>Điện thoại</center></th>");
	document.write("<th><center>Email</center></th>");
	document.write("<th><center>Chi tiết</center></th></tr>");
	
	for (var i=0; i<info1.length; i++){
		document.write("<tr>");
		document.write("<td>"+info1[i].fullname+"</td>");
		document.write("<td>"+info1[i].storeName+"</td>");
		document.write("<td>"+info1[i].address+"</td>");
		document.write("<td>"+info1[i].idCard+"</td>");
		document.write("<td>"+info1[i].phone+"</td>");
		document.write("<td>"+info1[i].email+"</td>");
		document.write("<td><a href=\"/Map/producer/producerID="+info1[i].phone+"\">Chọn</a></td>");
		document.write("</tr>");
	}
	
	document.write("</table>");
	document.write("</div>");
</script>
<script>
	var info2 = ${shipper};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<th class=\"title\" colspan=\"7\"><center><h2>Kết quả tìm kiếm theo shipper</h2></center></th>");
	document.write("<h4>${message}</h4>");
	document.write("<tr><th><center>Họ tên</center></th>");
	document.write("<th><center>Địa chỉ</center></th>");
	document.write("<th><center>CMND</center></th>");
	document.write("<th><center>Điện thoại</center></th>");
	document.write("<th><center>Email</center></th>");
	document.write("<th><center>Phương tiện</center></th>");
	document.write("<th><center>Chi tiết  </center></th></tr>");
	
	for (var i=0; i<info2.length; i++){
			document.write("<tr>");
			document.write("<td>"+info2[i].fullname+"</td>");
			document.write("<td>"+info2[i].address+"</td>");
			document.write("<td>"+info2[i].idCard+"</td>");
			document.write("<td>"+info2[i].phone+"</td>");
			document.write("<td>"+info2[i].email+"</td>");
			document.write("<td>"+info2[i].vehicle+"</td>");
			document.write("<td><a href=\"/Map/shipper/shipperID="+info2[i].phone+"\">Chọn</a></td>");
			document.write("</tr>");
	}
	document.write("</table>");
	document.write("</div>");
</script>
<script>
	var info3 = ${order};
	document.write("<div id=\"info\">");
	document.write("<table>");
	document.write("<th class=\"title\" colspan=\"7\"><center><h2>Kết quả tìm kiếm theo order</h2></center></th>");
	document.write("<tr><th><center>Producer</center></th>");
	document.write("<th><center>Địa chỉ Producer</center></th>")
	document.write("<th><center>Loại hàng</center></th>");;
	document.write("<th><center>Địa chỉ người nhận</center></th>");
	document.write("<th><center>SĐT người nhận</center></th>");
	document.write("<th><center>Giá vận chuyển</center></th>");
	document.write("<th><center>Trạng thái</center></th></tr>");
	
	for (var i=0; i<info3.length; i++){
		//if (info[i].statusConfirm=="waiting"){
			document.write("<tr>");
			document.write("<td>"+info3[i].producer.fullname+"</td>");
			document.write("<td>"+info3[i].producer.address+"</td>");
			document.write("<td>"+info3[i].type+"</td>");
			document.write("<td>"+info3[i].customerAddress+"</td>");
			document.write("<td>"+info3[i].customerPhone+"</td>");
			document.write("<td>"+info3[i].shippingPrice+"</td>");
			document.write("<td>"+info3[i].status+"</td>");
			document.write("</tr>");
		//}
	}
	document.write("</table>");
	document.write("</div>");
</script>

</center>
</div>
</body>
</html>