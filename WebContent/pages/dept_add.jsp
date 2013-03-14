<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,utility.Utility"%>
<%@ include file = "../include/layout.jsp" %>
<script src="../js/custom.js"></script>
<title>Vowcher - Department Add</title> 
<div id = "body-content">
	<form method = "POST" class="validate" action = "../server/dept_add.jsp">
  		<fieldset>
    		<legend>
    			Add new department
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Add a new department in the company</p>
    		</legend><br>
    		<input class = "span4 required" valtype="required alphanumericwithspace" name = "deptname" valmsg="Department name should contain only alphanumeric values" type="text" placeholder="Enter the department name..."><br>
    		<input class = "span4 required" onkeyup="uppercase(this)" type="text" name = "shortname" valtype="required alphanumeric" valmsg="Short name should contain only alphabets" placeholder="Enter the department shortname..."><br>
    		<label>Chief Executive Officer</label>
    		<select class = "span4 required" valtype = "required" id = "userid" name = "userid">
    			<option value = "">Choose a User</option>
   				<%
   					User[] users = User.list("","");
   					for(User u : users) {
   						%> <option value = "<%= u.getUserid() %>"><%= u.getFirstName() + " " + u.getlastName() %></option> <%
   					}
   				%>
   			</select><br>
    		<textarea rows = "5" cols = "50" placeholder="Enter description..." name = "description"></textarea><br>
    		<br><input type="submit" class="btn btn-info" value = "Add Department">
    	</fieldset>
	</form>
</div>