<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "auth.Authentication,user.User"%>
<%@ include file = "server_authenticate.jsp" %>  
<%
	if(request.getParameter("mode").equals("managers")) {
%>
	<option value = "">Choose Manager</option>
	<%
		User[] users = User.list("deptid",request.getParameter("deptid"));
		Authentication[] auths = Authentication.list("role","manager");
		
		for(Authentication a:auths){
			for(User u:users){
				if(u.getUserid().equals(a.getUserid())){
					%> <option value = <%=u.getUserid()%>><%= u.getFirstName() + " " + u.getlastName() %></option> <%
				}
			}
		}
	}
%>