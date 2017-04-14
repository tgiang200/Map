<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/Map/bootstrap/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="/Map/bootstrap/js/bootstrap.js"></script>
<style type="text/css">
body{
	padding: 50px 0px;
}
#content{
	width: 1024px;	
}

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
    font-size: 18px;
    text-align:center; 
    vertical-align:middle;
    border-bottom: #228B22 solid 2px;
}

tr:nth-child(even){background-color: #f2f2f2}

th {
    background-color: #4D4D94;
    color: white;
    font-size: 20px;
    text-align:center; 
    vertical-align:middle;
}

.l {
    text-align: right; 
    vertical-align:middle;
}

.r {
    text-align: left; 
    vertical-align:middle;
    color : red;
}
#colormenu{

}
</style>
<title>List</title>
</head>
<body>
<div id="colormenu">
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">WebSiteName</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">Page 1-1</a></li>
          <li><a href="#">Page 1-2</a></li>
          <li><a href="#">Page 1-3</a></li>
        </ul>
      </li>
      <li><a href="#">Page 2</a></li>
      <li><a href="#">Page 3</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
				<li><a
					href="#">User
				</a></li>
				<li><a href="#">Log out</a></li>
			</ul>
  </div>
</nav>
</div>

<center>
<div id="content">
<table>
  <tr>
    <th><center>Firstname</center></th>
    <th><center>Lastname</center></th>
    <th><center>Savings</center></th>
  </tr>
  <tr>
    <td class="l">Peter</td>
    <td class="r">Griffin</td>
    <td>$100</td>
  </tr>
  <tr>
    <td class="l">Lois</td>
    <td class="r">Griffin</td>
    <td>$150</td>
  </tr>
  <tr>
    <td class="l">Joe</td>
    <td class="r">Swanson</td>
    <td>$300</td>
  </tr>
  <tr>
    <td class="l">Cleveland</td>
    <td class="r">Brown</td>
    <td>$250</td>
</tr>
</table>
</div>
</center>
</body>
</html>