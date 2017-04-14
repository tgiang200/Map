<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.i1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/Map/css/cssTable.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/list.png" />
<title>Confirm producer</title>
</head>
<body>
<jsp:include page="../menu.jsp" />
<script type="text/javascript">
	var info = ${order};
	document.write("<div id=\"info\">");
	for (var i=0; i<info.length; i++){
		document.write("<table>");
		document.write("<h3>Thông chi tiết Order</h3>");
		document.write("<tr><td align=\"right\">Producer name</td>");
		document.write("<td>"+info[i].producer.fullname+"</td></tr>");
		document.write("<tr><td align=\"right\">Producer address</td>");
		document.write("<td>"+info[i].producer.address+"</td></tr>");
		document.write("<tr><td align=\"right\">Store name</td>");
		document.write("<td>"+info[i].producer.storeName+"</td></tr>");
		document.write("<tr><td align=\"right\">Producer phone</td>");
		document.write("<td>"+info[i].producer.phone+"</td></tr>");
		document.write("<tr><td align=\"right\">Type</td>");
		document.write("<td>"+info[i].type+"</td></tr>");
		document.write("<tr><td align=\"right\">Customer name</td>");
		document.write("<td>"+info[i].customerName+"</td></tr>");
		document.write("<tr><td align=\"right\">Customer address</td>");
		document.write("<td>"+info[i].customerAddress+"</td></tr>");
		document.write("<tr><td align=\"right\">Customer phone</td>");
		document.write("<td>"+info[i].customerPhone+"</td></tr>");
		document.write("<tr><td align=\"right\">Meansure</td>");
		document.write("<td>"+info[i].meansure+"</td></tr>");
		document.write("<tr><td align=\"right\">Vehicle type</td>");
		document.write("<td>"+info[i].vehicleType+"</td></tr>");
		document.write("<tr><td align=\"right\">Describe</td>");
		document.write("<td>"+info[i].describe+"</td></tr>");
		document.write("<tr><td align=\"right\">Price</td>");
		document.write("<td>"+info[i].price+"</td></tr>");
		document.write("</table>");
		
		document.write("<a href=\"/Map/order/completeOrder/action=confirmed&orderID="+info[i]._id.$oid+"\">Find Shipper</a>");
		document.write("<a href=\"/Map/order/completeOrder/action=cancel&orderID="+info[i]._id.$oid+"\">Cancel</a>");
		
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