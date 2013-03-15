<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "policy.Policy"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Policy List</title>
<script>
	$(document).ready(function(){
		$("#new-policy").click(function(){
			window.location = "policy_add.jsp";
		});
		
		$(".delete-policy").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".edit-policy").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id = "body-content">
	<legend>
		<h1>Policy list</h1>
	</legend>
	<table class = "table table-striped table-bordered">
		<thead>
			<tr>
				<th>
					<h4>Policy Name</h4>
				</th>
				<th>
					<h4>Description</h4>
				</th>
				<th>
					<h4>Amount Percent</h4>
				</th>
				<th>
					<h4>Available</h4>
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
				Policy[] policies = Policy.list("","");
				for(Policy p : policies){
					%>
					<tr>
						<td>
							<%=p.getTitle() %>
						</td>
						<td>
							<%=p.getDescription() %>
						</td>
						<td>
							<%=p.getAmountPercent() %>
						</td>
						<td>
							<%
								if(p.getAvailable() == 1){
									%> <i class = "icon-ok"></i> <% 
								}
								else {
									%> <i class = "icon-remove"></i> <%
								}
							%>
						</td>
						<td>
							<button class = "btn btn-warning edit-policy" alt = "policy_add.jsp?mode=edit&pid=<%=p.getPolicyid() %>">Edit</button>
						</td>
						<td>
							<button class = "delete-policy btn btn-danger" alt = "../server/delete.jsp?type=policy&pid=<%=p.getPolicyid() %>&source=list">Delete</button>
						</td>
					</tr> 
					<%
				}
			%>
		</tbody>
	</table>
	<button class = "btn btn-success" id = "new-policy">Add New</button>
</div>
