<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Department Add</title> 
<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			Add new department
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Add a new department in the company</p>
    		</legend><br>
    		<input class = "span4" type="text" placeholder="Enter the department name..."><br>
    		<input class = "span4" type="text" placeholder="Enter the department shortname..."><br>
    		<textarea rows = "5" cols = "50" placeholder="Enter description..."></textarea><br>
    		<br><input type="submit" class="btn btn-info" value = "Add Voucher">
    	</fieldset>
	</form>
</div>
