<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp"%>
<%@ page import = "user.User" %>
<link rel="stylesheet/less" href="../less/notification.less">
<style>
	.alert-error > a{
		color: #6f2c2b!important;
	}
	
	.alert-info > a{
		color: #235168!important;
	}
	
	.alert-warning > a{
		color: #735b32!important;
	}
	
	.alert-success > a{
		color: #2a522b!important;
	}
	.note-leaf {
		padding:12px!important;
	}
	
	.note-leaf > img {
		margin-right: 10px;
	}
	
</style>
<title>Vowcher - Dashboard</title>
<div id = "body-content">
	<%
		User user = (User)session.getAttribute("sessionUser");
		String name = user.getFirstName() + " " + user.getlastName();
	%>
	<legend>
		<span class = "to-hindi" id = "welcome-text">Welcome</span> <%= name %><br>
		<div id = "lastlogin" class = "font-italic">Your last login was on <%= session.getAttribute("lastlogin").toString() %></div>
	</legend>
	<div class = "alert alert-warning">
		<center><h4>Money Management Tip</h4><br>
			<img src = "../img/tip.png" style = "width:5%">
			<%
				out.println(utility.Utility.getRandomTip());
			%>
		</center>
	</div>
	
	<h3><i class = "icon-star notif-icon"></i><span class = "to-hindi">Notifications</span></h3>
	<div id = "notifications">
		<h4><img src = "../img/loading.gif" style = "width:4%;margin-top:-4px;margin-right:3px">Fetching notifications...</h4>
	</div>
</div>
<script>
	$(document).ready(function(){
		$.ajax({
			type: "POST",
			url: "../server/notification.jsp",
			success:function(msg){
				$("#notifications").html(msg);
			}
		});
	});
</script>