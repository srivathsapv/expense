<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "voucher.AmountConfig"%>
<%@ include file = "../include/layout.jsp" %>
<%
	int configid = 0;
	String title = "Vowcher - Add Role Configuration";
	if(request.getParameter("mode") != null){
		configid = Integer.parseInt(request.getParameter("configid"));
		title = "Vowcher - Edit Role Configuration";
		AmountConfig aconfig = new AmountConfig(configid);
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=rconfig&configid=<%=configid%>",
				success:function(msg){
					$("select[name='role']").val(msg.role);
					$("input[name='claimLimit']").val(msg.claimlimit);
					$("input[name='acceptLimit']").val(msg.acceptlimit);
				}
			});
		</script> 
		<%
	}
%> 
<title><%= title %></title>
<div id = "body-content">
	<form method = "POST" class="validate" action = "../server/rconfig_add.jsp">
  		<fieldset>
  			<%
  				if(configid == 0){
  			%>
    		<legend>
    			Add role configuration
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to create a new amount configuration</p>
    		</legend><br>
    		<% } else { %>
    			<legend>
    			Edit amount configuration
    			</legend><br>
    		<% } %>
			<select class = "span4 required" valtype = "required" name = "role">
   				<option value = "">User Role</option>
   				<option value = "employee">Employee</option>
   				<option value = "mgr">Manager</option>
   				<option value = "ceo">Chief Executive Officer</option>
   				<option value = "md">Managing Director</option>
   			</select><br>
			<input class = "span4 required" type="text" valtype="required number" valmsg="Numeric value expected" placeholder="Enter the claim limit..." name = "claimLimit"> <br>
			<input class = "span4 required" type="text" valtype="required number" valmsg="Numeric value expected" placeholder="Enter the accept limit..." name = "acceptLimit"> <br>
			
			<input type = "hidden" name = "mode" value = "<%=configid %>">
	<%
		if(configid == 0) {
	%>
	<br/><button type="submit" class="btn btn-success"><i class = "icon-white icon-plus"></i>Add Configuration</button>
	<% } else { %>	
	<br/><button type="submit" class="btn btn-info"><i class = "icon-white icon-edit"></i>Save</button>
	<%} %>
	</fieldset>
	</form>
</div>