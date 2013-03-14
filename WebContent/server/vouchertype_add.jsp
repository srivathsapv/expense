<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,voucher.Type,voucher.vouchertype.*"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	String title = Utility.filter(request.getParameter("title"));
	String description = Utility.filter(request.getParameter("description"));
	String[] policyIds = request.getParameterValues("policy");
	String[] deptIds = request.getParameterValues("dept");
	Type vtype = new Type();
	vtype.setTitle(title);
	vtype.setDescription(description);
	
	boolean saved = vtype.save();
	
	for(String p : policyIds){
		Policy vtp = new Policy();
		vtp.setVtypeid(vtype.getVtypeid());
		vtp.setPolicyid(Integer.parseInt(p));
		vtp.save();
	}
	
	for(String d:deptIds){
		Department vtd = new Department();
		vtd.setDeptid(Integer.parseInt(d));
		vtd.setVtypeid(vtype.getVtypeid());
		vtd.save();
	}
	
	response.sendRedirect("../pages/vouchertype_add.jsp?status="+Utility.MD5("success"));
	return;
%>