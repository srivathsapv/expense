<%@ page import="utility.Utility,auth.Authentication,voucher.AmountConfig,java.text.*,java.util.*" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	int lowerLimit = Integer.parseInt(request.getParameter("lowerLimit"));
	int upperLimit = Integer.parseInt(request.getParameter("upperLimit"));
	int maxCount = Integer.parseInt(request.getParameter("maxCount"));
	
	int configid = Integer.parseInt(request.getParameter("mode"));
	
	AmountConfig new_config;
	String modestr = "added";
	
	
	if(configid == 0){
		new_config = new AmountConfig();
	}
	else {
		new_config = new AmountConfig(configid);
		modestr = "edited";
	}
	
	new_config.setLowerLimit(lowerLimit);
	new_config.setUpperLimit(upperLimit);
	new_config.setMaxCount(maxCount);
	
	if(configid == 0) {
		AmountConfig[] existConfigs = AmountConfig.list("","");
		
		for(AmountConfig a: existConfigs) {
			if(lowerLimit >= a.getLowerLimit() && lowerLimit <= a.getUpperLimit() || 
			   upperLimit >= a.getLowerLimit() && upperLimit <= a.getUpperLimit()) {
				response.sendRedirect("../pages/aconfig_add.jsp?errortype=limitoverlap");
				return;
			}
		}
	}
	
	boolean config_success = new_config.save();
	
	if(config_success)
	{
		response.sendRedirect("../pages/amount_config.jsp?status=" + Utility.MD5("success")+"&message=Amount configuration " + modestr + " successfully");
		return;
	}
	
%>