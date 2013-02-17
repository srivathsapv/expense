<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Validation,auth.Authentication"%>
<%
	String valtype = request.getParameter("valtype");
	String value = request.getParameter("value");
	String msg = "";
	if(valtype.equals("number")){
		msg = Boolean.toString(Validation.isNumeric(value));
	}
	
	if(valtype.equals("alpha")){
		msg = Boolean.toString(Validation.isAlpha(value, 0));
	}
	
	if(valtype.equals("alphanumeric")){
		msg = Boolean.toString(Validation.isAlphaNumeric(value, 0));
	}
	
	if(valtype.equals("email")){
		msg = Boolean.toString(Validation.isEmail(value));
	}
	
	if(valtype.equals("alphawithspace")){
		msg = Boolean.toString(Validation.isAlpha(value, 1));
	}
	
	if(valtype.equals("alphanumericwithspace")){
		msg = Boolean.toString(Validation.isAlphaNumeric(value, 1));
	}
	
	if(valtype.equals("unique_username")) {
		int n = Authentication.count("USERID",value);
		if(n > 0) 
			msg = "false";
		else 
			msg = "true";
		
	}
	
	//include other validation types here
%>
<%= msg %>