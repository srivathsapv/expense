<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "auth.Authentication,user.User,org.apache.commons.lang3.ArrayUtils"%>
<%@ include file = "server_authenticate.jsp" %>  
<%
	
	if(request.getParameter("mode").equals("managers")) {
%>
	<option value = "">Choose Manager</option>
	<%
		String role = request.getParameter("role");
		Authentication[] auths = null;
		//rendering the manager according to the user role
		if(role.equals("employee")){
			auths = Authentication.list("ROLE","mgr");	
		}
		else if(role.equals("manager")){
			Authentication[] a1 = Authentication.list("ROLE","mgr");
			Authentication[] a2 = Authentication.list("ROLE","ceo");
			auths = ArrayUtils.addAll(a1,a2);
		}
		else if(role.equals("ceo")){
			auths = Authentication.list("ROLE","md");
		}
		else if(role.equals("finance")){
			auths = Authentication.list("ROLE","finance");
						
		}
		User[] users = null;
		if(role.equals("ceo") || role.equals("finance")){
			users = User.list("","");
		}
		else {
			users = User.list("DEPTID",request.getParameter("deptid"));
		}
		
		if(auths == null) return;
		for(Authentication a:auths){
			for(User u:users){
				if(u.getUserid().equals(a.getUserid())){
					%> <option value = <%=u.getUserid()%>><%= u.getFirstName() + " " + u.getlastName() %></option> <%
				}
			}
		}
	}
%>