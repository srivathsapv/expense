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
%>
<%= obj %>