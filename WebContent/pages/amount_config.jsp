<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "policy.Policy,utility.Utility,voucher.AmountConfig"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Amount Configuration</title>
<script>
	$(document).ready(function(){
		$("#new-config").click(function(){
			window.location = "aconfig_add.jsp";
		});
		
		$(".delete-config").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".edit-config").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id = "body-content">
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<%=request.getParameter("message")%>
				</div> <%
			}
		}
	%>
	<legend>
		<h1>Amount Configuration</h1>
	</legend>
	<table class = "table table-striped table-bordered">
		<thead>
			<tr>
				<th>
					<h4>Lower Limit</h4>
				</th>
				<th>
					<h4>Upper Limit</h4>
				</th>
				<th>
					<h4>Max Count</h4>
				</th>
				<th>
					<h4>Edit</h4>
				</th>
				<th>
					<h4>Delete</h4>
				</th>
			</tr>
		</thead>
		<tbody>
			<%
				AmountConfig[] aconfig = AmountConfig.list("","");
				if(aconfig.length == 0) {
					%> No configurations added <%
				}
				for(AmountConfig a : aconfig){
					%>
					<tr>
						<td>
							<%=a.getLowerLimit() %>
						</td>
						<td>
							<%=a.getUpperLimit() %>
						</td>
						<td>
							<%=a.getMaxCount() %>
						</td>
						<td>
							<button class = "btn btn-warning edit-config" alt = "aconfig_add.jsp?mode=edit&configid=<%=a.getId() %>"><i class = "icon-white icon-pencil"></i>Edit</button>
						</td>
						<td>
							<button class = "delete-config btn btn-danger" alt = "../server/delete.jsp?type=aconfig&configid=<%=a.getId() %>&source=list"><i class = "icon-white icon-remove"></i>Delete</button>
						</td>
					</tr> 
					<%
				}
			%>
		</tbody>
	</table>
	<button class = "btn btn-success" id = "new-config"><i class = "icon-white icon-plus"></i>Add New</button>
</div>
