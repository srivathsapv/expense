<%@ page import="utility.Utility,auth.Authentication,user.RoleConfig,java.text.*,java.util.*" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String role = request.getParameter("role");
	int climit = Integer.parseInt(request.getParameter("claimLimit"));
	int alimit = Integer.parseInt(request.getParameter("acceptLimit"));
	
	int configid = Integer.parseInt(request.getParameter("mode"));
	
	RoleConfig new_config;
	String modestr = "added";
	
	
	if(configid == 0){
		new_config = new RoleConfig();
	}
	else {
		new_config = new RoleConfig(configid);
		modestr = "edited";
	}
	
	new_config.setRole(role);
	new_config.setClaimLimit(climit);
	new_config.setAcceptLimit(alimit);
	
	
	
	boolean config_success = new_config.save();
	
	if(config_success)
	{
		response.sendRedirect("../pages/role_config.jsp?status=" + Utility.MD5("success")+"&message=Role configuration " + modestr + " successfully");
		return;
	}
	
%>