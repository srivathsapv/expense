<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,backupandrestore.BackupAndRestore"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%
	String[] values = new String[1];
	String path="";
	int i=0;
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
	} else {
		FileItemFactory factory = new DiskFileItemFactory();
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    List items = null;
	    try {
	    	items = upload.parseRequest(request);
	    } 
	    catch (FileUploadException e) {
	    	e.printStackTrace();
	    }
	    Iterator itr = items.iterator();
	    while (itr.hasNext()) {
	        FileItem item = (FileItem) itr.next();
	        if (item.isFormField()) {
	        		values[i++] =  item.getString();
	        } 
	        else {
	        	try {	        		
		            String itemName = item.getName();
		            path = config.getServletContext().getRealPath("/")+"uploads/"+itemName;
		            File savedFile = new File(path);
		            item.write(savedFile);          
	            } catch (Exception e) {
	            	e.printStackTrace();
	            }
	       	}
		}
	}	
	
	String action = request.getParameter("action");
	String zipFile = "";
	BackupAndRestore bk = new BackupAndRestore();
	System.out.println(config.getServletContext().getRealPath("/")+"uploads/");
	bk.init(config.getServletContext().getRealPath("/")+"uploads/");
	String timestamp ="";
	if(action.equals("backup")){
		zipFile = bk.onlineBackup();
		if(!zipFile.equals("")){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-success")+"&zipfile="+zipFile);
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("backup-error"));
		}
	}else{
		timestamp = bk.lastBackupDate();
		boolean success = bk.restore(timestamp,path);
		if(success){
			response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-success"));
			return;
		}else{
		response.sendRedirect("../pages/backupandrestore.jsp?status="+Utility.MD5("restore-error"));
		}
	}
%>
