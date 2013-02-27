<%@ page import="utility.Utility,user.Department,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%
	String deptname = Utility.filter(request.getParameter("deptname"));
	String shortname = Utility.filter(request.getParameter("shortname"));
	String description = Utility.filter(request.getParameter("description"));
	String userid = Utility.filter(request.getParameter("userid"));
	
	Department new_department = new Department();
	
	new_department.setDeptname(deptname);
	new_department.setUserid(userid);
	new_department.setShortname(shortname);
	new_department.setDescription(description);
	
	boolean department_success = new_department.save();

	if(department_success)
	{
			response.sendRedirect("../pages/dept_add.jsp?status=" + Utility.MD5("success"));
			return;
	}
		
	else 
	{
			response.sendRedirect("../pages/dept_add.jsp?status=" + Utility.MD5("error"));
			return;
			
	}

%>