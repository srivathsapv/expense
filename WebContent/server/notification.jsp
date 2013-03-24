<%@page import = "java.text.SimpleDateFormat,
				  java.sql.ResultSet,
				  db.Db,
				  user.Notification,
				  user.User,
				  java.util.Date,
				  voucher.Status,
				  voucher.Voucher,
				  com.ocpsoft.pretty.time.*"%>
<%
	
	String username = session.getAttribute("sessionUsername").toString();
	Notification[] notifs = Notification.list("USERID",username);
	if(notifs.length == 0) {
		%> No notifications to be displayed <%
	}
	String notif_msg = "";
	String notif_class = "";
	String img_url = "";
%>
<%
	for(Notification notif:notifs){
		Status stat = null;
		Voucher vouch = null;
		User user = null;
		User statuser = null;
		
		if(notif.getCategory().equals("voucher status change")) {
			stat = new Status(Integer.parseInt(notif.getCategoryid()));
			vouch = new Voucher(stat.getVoucherid());
			user = new User(stat.getUserid());
		}
		else if(notif.getCategory().equals("rejected")) {
			stat = new Status(Integer.parseInt(notif.getCategoryid()));
			vouch = new Voucher(stat.getVoucherid());
			statuser = new User(stat.getUserid());
			user = new User(vouch.getUserid());
		}
		else {
			vouch = new Voucher(Integer.parseInt(notif.getCategoryid()));
			user = new User(vouch.getUserid());
		}
		String fullname = user.getFirstName() + " " + user.getlastName();
		if(notif.getCategory().equals("voucher")) {
			notif_msg = "Voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
						+ vouch.getTitle() + "</a> submitted by <a href = 'user_view.jsp?userid=" 
					    + user.getUserid() + "'>" + fullname + "</a> is awaiting your approval";
			notif_class = "info";
			img_url = "../img/info.png";
		}
		else if(notif.getCategory().equals("voucher status change")){
			String statmsg = stat.getStatus();
			
			if(stat.getStatus().equals("under consideration")){
				statmsg = "considered";
				notif_class = "warning";
				img_url = "../img/warning.png";
			}
			else if(stat.getStatus().equals("accepted")){
				notif_class = "success";
				img_url = "../img/success.gif";
			}
			else if(stat.getStatus().equals("sanctioned")){
				notif_class = "success";
				img_url = "../img/success.gif";
			}
			else if(stat.getStatus().equals("rejected")){
				notif_class = "error";
				img_url = "../img/error.png";
			}
						
			notif_msg = "Your voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
						+ vouch.getTitle() + "</a> has been " + statmsg + " by <a href = 'user_view.jsp?userid=" 
						+ user.getUserid() + "'>" + fullname + "</a>";
		}
		else if(notif.getCategory().equals("rejected")){	
			notif_msg = "Voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
						+ vouch.getTitle() + "</a> submitted by <a href = 'user_view.jsp?userid="
						+ user.getUserid() + "'>" + fullname + "</a> that you approved has been " 
						+ " rejected by <a href = 'user_view.jsp?userid=" + statuser.getUserid() + "'>"
						+ statuser.getFirstName() + " " + statuser.getlastName() + "</a>";
			notif_class = "error";
			img_url = "../img/error.png";
		}
		else if(notif.getCategory().equals("voucher edited")){
			notif_msg = "Voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
					+ vouch.getTitle() + "</a> submitted by <a href = 'user_view.jsp?userid="
					+ user.getUserid() + "'>" + fullname + "</a> that you approved has been " 
					+ "edited followed by a rejection";
			notif_class = "warning";
			img_url = "../img/warning.png";
		}
		else if(notif.getCategory().equals("voucher sanction")){
			notif_msg = "Voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
					 	+ vouch.getTitle() + "</a> submitted by <a href = 'user_view.jsp?userid="
						+ user.getUserid() + "'>" + fullname + "</a> has been sanctioned";
			notif_class = "success";
			img_url = "../img/success.gif";
		}
		else if(notif.getCategory().equals("sanction")){
			notif_msg = "Voucher <a href = 'voucher_view.jsp?id=" + vouch.getVoucherid() + "'>"
				 	+ vouch.getTitle() + "</a> submitted by <a href = 'user_view.jsp?userid="
					+ user.getUserid() + "'>" + fullname + "</a> is waiting to be sanctioned";
			notif_class = "success";
			img_url = "../img/success.gif";
		}
		String style = "width:4%";
		if(notif_class.equals("error")) style = "width:3%";
		else if(notif_class.equals("success")) style = "width:3.5%";
		
		String timeupdate = notif.getTimeupdate();
		timeupdate = timeupdate.substring(0,timeupdate.lastIndexOf(".")+2);
		
		SimpleDateFormat f0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		Date d = f0.parse(timeupdate);
		
		PrettyTime timeago = new PrettyTime();
		String smarttime = timeago.format(d);
		%> 
		<div class = "note-leaf alert alert-<%=notif_class%>">
			<small style = "float:right" title = "<%=timeupdate%>">
				<%= smarttime %>
			</small><br>
			<img src = "<%=img_url%>" style = "<%=style%>">
			<%= notif_msg %>
		</div> <%
	}
%>