<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp"%>
<%@ page import = "user.User" %>
<title>Vowcher - Dashboard</title>
<div id = "body-content">
	<%
		User user = (User)session.getAttribute("sessionUser");
		String name = user.getFirstName() + " " + user.getlastName();
	%>
	<legend>
		Welcome <%= name %><br>
		<div id = "lastlogin" class = "font-italic">Your last login was on <%= session.getAttribute("lastlogin").toString() %></div>
	</legend>
	
	<h3><i class = "icon-star notif-icon"></i>Notifications</h3>
</div>