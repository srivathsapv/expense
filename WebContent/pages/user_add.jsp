<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "../include/layout.jsp"/>
<title>Vowcher - Add New User</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script type = "text/javascript">
	$(function(){
		$("#dp1").datepicker({format: 'dd-mm-yyyy'});	
	});
</script>
<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			New User
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details of the new user to be added</p>
    		</legend><br>
    		<input class = "span4" type="text" placeholder="First name..."><br>
    		<input class = "span4" type="text" placeholder="Middle name..."><br>
    		<input class = "span4" type="text" placeholder="Last Name..."><br>
    		<input class = "span4" type="text" placeholder="Social Security..."><br>
    		
    		<label>Date of Birth</label>
    		<div class = "input-append">
   				<input type="text" class="span4 append-input" placeholder="Date of birth..." id="dp1" >
   				<span class = "add-on"><i class="icon-calendar"></i></span>
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
    		<select class = "span4">
   				<option value = ''>Select your department</option>
   				<option value = 'type1'>Dept1</option>
   				<option value = 'type2'>Dept2</option>
   			</select><br>
   			<input class = "span4" type="text" placeholder="Designation..."><br>
    		<textarea rows="5" cols = "50" placeholder="Address..."></textarea><br>
    		<input class = "span4" type="text" placeholder="Phone number.."><br>
    		<input class = "span4" type="text" placeholder="Mobile number.."><br>
    		<input class = "span4" type="text" placeholder="Email..."><br>
    		<label>Upload Photo</label><input class = "span4" type="file"><br>
    		<br><input type="submit" class="btn btn-info" value = "Add User">
    	</fieldset>
	</form>
</div>