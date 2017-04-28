<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript">
	
//	$.getJSON('http://172.30.40.158:8080/Map/api/login/user=producer&username=abc&password=abc1',
	//		function(data) {
		//		listObj = data;
			//	document.write("data"+data);
			//});

		$.getJSON('https://192.168.1.13:8443/Map/api/login/userType=producer&username=0123&password=abc',
				function(data) {
					listObj = data;
					//return data;
					document.write(listObj.result);
				}
		);
</script>
</body>
</html>