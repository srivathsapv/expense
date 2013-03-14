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
				%> <div class = "alert alert-success">User added successfully</div> <%
			}
		}
	%>
<script src="../js/custom.js"></script>
	<legend>
		<h2 class = 'profile-name'><%= user.getFirstName() + " " + user.getlastName() %></h2>
		<span class = 'designation'><%= user.getDesignation() %> - <%= deptname %> Department</span>
	</legend>
	<% if(user.getPhoto() != null) { %>
		<img src = "../server/display_image.jsp?userid=<%= userid %>&mode=profile_picture" class = "profile-image img-rounded img-polaroid" width = 15%>
	<% } else { %>
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