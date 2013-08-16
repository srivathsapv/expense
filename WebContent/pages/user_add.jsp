<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,utility.Utility,user.Department"%>
<%@ include file ="../include/layout.jsp" %>
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
				data : "mode=managers&deptid="+$(this).val()+"&role="+$("#role").val(),
				url : "../server/fetch_data.jsp",
				success:function(msg){
					$("#manager").html(msg);
				}
			});
		});
		
		$("#role").change(function(){
			if($("#deptid").val() == '') return;
			$.ajax({
				type : "POST",
				data : "mode=managers&deptid="+$("#deptid").val()+"&role="+$(this).val(),
				url : "../server/fetch_data.jsp",
				success:function(msg){
					$("#manager").html(msg);
				}
			});
			
			if($(this).val() == "md" || $(this).val() == "admin" || $(this).val() == "bckadmin"){
				$("#manager").attr("valtype","");
			}
			else {
				$("#manager").attr("valtype","required");
			}
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
<style>
	input[type='file']{
		margin-left: 10px!important;
	}
</style>
<%
	String userid = "";
	String title = "Vowcher - Add new User";
	String sUserid = session.getAttribute("sessionUsername").toString();
	Authentication cUser = new Authentication(sUserid);
	if(request.getParameter("mode") != null){
		userid = request.getParameter("userid");
		if(!sUserid.equals(userid)){
			boolean allowed=false;
			if(cUser.getRole().equals("md")){
				allowed = true;
			}
			else if(cUser.getRole().equals("ceo")){
				User curUser = new User(sUserid);
				User profileUser = new User(userid);
				if(curUser.getDeptid() == profileUser.getDeptid()){
					allowed=true;
				}
			}
			if(!allowed) {
			%> <div id = "body-content"><div class = "alert alert-error">You don't have access to this page</div></div><%
			return;
			}
		}
		title = "Vowcher - Edit User";
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=user&userid=<%=userid%>",
				success:function(msg){
					$("#userid").val(msg.userid);
					$("#firstName").val(msg.firstname);
					$("#middleName").val(msg.middlename);
					$("#lastName").val(msg.lastname);
					$("#socialSecurity").val(msg.socialsecurity);
					$("#dob").val(msg.dob);
					if(msg.gender == "M"){
						$("input[alt='male']").attr("checked","checked");
					}
					else {
						$("input[alt='female']").attr("checked","checked");
					}
					$("#role").val(msg.role);
					if(msg.role == "md" || msg.role == "admin" || msg.role == "bckadmin"){
						$("#manager").attr("valtype","");
					}
					$("#deptid").val(msg.deptid);
					$("#designation").val(msg.designation);
					$("textarea").text(msg.address);
					$("#phone").val(msg.phone);
					$("input[name='mobile']").val(msg.mobile);
					$("#email").val(msg.email);	
					
					$.ajax({
						type : "POST",
						data : "mode=managers&deptid="+msg.deptid+"&role="+$("#role").val(),
						url : "../server/fetch_data.jsp",
						success:function(msg2){
							$("#manager").html(msg2);
							$("#manager").val(msg.manager);
						}
					});
				}
			});
		</script> 
		<%
	}
%>
<title><%=title %></title>
<div id = "body-content">
	<form method = "POST" class = "validate" action = "../server/user_add.jsp" enctype="multipart/form-data">
  		<fieldset>
    		<legend>
    			<%
    				if(!userid.equals("")){
    					%> Edit User <%
    				}
    				else {
    					%>
    					New User
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details of the new user to be added</p> <%
    				}
    			%>
    		</legend><br>
    		<input class = "span4 required" type = "text" valtype = "required alphanumeric <% if(userid.equals("")) { %>unique_username<%} %>" valmsg = "Username should be alphanumeric" id = "userid" name = "userid" placeholder = "Choose a login ID ..."><br/>
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
   				<input type = "radio" alt = "male" id = "gender" name = "gender" value = "M" <% if(userid.equals("")) { %>checked <% }	 %>>
   				Male
   			</label>
   			<label class = "radio">
   				<input type = "radio" alt = "female" id = "gender" name = "gender" value = "F">
   				Female
   			</label>
   			<% if(!request.getParameter("mode").equals("edit") && cUser.getRole().equals("md")) { %>
   			<select class = "span4 required" valtype = "required" id = "role" name = "role">
   				<option value = "">Type of user</option>
   				<option value = "employee">Employee</option>
   				<option value = "manager">Manager</option>
   				<option value = "ceo">Chief Executive Officer</option>
   				<option value = "md">Managing Director</option>
   				<option value = "finance">Finance</option>
   				<option value = "admin">System Administrator</option>
   				<option value = "bckadmin">Backup Administrator</option>
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
   			<% } %>
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
    		
    		<%
    			String attach = "Upload";
    			if(!userid.equals("")) {
    				User user = new User(userid);
    				
    				
    				if(user.getPhoto() != null) {
    					if(!user.getPhoto().equals("")){
    						attach = "Change";
    						%> <div><img src = "../server/display_image.jsp?userid=<%= userid %>&mode=profile_picture" class = "profile-image img-rounded img-polaroid" width = 15%></div> <%
    					}
    				}
    			}
    		%>
    		
    		<br><label>&nbsp;&nbsp;&nbsp;&nbsp;<%=attach %> Photo (jpg, jpeg)</label><input id = "photo" name = "photo" class = "span4" type="file"><br><br>
    		<br><img src = "../captchaImg" class = "img-polaroid"><i class = "refresh icon-refresh poi" title = "Get another captcha"></i><br><br>
    		<input type = "text" class = "span4 required" valtype = "required" placeholder = "Enter the code shown above..." valmsg = "Code entered is incorrect" name = "captcha" id = "captcha"><br><br>
    		<input type = "hidden" name = "mode" id = "mode" value = "<%=userid %>">
    		
    		<%
    			if(!userid.equals("")) {
    			%> <button type="submit" class="btn btn-info"><i class = "icon-white icon-edit"></i>Save</button> <%
    			} else {
    		%>
    		<button type="submit" class="btn btn-success"><i class = "icon-white icon-plus"></i>Add User</button>
    		<% } %>
    	</fieldset>
	</form>
</div>