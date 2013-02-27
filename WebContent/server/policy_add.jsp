<%@ page import="utility.Utility,policy.Policy,auth.Authentication,policy.Policy,java.text.*,java.util.*" %>
<%
	String title = Utility.filter(request.getParameter("title"));
	String description = Utility.filter(request.getParameter("description"));
	double amountPercent = Double.parseDouble(Utility.filter(request.getParameter("amountpercent")));
	String available = Utility.filter(request.getParameter("available"));
	
	Policy new_policy = new Policy();
	
	new_policy.setTitle(title);
	new_policy.setDescription(description);
new_policy.setAvailable(Integer.parseInt(available));	
new_policy.setAmountPercent(amountPercent);

boolean policy_success = new_policy.save();

if(policy_success)
{
		response.sendRedirect("../pages/policy_add.jsp?status=" + Utility.MD5("success"));
		return;
	}
else  {
		response.sendRedirect("../pages/policy_add.jsp?status=" + Utility.MD5("error"));
		return;
}

	
%>	