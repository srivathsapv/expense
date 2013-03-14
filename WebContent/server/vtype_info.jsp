<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.*,voucher.vouchertype.*,org.json.JSONObject"%>
<%
	int vtypeid = Integer.parseInt(request.getParameter("vtypeid"));
	Type vtype = new Type(vtypeid);
	
	JSONObject vtypeobj = new JSONObject();
	vtypeobj.put("title",vtype.getTitle());
	vtypeobj.put("description",vtype.getDescription());
	
	Policy[] vtype_policies = Policy.list("VTYPEID",Integer.toString(vtypeid));
	String policystr = "<ul>";
	for(Policy p:vtype_policies) {
		policy.Policy pol = new policy.Policy(p.getPolicyid());
		policystr += "<li class = 'vtinfo'>" + pol.getTitle() + "<i title = '" + pol.getDescription() + "' class = 'icon-info-sign desc-ico poi'></i></li>";
	}
	policystr += "</ul>";
	
	Department[] vtype_depts = Department.list("VTYPEID",Integer.toString(vtypeid));
	String deptstr = "<ul>";
	for(Department d:vtype_depts){
		user.Department dep = new user.Department(d.getDeptid());
		deptstr += "<li class = 'vtinfo'>" + dep.getDeptname() + "<i title = '" + dep.getDescription() + "' class = 'icon-info-sign desc-ico poi'></i></li>";
	}
	deptstr += "</ul>";
	
	vtypeobj.put("policies",policystr);
	vtypeobj.put("departments",deptstr);
%>
<%= vtypeobj %>
