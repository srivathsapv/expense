<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "policy.Policy"%>
<%@ include file = "../include/layout.jsp" %>
<%
	int pid = 0;
	String title = "Vowcher - Add Policy";
	if(request.getParameter("mode") != null){
		pid = Integer.parseInt(request.getParameter("pid"));
		title = "Vowcher - Edit Policy";
		Policy policy = new Policy(pid);
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=policy&pid=<%=pid%>",
				success:function(msg){
					$("input[name='title']").val(msg.title);
					$("textarea").val(msg.description);
					$("input[name='amount']").val(msg.amount);
				}
			});
		</script> 
		<%
	}
%> 
<title><%= title %></title>
<div id = "body-content">
	<form method = "POST" class="validate" action = "../server/policy_add.jsp">
  		<fieldset>
  			<%
  				if(pid == 0){
  			%>
    		<legend>
    			Add new policy
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to create a new policy</p>
    		</legend><br>
    		<% } else { %>
    			<legend>
    			Edit policy
    			</legend><br>
    		<% } %>
			<input class = "span4 required" type="text" valtype="required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" placeholder="Enter the title..." name = "title"> <br>
			<textarea class="span4" rows="5" cols = "50" placeholder="Enter description..." name = "description"></textarea><br>
			<div class = "input-append">
   				<span class="required"><input type="text" class="span4 append-input" valtype="required number" valmsg="Numeric value expected" placeholder="Amount Percentage" id="dp1" name = "amount"><span class = "add-on" style="color:black;">%</span></span>	
   			</div>	
   			<br>
	<label>Available:</label>
	<label class="radio"><input type="radio" name="available" value="yes">Yes</label>
	<label class="radio"><input type="radio" name="available" value="no" >No</label>
	<input type ="hidden" name ="available" value = "null">
	<input type = "hidden" name = "mode" value = "<%=pid %>">
	<%
		if(pid == 0) {
	%>
	<br/><button type="submit" class="btn btn-success"><i class = "icon-white icon-plus"></i>Add Policy</button>
	<% } else { %>	
	<br/><button type="submit" class="btn btn-info"><i class = "icon-white icon-edit"></i>Save</button>
	<%} %>
	</fieldset>
	</form>
</div>