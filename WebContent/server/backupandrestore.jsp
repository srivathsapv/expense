<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,backupandrestore.BackupAndRestore"%>
<%@ page import="java.util.*" %>

<%
	String action = request.getParameter("action");
	boolean success = false;	
	BackupAndRestore bk = new BackupAndRestore();
	if(action.equals("backup")){
		success = bk.onlineBackup();
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
