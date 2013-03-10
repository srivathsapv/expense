<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.File"%>
<%
	File file = new File(config.getServletContext().getRealPath("/")+"drafts/"+request.getParameter("filename"));
	file.delete();
%>