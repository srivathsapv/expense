<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "policy.Policy,utility.Utility"%>
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
							<button class = "btn btn-warning edit-policy" alt = "policy_add.jsp?mode=edit&pid=<%=p.getPolicyid() %>"><i class = "icon-white icon-pencil"></i>Edit</button>
						</td>
						<td>
							<button class = "delete-policy btn btn-danger" alt = "../server/delete.jsp?type=policy&pid=<%=p.getPolicyid() %>&source=list"><i class = "icon-white icon-remove"></i>Delete</button>
						</td>
					</tr> 
					<%
				}
			%>
		</tbody>
	</table>
	<button class = "btn btn-success" id = "new-policy"><i class = "icon-white icon-plus"></i>Add New</button>
</div>
