<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility"%>
<%
	String huserid = Utility.MD5("saranya");
	String pwd = Utility.MD5("asdf{"+huserid+"}");
	System.out.println(pwd);
%>