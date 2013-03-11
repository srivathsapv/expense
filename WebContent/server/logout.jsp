<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	session.invalidate();
	response.sendRedirect("../pages/login.jsp");
	return;
%>