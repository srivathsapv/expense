<%@ page import="utility.Utility,policy.Policy,auth.Authentication,policy.Policy,java.text.*,java.util.*" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String title = Utility.filter(request.getParameter("title"));
	String description = Utility.filter(request.getParameter("description"));
	double amountPercent = Double.parseDouble(Utility.filter(request.getParameter("amount")));
	String available = Utility.filter(request.getParameter("available"));
	
	int pid = Integer.parseInt(request.getParameter("mode"));
	
	Policy new_policy;
	String modestr = "added";
	
	
	if(pid == 0){
		new_policy = new Policy();
	}
	else {
		new_policy = new Policy(pid);
		modestr = "edited";
	}
	
	new_policy.setTitle(title);
	new_policy.setDescription(description);
	
	if(available.equals("yes") || available.equals("null"))
		new_policy.setAvailable(1);
	else 
		new_policy.setAvailable(0);
	
	new_policy.setAmountPercent(amountPercent);

	boolean policy_success = new_policy.save();
	
	if(policy_success)
	{
		response.sendRedirect("../pages/policy_list.jsp?status=" + Utility.MD5("success")+"&message=Policy " + modestr + " successfully");
		return;
	}
	else  {
		response.sendRedirect("../pages/policy_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>