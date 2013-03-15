<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.Department,user.User"%>
<%@ include file = "../include/layout.jsp"%>
<%
	String deptid = "";
	Department dept = null;
	if(request.getParameter("deptid") != null){
		deptid = request.getParameter("deptid");
		dept = new Department(Integer.parseInt(deptid));
	}
%>
<script>
	$(document).ready(function(){
		$(".del-user").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".edit-user").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id ="body-content">
	<h1>User List</h1>
	<table class = "table table-striped table-bordered">
		<thead>
			<tr>
				<th>
					<h4>Name</h4>
				</th>
				<th>
					<h4>Department</h4>
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
				User[] users = null;
				if(deptid.equals("")){
					users = User.list("","");
					
				}
				else {
					users = User.list("DEPTID",deptid);
				}
				for(User u:users){
					Department d = new Department(u.getDeptid());
					String imgsrc = "../img/profile_default.png";
					if(u.getPhoto() != null){
						if(!u.getPhoto().equals("")) {
							imgsrc = "../server/display_image.jsp?mode=profile_picture&userid=" + u.getUserid();	
						}
					}
					%>
					<tr>
						
						<td><img class = "img-rounded" src = "<%=imgsrc %>" width = 5%>&nbsp;&nbsp;&nbsp;<a href = 'user_view.jsp?userid=<%=u.getUserid()%>'><%= u.getFirstName() + " " + u.getlastName() %></a></td>
						<td><%= d.getDeptname() %></td>
						<td><button class = "btn btn-warning edit-user" alt = "user_add.jsp?mode=edit&userid=<%=u.getUserid() %>">Edit</button>
						<td><button class = "btn btn-danger del-user" alt = "../server/delete.jsp?type=user&userid=<%=u.getUserid() %>&source=list&did=<%=d.getDeptid()%>">Delete</button></td>
					</tr>
					<%
				}
 			%>
		</tbody>
	</table>
	
</div>