<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="utility.Utility,java.io.File" %>

<html>
<head>
	<title>Vowcher - Initialize Database</title>
	<link rel="shortcut icon" type = "image/ico" href = "../img/favico.ico">
	<link rel="stylesheet/less" href="../less/bootstrap.less">
	<script src = "../js/jquery-1.8.3.min.js"></script>
	<style>
		#body-content {
			padding:20px;
		}
	</style>
	<script src="../js/less.js" type="text/javascript"></script>
	
</head>

<div id="body-content">
	<legend>
		DB Initialization	
		<p class="legend-desc">
			<i class="icon-question-sign"></i>
			It looks like your database configuration has not yet been created.
			Enter the following details to set up your database connectivity. 
		</p>
	</legend>
	<form action = "../server/dbinit.jsp" method = "POST">
		<input type = "text" name = "dbname" class = "span4" placeholder = "Enter your database name..."><br>
		<input type = "text" name = "username" class = "span4" placeholder = "Enter your database username..."><br>
		<input type = "password" name = "password" class = "span4" placeholder = "Enter your database password..."><br>
		<button type = "submit" class = "btn btn-info"><i class = "icon-white icon-ok"></i>Save</button>
	</form>
</div>