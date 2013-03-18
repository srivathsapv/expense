<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "org.json.JSONObject"%>
<%
	JSONObject obj = new JSONObject();
	String type = request.getParameter("type");
	
	if(type.equals("dept")){
		int deptid = Integer.parseInt(request.getParameter("deptid"));
		user.Department dept = new user.Department(deptid);
		obj = dept.toJSON();
	}
	else if(type.equals("policy")){
		int pid = Integer.parseInt(request.getParameter("pid"));
		policy.Policy policy = new policy.Policy(pid);
		obj = policy.toJSON();
	}
	else if(type.equals("vtype")){
		int vtypeid = Integer.parseInt(request.getParameter("vtypeid"));
		voucher.Type vtype = new voucher.Type(vtypeid);
		obj = vtype.toJSON();
	}
	else if(type.equals("user")){
		String userid = request.getParameter("userid");
		user.User user = new user.User(userid);
		obj = user.toJSON();
	}
	else if(type.equals("aconfig")){
		String configid = request.getParameter("configid");
		voucher.AmountConfig aconfig = new voucher.AmountConfig(Integer.parseInt(configid));
		obj = aconfig.toJSON();
	}
	else if(type.equals("rconfig")){
		String configid = request.getParameter("configid");
		user.RoleConfig rconfig = new user.RoleConfig(Integer.parseInt(configid));
		obj = rconfig.toJSON();
	}
%>
<%= obj %>