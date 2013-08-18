<%@page import="java.io.File,java.io.FileWriter,java.io.BufferedWriter,backupandrestore.BackupAndRestore" %>
<%
	String dbname = request.getParameter("dbname");
	String username = request.getParameter("username");
	String pwd = request.getParameter("password");
	
	String path = config.getServletContext().getRealPath("/")+"temp/dbconfig.cfg";
	File file = new File(path);
	if(!file.exists()){
		file.createNewFile();
	}
	FileWriter fw = new FileWriter(file.getAbsoluteFile());
	BufferedWriter bw = new BufferedWriter(fw);
	
	String content = "database:" + dbname + ":\nusername:" + username + ":\npassword:" + pwd + ":";
	
	bw.write(content);
	bw.close();
	
	response.sendRedirect("../pages/login.jsp");
%>