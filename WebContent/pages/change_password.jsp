<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change password</title>
<jsp:include page = "../include/layout.jsp"/>

<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			Change the password
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to change the password</p>
    		</legend><br>
    		<div id = "body-content"> 
<input class = "span4" type="text" placeholder="Enter the current password..."> <br>
<input class = "span4" type="text" placeholder="Enter the new password..."><br>
<input class = "span4" type="text" placeholder="Confirm password..."><br>
<label>Enter the text for security reasons</label><input class = "span4" type="text"><br>
<br><button type="Save" class="btn btn-info">Save</button>
<button type="Cancel" class="btn btn-info">Cancel</button>
</fieldset>
	</form>
</div>