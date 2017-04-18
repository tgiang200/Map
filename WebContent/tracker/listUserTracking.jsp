<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="/Map/function/Sha1Digest.js" /></script>
<style>
#list {
	position: absolute;
	top: 120px;
	left: 100px;
	font-size: 20px;
	width: 100%;
}
body{
	padding: 100px 0px 0px 0px;
}
</style>
<title>Insert title here</title>
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


<div id="list"></div>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script async defer type="text/javascript">
var list = ${list};
var link = [];
for (var i=0; i<list.length; i++){
	link.push("<a href=\"/Map/tracker/trackUser/username="+list[i].phone+"\">"+list[i]+"</a><br>");
}
document.getElementById("list").innerHTML = link.join("<br>"); 

/*var saltKey = "1234"
var salt = getSalt("getAllUser",username,saltKey);

$.getJSON('http://'+self.location.host+'/Map/api/getAllUser/username='+username+'&salt='+salt,
						function(data) {
							listObj = data;
							var link = [];
							for (var i=0; i<listObj.length; i++){
								//neu trang thai la on
									var nameObj = listObj[i].name;
									link.push("<a href=\"/Map/tracker/trackUser/username="+nameObj+"\">"+nameObj+"</a><br>");
									//x.innerHTML = "<a href=\"/Map/tracker/trackUser/username="+nameObj+"\">"+nameObj+"</a><br>";
							}
							document.getElementById("list").innerHTML = link.join("<br>"); 
						
						});
*/				
</script>
</body>
</html>