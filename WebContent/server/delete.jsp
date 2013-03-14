<%
	String type = request.getParameter("type");
	if(type.equals("vtype")){
		int vtypeid = Integer.parseInt(request.getParameter("vtypeid"));
		voucher.Type vtype = new voucher.Type(vtypeid);
		vtype.delete();
		if(request.getParameter("source").equals("list")){
			response.sendRedirect("../pages/vouchertype_list.jsp");
			return;
		}
	}
	else if(type.equals("voucher")){
		int vid = Integer.parseInt(request.getParameter("vid"));
		voucher.Voucher voucher = new voucher.Voucher(vid);
		voucher.delete();
		if(request.getParameter("source").equals("userlist")){
			user.User suser = (user.User)session.getAttribute("sessionUser");
			response.sendRedirect("../pages/voucher_list.jsp?userid="+suser.getUserid());
			return;
		}
	}
	else if(type.equals("policy")){
		int pid = Integer.parseInt(request.getParameter("pid"));
		policy.Policy policy = new policy.Policy(pid);
		policy.delete();
		if(request.getParameter("source").equals("list")){
			response.sendRedirect("../pages/policy_list.jsp");
			return;
		}
	}
%>