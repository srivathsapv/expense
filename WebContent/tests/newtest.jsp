<%@ page import = "java.io.*" %>
<%
	String path = config.getServletContext().getRealPath("/")+"drafts/";
	String files;
	File folder = new File(path);
	File[] listOfFiles = folder.listFiles(); 

	for (int i = 0; i < listOfFiles.length; i++) 
	{
		if (listOfFiles[i].isFile()) 
 		{
 			files = listOfFiles[i].getName();
 			System.out.println(files);
    	}
	}
%>