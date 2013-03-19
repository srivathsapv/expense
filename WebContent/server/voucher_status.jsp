<%@ page import = "auth.Authentication,java.util.Calendar,java.sql.ResultSet,db.Db,voucher.Status,voucher.AmountConfig,user.RoleConfig,voucher.Voucher,utility.Utility" %>
<%
	String stat = request.getParameter("status");
	int vid = Integer.parseInt(request.getParameter("vid"));
	
	String status = "";
	if(stat.equals("accept")) {
		//accept limit check
		Voucher vouch = new Voucher(vid);
		double amount = vouch.getAmount();
		Authentication auth = new Authentication(session.getAttribute("sessionUsername").toString());
		Db db = new Db();
		db.connect();
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM VOUCHER_STATUS WHERE VOUCHERID = " + Integer.toString(vid) + " AND STATUS = 'accepted'");
		rs.next();
		
		ResultSet rs2 = db.executeQuery("SELECT MAXCOUNT FROM AMOUNT_CONFIG WHERE LOWER_LIMIT <= " + Double.toString(amount) + " AND UPPER_LIMIT >= " + Double.toString(amount));
		rs2.next();
		
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH)+1;
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String mstr = "";
		
		if(month < 10) 
			mstr = "0" + Integer.toString(month);
		else
			mstr = Integer.toString(month);
		
		System.out.println("count from status - " + rs.getInt(1));
		System.out.println("maxcount from amt-config - " + rs2.getInt(1));
		
		if(rs2.getInt(1) - rs.getInt(1) == 1) {
			String query = "SELECT SUM(AMOUNT) FROM VOUCHER WHERE VOUCHERID IN(" +
					"SELECT VOUCHERID FROM VOUCHER_STATUS WHERE STATUS = 'accepted'" + 
					" AND USERID = '" + session.getAttribute("sessionUsername").toString() + "' " +
					" AND DATE LIKE '" + year + "-" + mstr + "-__')";
			System.out.println(query);
			ResultSet rs3 = db.executeQuery(query);
			rs3.next();
			
			query = "SELECT ACCEPT_LIMIT FROM ROLECONFIG WHERE ROLE = '" + auth.getRole() + "'";
			
			ResultSet rs4 = db.executeQuery(query);
			rs4.next();
			
			if((rs3.getInt(1) + amount) > rs4.getInt(1)){
				response.sendRedirect("../pages/voucher_view.jsp?id=" + Integer.toString(vid) + "&status="+Utility.MD5("error") + "&message=Sorry. You cannot accept this voucher as your acceptance limit is over");
				return;
			}								
		}
		//accept limit check
		
		
		status = "accepted";
	}
	else if(stat.equals("consider")){
		status = "under consideration";
	}
	else if(stat.equals("reject")){
		status = "rejected";
		Voucher vouch = new Voucher(vid);
		vouch.setRejectReason(request.getParameter("reason"));
		vouch.save();
	}
	
	Status vstatus = new Status();
	vstatus.setStatus(status);
	vstatus.setTime();
	vstatus.setVoucherid(vid);
	vstatus.setUserid(session.getAttribute("sessionUsername").toString());
	
	if(vstatus.save()) {
		response.sendRedirect("../pages/voucher_view.jsp?id=" + Integer.toString(vid) + "&status="+Utility.MD5("success") + "&message=Status updated successfully");
		return;
	}
%>