<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,utility.Utility,user.Department"%>
<%@ include file = "../include/layout.jsp" %>
<script src="../js/custom.js"></script>

<%
	int deptid = 0;
	String title = "Vowcher - Department Add";
	if(request.getParameter("mode") != null){
		deptid = Integer.parseInt(request.getParameter("deptid"));
		title = "Vowcher - Edit Department";
		Department dept = new Department(deptid);
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=dept&deptid=<%=deptid%>",
				success:function(msg){
					$("input[name='deptname']").val(msg.deptname);
					$("input[name='shortname']").val(msg.shortname);
					$("#userid").val(msg.userid);
					$("textarea").text(msg.description);
				}
			});
		</script> 
		<%
	}
%> 
<title><%=title %></title>
<div id = "body-content">
	<form method = "POST" class="validate" action = "../server/dept_add.jsp">
  		<fieldset>
  			<%
  				if(request.getParameter("mode") == null) {
  			%>
    		<legend>
    			Add new department
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Add a new department in the company</p>
    		</legend>
    		<% } else if(request.getParameter("mode").equals("edit")) {%>	
	    			<legend>
	    				Edit department
	    			</legend>
    		<%}%>
    		<br>
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
    		<input type = "hidden" name = "mode" value = <%=deptid %>>
    		<%
    			if(deptid == 0) {
    				%> <br><button type="submit" class="btn btn-success"><i class = "icon-white icon-plus"></i>Add Department</button> <% 		
    			}
    			else {
    				%> <br><button type="submit" class="btn btn-info"><i class = "icon-white icon-edit"></i>Save</button> <%
    			}
    		%>
    		
    	</fieldset>
	</form>
</div>