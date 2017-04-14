<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript"
		src="http://maps.google.com/maps/api/js?sensor=false&v=3&libraries=geometry"></script>
	<script>
		function distance(p1, p2) {
			return google.maps.geometry.spherical
					.computeDistanceBetween(p1, p2);
		}
	</script>
</body>
</html>