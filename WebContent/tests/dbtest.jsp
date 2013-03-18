<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "db.Db,utility.Utility" %>
    
<%
	

	String a = Utility.MD5("srivathsa");
	String b = Utility.MD5("asdf{"+a+"}");
	System.out.println(b);
%>
