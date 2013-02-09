<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<title>Vowcher - Change Password</title>
<%@ include file = "../include/layout.jsp" %>
</head>
<div id = "body-content">
	<form method = "POST" class="validate">
  		<fieldset>
    		<legend>
    			Password Change
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Change your current password by providing the following details</p>
    		</legend><br>
			<input class = "span4 required" valtype="required" type="password" placeholder="Enter the current password..."> <br>
			<input class = "span4 required" valtype="required" type="password" placeholder="Enter the new password..."><br>
			<input class = "span4 required" valtype="required" type="password" placeholder="Confirm password..."><br>
			<label>Security Check </label><input class = "span4" type="text"><br>
			<br><input type="submit" class="btn btn-info" value = "Change Password">
		</fieldset>
	</form>
</div>