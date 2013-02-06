<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Validation"%>
<%
	String valtype = request.getParameter("valtype");
	String value = request.getParameter("value");
	String msg = "";
	if(valtype.equals("number")){
		msg = Boolean.toString(Validation.isNumeric(value));
	}
	//include other validation types here
%>
<%= msg %>