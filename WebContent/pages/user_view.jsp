<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,user.User,user.Department,java.sql.*,java.io.*" %>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Profile</title> 
<div id = "body-content">
	<%
		String userid = request.getParameter("userid");
		User user = new User(userid);
		
		Department dept = new Department(user.getDeptid());
		String deptname = dept.getDeptname();
		
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<%= request.getParameter("message") %>
				</div> <%
			}
		}
	%>
<script src="../js/custom.js"></script>
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
	<legend>
		<h2 class = "profile-name">
			<%= user.getFirstName() + " " + user.getlastName() %>
			<button class = "btn btn-warning edit-user" alt = "user_add.jsp?mode=edit&userid=<%=userid %>"><i class = "icon-white icon-pencil"></i>Edit</button>
			<button class = "btn btn-danger del-user" alt = "user_add.jsp?mode=edit&userid=<%=userid %>"><i class = "icon-white icon-remove"></i>Delete</button>
		</h2>
		<span class = 'designation'><%= user.getDesignation() %> - <%= deptname %> Department</span><br>
		
	</legend>
	
	<% if(user.getPhoto() != null) {
		if(!user.getPhoto().equals("")) {
		%>
		<img src = "../server/display_image.jsp?userid=<%= userid %>&mode=profile_picture" class = "profile-image img-rounded img-polaroid" width = 15%>
	<% } 
		} if(user.getPhoto() == null || user.getPhoto().equals("")) { %>
		<img src = "../img/profile_default.png" class = "profile-image img-rounded img-polaroid" width = 15%>
	<% } %>
	<span class = 'profile-info address'>
		<i class = 'icon-home'></i>
		<%= user.getAddress() %>
	</span><br>
	<span class = 'profile-info phone'>
		<i class = 'icon-user'></i>
		+<%= user.getPhone() %>
	</span><br>
	<span class = 'profile-info mobile'>
		<i class = 'icon-star'></i>
		+<%= user.getMobile() %>
	</span><br>
	<span class = 'profile-info email'>
		<i class = 'icon-envelope'></i>
		<a href = 'mailto:<%= user.getEmail() %>'> <%= user.getEmail() %></a>
	</span>
</div>