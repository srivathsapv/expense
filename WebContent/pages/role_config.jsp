<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "policy.Policy,utility.Utility,user.RoleConfig"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Role Configuration</title>
<script>
	$(document).ready(function(){
		
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
					<%= request.getParameter("message") %>
				</div> <%
			}
		}
	%>
	<legend>
		<h1>Role Configuration</h1>
	</legend>
	<table class = "table table-striped table-bordered">
		<thead>
			<tr>
				<th>
					<h4>Role</h4>
				</th>
				<th>
					<h4>Claim Limit</h4>
				</th>
				<th>
					<h4>Acceptance Limit</h4>
				</th>
				<th>
					<h4>Edit</h4>
				</th>
			</tr>
		</thead>
		<tbody>
			<%
				RoleConfig[] rconfig = RoleConfig.list("","");
				if(rconfig.length == 0) {
					%> No configurations added <%
				}
				for(RoleConfig a : rconfig){
					%>
					<tr>
						<td>
							<%=a.getRole() %>
						</td>
						<td>
							<%=a.getClaimLimit() %>
						</td>
						<td>
							<%=a.getAcceptLimit() %>
						</td>
						<td>
							<button class = "btn btn-warning edit-config" alt = "rconfig_add.jsp?mode=edit&configid=<%=a.getId() %>"><i class = "icon-white icon-pencil"></i>Edit</button>
						</td>
					</tr> 
					<%
				}
			%>
		</tbody>
	</table>
</div>
