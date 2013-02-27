<%@ page import="utility.Utility,user.Department,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%
	String deptname = Utility.filter(request.getParameter("deptname"));
	String shortname = Utility.filter(request.getParameter("shortname"));
	String description = Utility.filter(request.getParameter("description"));
	
	Department new_department = new Department();
	
	new_department.setDeptname(deptname);
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