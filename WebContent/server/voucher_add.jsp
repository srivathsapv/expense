<%@ page import="utility.Utility,voucher.Voucher,voucher.Type,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%
	String title = Utility.filter(request.getParameter("title"));
	double amount = Double.parseDouble(Utility.filter(request.getParameter("amount")));
	String type = Utility.filter(request.getParameter("type"));
	String date = Utility.filter(request.getParameter("date"));
	String description = Utility.filter(request.getParameter("description"));
	
	Type new_vouchertype = new Type();
	
	new_vouchertype.setTitle(title);
	new_vouchertype.setDescription(description);


	boolean type_success = new_vouchertype.save();
	
	Voucher new_voucher = new Voucher();
	
	new_voucher.setAmount(amount);
	new_voucher.setDate();
	new_voucher.setTitle(title);
	//vouchertype undeclared
	boolean Voucher_success = new_voucher.save();
	
	if(type_success && Voucher_success)
	{
		response.sendRedirect("../pages/voucher_add.jsp?status=" + Utility.MD5("success"));
		return;
	}
	else {
		response.sendRedirect("../pages/voucher_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>	
	