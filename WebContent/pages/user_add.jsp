<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "user.Department,utility.Utility"%>
<%@ include file ="../include/layout.jsp" %>
<title>Vowcher - Add New User</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script type = "text/javascript">
	$(function(){
		$("#dob").datepicker({format: 'dd-mm-yyyy'});
		$(".refresh").click(function(){
			$("img[src='../captchaImg']").attr("src","../captchaImg");
		});
		$("#deptid").change(function(){
			$.ajax({
				type : "POST",
				data : "mode=managers&deptid="+$(this).val(),
				url : "../server/fetch_data.jsp",
				success:function(msg){
					$("#manager").html(msg);
				}
			});
		});
		
		$("#photo").change(function(){
			var filename = $(this).val();
			var ext = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			ext = ext.toLowerCase();
			
			if(!(ext == "jpeg" || ext == "jpg" || ext =="png")) {
				alert("." + ext + " files are not allowed");
				$(this).val("");
			}
		});
		
	});
</script>
<div id = "body-content">
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">User added successfully</div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("error"))) {
				%> <div class = "alert alert-error">Error while adding user</div> <%	
			}	
		}
	%>
	<form method = "POST" class = "validate" action = "../server/user_add.jsp" enctype="multipart/form-data">
  		<fieldset>
    		<legend>
    			New User
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details of the new user to be added</p>
    		</legend><br>
    		<input class = "span4 required" type = "text" valtype = "required alphanumeric unique_username" valmsg = "Username should be alphanumeric" id = "userid" name = "userid" placeholder = "Choose a login ID ..."><br/>
    		<input class = "span4 required" valtype = "required alpha" valmsg="First name should contain only alphabets" type="text" id = "firstName" name = "firstName" placeholder="First name..."><br/>
    		<input class = "span4" type="text" valtype = "alpha" valmsg="Middle name should contain only alphabets" id = "middleName" name = "middleName" placeholder="Middle name..."><br>
    		<input class = "span4" type="text" valtype = "alpha" valmsg="Last name should contain only alphabets" id = "lastName" name = "lastName" placeholder="Last Name..."><br>
    		<input class = "span4 required" valtype = "required alphanumeric" valmsg="Invalid Social security key" id = "socialSecurity" name = "socialSecurity" type="text" placeholder="Social Security..."><br>
    		
    		<label>Date of Birth</label>
    		<div class = "input-append">
   				<input type="text" class="span4 append-input" id = "dob" name = "dob" valtype = "required" placeholder="Date of birth..." >
   				<span class = "add-on required"><i class="icon-calendar"></i></span>
   			</div>
   			<label>Gender</label>
   			<label class = "radio">
   				<input type = "radio" id = "gender" name = "gender" value = "M" checked>
   				Male
   			</label>
   			<label class = "radio">
   				<input type = "radio" id = "gender" name = "gender" value = "F">
   				Female
   			</label>
   			<select class = "span4 required" valtype = "required" id = "role" name = "role">
   				<option value = "">Type of user</option>
   				<option value = "employee">Employee</option>
   				<option value = "manager">Manager</option>
   				<option value = "ceo">Chief Executive Officer</option>
   				<option value = "md">Managing Director</option>
   			</select><br>
    		<select class = "span4 required" valtype = "required" id = "deptid" name = "deptid">
    			<option value = "">Choose Department</option>
   				<%
   					Department[] depts = Department.list("","");
   					for(Department d : depts) {
   						%> <option value = "<%= d.getDeptid() %>"><%= d.getDeptname() %></option> <%
   					}
   				%>
   			</select><br>
   			<select class = "span4 required" valtype = "required" id = "manager" name = "manager">
   				<option value = "">Choose Manager</option>
   			</select><br>
   			<input class = "span4 required" id = "designation" name = "designation" valtype = "required alpha" valmsg="Designation should contain only alphabets" type="text" placeholder="Designation..."><br>
    		<textarea rows="5" cols = "50" name = "address" placeholder="Address..."></textarea><br>
    		<div>
    		<span class="input-prepend">
				<span class="add-on rupee">+</span>
    			<input class = "span4 prepend-input" id = "phone" name = "phone" id="prependedInput" type="text" valtype = "number" valmsg = "Numeric value expected" placeholder="Phone number...">
    		</span>
    		</div><p></p>
    		<div>
    		<span class="input-prepend">
				<span class="add-on rupee">+</span>
    			<input class = "span4 prepend-input" id="prependedInput" id = "mobile" name = "mobile" type="text" valtype = "number" valmsg = "Numeric value expected" placeholder="Mobile...">
    		</span>
    		</div><p></p>
    		<input class = "span4 required" type="text" id = "email" name = "email" valtype = "email required" valmsg="Invalid e-mail id" placeholder="Email..."><br>
    		<label>Upload Photo (jpg, jpeg, png)</label><input id = "photo" name = "photo" class = "span4" type="file"><br><br>
    		<img src = "../captchaImg" class = "img-polaroid"><i class = "refresh icon-refresh poi"></i><br><br>
    		<input type = "text" class = "span4 required" valtype = "required" placeholder = "Enter the code shown above..." valmsg = "Code entered is incorrect" name = "captcha" id = "captcha"><br><br>
    		<input type="submit" class="btn btn-info" value = "Add User">
    	</fieldset>
	</form>
</div>