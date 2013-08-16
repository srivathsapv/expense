<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="utility.Utility,java.io.File" %>
<html>
<head>
	<title>Vowcher - Forgot Password</title>
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
		Forgot Password	
		<p class="legend-desc">
			<i class="icon-question-sign"></i>
			Enter your username. Your password will be reset and sent to your email. 
		</p>
	</legend>
	<form action = "../server/forgot_password.jsp" method = "POST">
		<input type = "text" name = "username" class = "span4" placeholder = "Enter your username..."><br>
		<button type = "submit" class = "btn btn-info"><i class = "icon-white icon-repeat"></i>Reset</button>
	</form>
</div>