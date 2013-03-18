<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "voucher.AmountConfig"%>
<%@ include file = "../include/layout.jsp" %>
<%
	int configid = 0;
	String title = "Vowcher - Add Amount Configuration";
	if(request.getParameter("mode") != null){
		configid = Integer.parseInt(request.getParameter("configid"));
		title = "Vowcher - Edit Amount Configuration";
		AmountConfig aconfig = new AmountConfig(configid);
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=aconfig&configid=<%=configid%>",
				success:function(msg){
					$("input[name='lowerLimit']").val(msg.lowerlimit);
					$("input[name='upperLimit']").val(msg.upperlimit);
					$("input[name='maxCount']").val(msg.maxcount);
				}
			});
		</script> 
		<%
	}
%> 
<title><%= title %></title>
<div id = "body-content">
	<%
		if(request.getParameter("errortype") != null){
			%> <div class = "alert alert-error">The given interval overlaps with an existing one</div> <%
		}
	%>
	<form method = "POST" class="validate" action = "../server/aconfig_add.jsp">
  		<fieldset>
  			<%
  				if(configid == 0){
  			%>
    		<legend>
    			Add amount configuration
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to create a new amount configuration</p>
    		</legend><br>
    		<% } else { %>
    			<legend>
    			Edit amount configuration
    			</legend><br>
    		<% } %>
			<input class = "span4 required" type="text" valtype="required number" valmsg="Numeric value expected" placeholder="Enter the lower limit..." name = "lowerLimit"> <br>
			<input class = "span4 required" type="text" valtype="required number" valmsg="Numeric value expected" placeholder="Enter the upper limit..." name = "upperLimit"> <br>
			<input class = "span4 required" type="text" valtype="required number" valmsg="Numeric value expected" placeholder="Enter the max count..." name = "maxCount"> <br>
			
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