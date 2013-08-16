<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,backupandrestore.BackupAndRestore"%>
<%@ page import="java.util.*" %>

<%
	String action = request.getParameter("action");
	boolean success = false;	
	BackupAndRestore bk = new BackupAndRestore();
	String timestamp ="";
	if(action.equals("backup")){
		success = bk.onlineBackup();
		if(success){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-success"));
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-error"));
		}
	}else{
		timestamp = bk.lastBackupDate();
		success = bk.restore(timestamp);
		if(success){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-success"));
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-error"));
		}
	}
	
%>
