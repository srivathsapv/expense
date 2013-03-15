<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,auth.Authentication,utility.Utility"%>
<%
	String password = Utility.filter(request.getParameter("password"));
	
	User user = (User)session.getAttribute("sessionUser");
	
	Authentication auth = new Authentication(user.getUserid());
	auth.setPassword(password);
	boolean success = auth.save();
	if(success){
		response.sendRedirect("../pages/change_password.jsp?status="+Utility.MD5("success"));
		return;
	}
	
%>
