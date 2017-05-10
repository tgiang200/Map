<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="control.tracker.*"%>
<%@ page import="org.json.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<title>Tracking</title>
<link href="/Map/css/mapCSS.css" rel="stylesheet">
<script src="/Map/function/function.js" /></script>
<script src="/Map/function/Sha1Digest.js" /></script>
<link rel="shortcut icon" type="image/x-icon" href="/Map/img/tracker.png" />
<style>
body {
	top: 50px;
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
	
	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	<div id="map"></div>
	<!-- <p>Click on the map to add markers.</p>  -->

<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript">

		var latCenter = 10.031347535314561; //${lat};
		var lngCenter = 105.76910376548767; //${lng};
		var icon = "/Map/img/blue_gps.png";
		var iconPosition = "/Map/img/red-location-icon.png";
		var iconShipper = "/Map/img/shipper.png";
		//var username = "${username}";
		var saltKey = "1234"
		var salt = sha1("getAllUser"+saltKey);
		//document.write(username+"<br>"+salt);
		//INIT MAP
		function initMap() {
			var ctu = {
				lat : latCenter,
				lng : lngCenter
			};

			map = new google.maps.Map(document.getElementById('map'), {
				zoom : 15,
				center : ctu,
				mapTypeId : 'terrain'
			});

			// This event listener will call addMarker() when the map is clicked.
			map.addListener('click', function(event) {
				addMarker(event.latLng, iconPosition, "location", event.latLng.lat() + "<br>"
						+ event.latLng.lng());
			});

			//map.setCenter(new google.maps.LatLng(latCenter, lngCenter));
			//tracker();
			
			var listObj={};
			function startTime() {				
				//Lay danh sach user 
				//var listObj=${listObj};
				deleteMarkers();
				
				$.getJSON('http://'+self.location.host+'/Map/apiKaa/getAlltUserTrack/'+salt,
						function(data) {
							listObj = data;
							for (var i=0; i<listObj.length; i++){
								var nameObj = listObj[i].event.username;
								var latObj = parseFloat(listObj[i].event.lat);
								var lngObj = parseFloat(listObj[i].event.lng);
								var locationObj = {
										lat : latObj,
										lng : lngObj
									};
								addMarker(locationObj, iconShipper , nameObj+"", "<a href=\"/Map/tracker/trackUser/username="+nameObj+"\">"+nameObj+"</a><br>"+
										"<input type=\"button\" value=\"Tracking\" onclick=\"tracking("+nameObj+","+salt+")\" />");
							}
					});
					
				var t = setTimeout(startTime, 10000);
			}
			startTime();
			
			//Hien thi search box
			searchBox();

		}

		function tracking(username, salt){
			$.getJSON('http://'+self.location.host+'/Map/apiKaa/getUserTrack/'+username+'/'+salt,
					function(data) {
						listObj = data;
						var locationObj = []; 
						for (var i=0; i<listObj.length; i++){
							var nameObj = listObj[i].event.username;
							//document.write("name: "+nameObj);
							var latObj = parseFloat(listObj[i].event.lat);
							var lngObj = parseFloat(listObj[i].event.lng);
							locationObj[i] = {
										lat : latObj,
										lng : lngObj
								};
							
						}
						line = new google.maps.Polyline({
							path : locationObj,
							strokeColor : "#FF0000",
							strokeOpacity : 1.0,
							strokeWeight : 3,
							map : map
						});
						
						//addMarker(locationObj[locationObj.length-1], iconShipper , nameObj+"", nameObj+"");
					});

		}
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD33TSkbvpSLniSl4eN-j75TpyLHvIj9uQ&libraries=places&callback=initMap">		
	</script>
	
</body>
</html>