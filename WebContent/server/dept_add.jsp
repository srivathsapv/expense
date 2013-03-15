<%@ page import="utility.Utility,user.Department,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String deptname = Utility.filter(request.getParameter("deptname"));
	String shortname = Utility.filter(request.getParameter("shortname"));
	String description = Utility.filter(request.getParameter("description"));
	String userid = Utility.filter(request.getParameter("userid"));
	
	String mode = request.getParameter("mode");
	
	Department new_department = null;
	if(mode.equals("0")){
		new_department = new Department();
	}
	else {
		new_department = new Department(Integer.parseInt(mode));
	}
	new_department.setDeptname(deptname);
	new_department.setUserid(userid);
	new_department.setShortname(shortname);
	new_department.setDescription(description);
	
	boolean department_success = new_department.save();
	String modestr = "";
	if(mode.equals("0")) modestr = "added";
	else modestr = "edited";
	if(department_success){
			response.sendRedirect("../pages/dept_list.jsp?status=" + Utility.MD5("success")+"&message=Department " + modestr + " successfully");
			return;
	}
%>