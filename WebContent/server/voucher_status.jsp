<%@ page import = "user.*,sms.SMS,auth.Authentication,java.util.Calendar,java.sql.ResultSet,db.Db,voucher.Status,voucher.AmountConfig,user.RoleConfig,voucher.Voucher,utility.Utility" %>
<%
	String stat = request.getParameter("status");
	int vid = Integer.parseInt(request.getParameter("vid"));
	
	String status = "";
	Voucher vouch = new Voucher(vid);
	String voucher_level = "middle";
	if(stat.equals("accept")) {
		//accept limit check
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
		
		if(rs2.getInt(1) - rs.getInt(1) == 1) {
			String query = "SELECT SUM(AMOUNT) FROM VOUCHER WHERE VOUCHERID IN(" +
					"SELECT VOUCHERID FROM VOUCHER_STATUS WHERE STATUS = 'accepted'" + 
					" AND USERID = '" + session.getAttribute("sessionUsername").toString() + "' " +
					" AND DATE LIKE '" + year + "-" + mstr + "-__')";
			ResultSet rs3 = db.executeQuery(query);
			rs3.next();
			
			query = "SELECT ACCEPT_LIMIT FROM ROLECONFIG WHERE ROLE = '" + auth.getRole() + "'";
			
			ResultSet rs4 = db.executeQuery(query);
			rs4.next();
			
			if((rs3.getInt(1) + amount) > rs4.getInt(1)){
				response.sendRedirect("../pages/voucher_view.jsp?id=" + Integer.toString(vid) + "&status="+Utility.MD5("error") + "&message=Sorry. You cannot accept this voucher as your acceptance limit is over");
				return;
			}
			voucher_level = "terminal";
			
		}
		//accept limit check
		
		status = "accepted";
		
		if(request.getParameter("policyid") != null) {
			vouch.setPolicyid(Integer.parseInt(request.getParameter("policyid")));
			vouch.save();
		}
		
	}
	else if(stat.equals("consider")){
		status = "under consideration";
	}
	else if(stat.equals("reject")){
		status = "rejected";
		
		vouch.setRejectReason(request.getParameter("reason"));
		vouch.save();
	}
	else if(stat.equals("sanction")){
		status = "sanctioned";
	}
	
	Status vstatus = null;
	if(request.getParameter("mode") != null) {
		if(request.getParameter("mode").equals("edit")) {
			Db db = new Db();
			db.connect();
			ResultSet rs = db.executeQuery("SELECT * FROM VOUCHER_STATUS WHERE USERID = '" + session.getAttribute("sessionUsername").toString() + "' AND VOUCHERID = " + Integer.toString(vid) + " ORDER BY TIME DESC");
			rs.next();
			vstatus = new Status(rs.getInt("STATUSID"));
			
			if(vstatus.getStatus().equals("under consideration") && status.equals("accepted")) {
				vstatus = new Status();
			}
			
			db.disconnect();
		}	
	}
	else {
		vstatus = new Status();
	}
	
	vstatus.setStatus(status);
	vstatus.setTime();
	vstatus.setVoucherid(vid);
	vstatus.setUserid(session.getAttribute("sessionUsername").toString());
	vstatus.save();
	
	User authority_user = (User)session.getAttribute("sessionUser");
	
	Notification notif = new Notification();
	notif.setCategoryid(Integer.toString(vid));
	notif.setTimeupdate();	
	if(status.equals("accepted")){
		if(voucher_level.equals("terminal") || session.getAttribute("sessionUserRole").toString().equals("md")){
			Authentication[] finance_officers = Authentication.list("ROLE","finance");
			for(Authentication a:finance_officers){
				Notification n = new Notification();
				n.setCategory("sanction");
				n.setCategoryid(Integer.toString(vid));
				n.setTimeupdate();
				n.setUserid(a.getUserid());
				n.save();
			}
		}
		else {
			notif.setCategory("voucher");
			notif.setUserid(authority_user.getManager());
		}
	}
	else if(status.equals("sanctioned")){
		Db db = new Db();
		db.connect();
		ResultSet rs = db.executeQuery("SELECT USERID FROM VOUCHER_STATUS WHERE VOUCHERID = " + Integer.toString(vid) + " AND STATUS = 'accepted'");
		while(rs.next()){
			Notification n = new Notification();
			n.setCategory("voucher sanction");
			n.setCategoryid(Integer.toString(vid));
			n.setTimeupdate();
			n.setUserid(rs.getString(1));
			n.save();
		}
	}
	else if(status.equals("rejected")){
		Db db = new Db();
		db.connect();
		ResultSet rs = db.executeQuery("SELECT * FROM VOUCHER_STATUS WHERE STATUS IN ('accepted','under consideration') AND VOUCHERID = '" + Integer.toString(vid) + "'");
		
		ResultSet rs2 = db.executeQuery("SELECT * FROM NOTIFICATION WHERE CATEGORY = 'voucher status change' AND CATEGORYID IN (SELECT STATUSID FROM VOUCHER_STATUS WHERE VOUCHERID = '" + Integer.toString(vid) + "')");
		while(rs2.next()){
			Notification n = new Notification(rs2.getInt(1));
			n.delete();
		}
		
		while(rs.next()){
			Status s = new Status(rs.getInt("STATUSID"));
			
			rs2 = db.executeQuery("SELECT * FROM NOTIFICATION WHERE  ID = '" + s.getUserid() + "' AND CATEGORY = 'voucher' AND CATEGORYID = '" + Integer.toString(vid) + "'");
			
			if(rs2.next()) {
				Notification n = new Notification(rs2.getInt(1));
				n.setCategory("rejected");
				n.setCategoryid(Integer.toString(vstatus.getStatusid()));
				n.save();
			}
			s.delete();
			
			
			
		}
	}
	if(notif.getCategory() != null)
		notif.save();
	
	Notification user_notif = new Notification();
	user_notif.setCategory("voucher status change");
	user_notif.setCategoryid(Integer.toString(vstatus.getStatusid()));
	user_notif.setUserid(vouch.getUserid());
	user_notif.setTimeupdate();
	user_notif.save();

	String statStr = vstatus.getStatus();
	 if(statStr.equals("under consideration")) {
	        statStr = "considered";
	 }
	String msgBody = "Your voucher - " + vouch.getTitle() + " has been " + statStr;
	
	User vuser = new User(vouch.getUserid());
	
	SMS sms = new SMS();
	sms.setAdb_path(config.getServletContext().getRealPath("/")+"adb/");
	sms.setNumber(vuser.getMobile());
	sms.setMessage(msgBody);
	sms.send();

	response.sendRedirect("../pages/voucher_view.jsp?id=" + Integer.toString(vid) + "&status="+Utility.MD5("success") + "&message=Status updated successfully");
	return;
%>