<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="/function/function.jsp"%>

<%@ page import="control.tracker.*"%>
<%@ page import="org.json.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head> 
       <meta http-equiv="content-type" content="text/html; charset=UTF-8"/> 
       <title>Google Maps API v3 Directions Example</title> 
       <script type="text/javascript" 
               src="http://maps.google.com/maps/api/js?sensor=false"></script>
    </head> 
    <body style="font-family: Arial; font-size: 12px;"> 
       <div style="width: 600px;">
         <div id="map" style="width: 280px; height: 400px; float: left;"></div> 
         <div id="panel" style="width: 300px; float: right;"></div> 
       </div>
       
       <script type="text/javascript"> 
    
         var directionsService = new google.maps.DirectionsService();
         var directionsDisplay = new google.maps.DirectionsRenderer();
    
         var map = new google.maps.Map(document.getElementById('map'), {
           zoom:7,
           mapTypeId: google.maps.MapTypeId.ROADMAP
         });
        
         directionsDisplay.setMap(map);
         directionsDisplay.setPanel(document.getElementById('panel'));
    
         var request = {
           origin: 'Chicago', 
           destination: 'New York',
           travelMode: google.maps.DirectionsTravelMode.DRIVING
         };
    
         directionsService.route(request, function(response, status) {
           if (status == google.maps.DirectionsStatus.OK) {
             directionsDisplay.setDirections(response);
           }
         });
       </script> 
    </body>
</html>