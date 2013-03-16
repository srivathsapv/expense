<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,voucher.Type,voucher.vouchertype.*,db.Db"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	String title = Utility.filter(request.getParameter("title"));
	String description = Utility.filter(request.getParameter("description"));
	String[] policyIds = request.getParameterValues("policy");
	String[] deptIds = request.getParameterValues("dept");
	int mode = Integer.parseInt(request.getParameter("mode"));
	
	Type vtype = null;
	String modestr = "";
	
	if(mode == 0) {
		vtype = new Type();
		modestr = "added";
	}
	else {
		vtype = new Type(mode);
		modestr = "edited";
	}
	
	vtype.setTitle(title);
	vtype.setDescription(description);
	
	boolean saved = vtype.save();
	
	Db db = new Db();
	db.connect();
	db.delete("VOUCHERTYPE_DEPT","VTYPEID",Integer.toString(mode));
	db.delete("VOUCHERTYPE_POLICY","VTYPEID",Integer.toString(mode));
	db.disconnect();
	
	if(policyIds != null) {
		for(String p : policyIds){
			Policy vtp = new Policy();
			vtp.setVtypeid(vtype.getVtypeid());
			vtp.setPolicyid(Integer.parseInt(p));
			vtp.save();
		}	
	}
	
	if(deptIds != null) {
		for(String d:deptIds){
			Department vtd = new Department();
			vtd.setDeptid(Integer.parseInt(d));
			vtd.setVtypeid(vtype.getVtypeid());
			vtd.save();
		}	
	}
	
	response.sendRedirect("../pages/vouchertype_list.jsp?status="+Utility.MD5("success")+"&message=Voucher type " + modestr + " successfully");
	return;
%>