<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="auth.Authentication" %>
<%
	if(request.getParameter("mode") != null) {
		if(request.getParameter("mode").equals("sid")) {
			Authentication auth = new Authentication(request.getParameter("username").toString());
			auth.setSecureId("");
			auth.save();	
		}
	}
	session.invalidate();
	response.sendRedirect("../pages/login.jsp");
	return;
%>