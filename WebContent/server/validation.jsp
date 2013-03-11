<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Validation,auth.Authentication,user.User,nl.captcha.Captcha"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	String valtype = request.getParameter("valtype");
	String value = request.getParameter("value");
	String msg = "";
	if(valtype.equals("number")){
		msg = Boolean.toString(Validation.isNumeric(value));
	}
	if(valtype.equals("decimal")){
		msg = Boolean.toString(Validation.isDecimal(value));
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
	
	if(valtype.equals("check_old")){
		User user = (User)session.getAttribute("sessionUser");
		Authentication auth = new Authentication(user.getUserid());
		if(!auth.isPassword(value))
			msg = "false";
		else
			msg = "true";
	}
	if(valtype.equals("pass_length")){
		if(value.length() < 6) 
			msg = "false";
		else
			msg = "true";
	}
	
	if(valtype.equals("captcha")){
		Captcha c = (Captcha)session.getAttribute(Captcha.NAME);
		request.setCharacterEncoding("UTF-8");
		String answer = request.getParameter("value");
		if(!c.isCorrect(answer))
			msg = "false";
		else
			msg = "true";
	}
%>
<%= msg %>