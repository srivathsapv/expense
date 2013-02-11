<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Add New User</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script type = "text/javascript">
	$(function(){
		$("#dp1").datepicker({format: 'dd-mm-yyyy'});	
	});
</script>
<div id = "body-content">
	<form method = "POST" class = "validate">
  		<fieldset>
    		<legend>
    			New User
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details of the new user to be added</p>
    		</legend><br>
    		<input class = "span4 required" type = "text" valtype = "required alphanumeric" valmsg = "Username should be alphanumeric" placeholder = "Choose a login ID ..."><br/>
    		<input class = "span4 required" valtype = "required alpha" valmsg="Invalid First name" type="text" placeholder="First name..."><br/>
    		<input class = "span4" type="text" valtype = "alpha" valmsg="Invalid Middle name" placeholder="Middle name..."><br>
    		<input class = "span4" type="text" valtype = "alpha" valmsg="Invalid Last name" placeholder="Last Name..."><br>
    		<input class = "span4 required" valtype = "required alphanumeric" valmsg="Invalid Social security key" type="text" placeholder="Social Security..."><br>
    		
    		<label>Date of Birth</label>
    		<div class = "input-append">
   				<input type="text" class="span4 append-input" valtype = "required" placeholder="Date of birth..." id="dp1" >
   				<span class = "add-on required"><i class="icon-calendar"></i></span>
   			</div>
   			<label>Gender</label>
   			<label class = "radio">
   				<input type = "radio" name = "gender" value = "male" checked>
   				Male
   			</label>
   			<label class = "radio">
   				<input type = "radio" name = "gender" value = "female">
   				Female
   			</label>
    		<select class = "span4 required" valtype = "required">
   				<option value = ''>Select your department</option>
   				<option value = 'type1'>Dept1</option>
   				<option value = 'type2'>Dept2</option>
   			</select><br>
   			<input class = "span4 required" valtype = "required alpha" valmsg="Invalid Designation" type="text" placeholder="Designation..."><br>
    		<textarea rows="5" cols = "50" placeholder="Address..."></textarea><br>
    		<div>
    		<span class="input-prepend">
				<span class="add-on rupee">+</span>
    			<input class = "span4 prepend-input" id="prependedInput" type="text" valtype = "number" valmsg = "Numeric value expected" placeholder="Phone number...">
    		</span>
    		</div><p></p>
    		<div>
    		<span class="input-prepend">
				<span class="add-on rupee">+</span>
    			<input class = "span4 prepend-input" id="prependedInput" type="text" valtype = "number" valmsg = "Numeric value expected" placeholder="Mobile...">
    		</span>
    		</div><p></p>
    		<input class = "span4 required" type="text" valtype = "email required" valmsg="Invalid e-mail id" placeholder="Email..."><br>
    		<label>Upload Photo</label><input class = "span4" type="file"><br>
    		<br><input type="submit" class="btn btn-info" value = "Add User">
    	</fieldset>
	</form>
</div>