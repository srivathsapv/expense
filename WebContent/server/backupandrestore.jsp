<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility"%>
<%@ page import="java.util.*" %>

<%
	String action = request.getParameter("action");
	boolean success = false;	
	if(action.equals("backup")){
		if(success){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-success"));
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-error"));
		}
	}else{
		if(success){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-success"));
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-error"));
		}
	}
	
%>
