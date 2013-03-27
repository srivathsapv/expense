<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.Status,utility.Utility,user.User,user.Department,java.sql.*,java.io.*,com.ocpsoft.pretty.time.*" %>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Profile</title> 
<div id = "body-content">
	<%
		String userid = request.getParameter("userid");
		User user = new User(userid);
		
		Department dept = new Department(user.getDeptid());
		String deptname = dept.getDeptname();
		
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<%= request.getParameter("message") %>
				</div> <%
			}
		}
	%>
<script src="../js/custom.js"></script>
<script>
	$(document).ready(function(){
		$(".del-user").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".edit-user").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
	<legend>
		<h2 class = "profile-name">
			<%= user.getFirstName() + " " + user.getlastName() %>
			<button class = "btn btn-warning edit-user" alt = "user_add.jsp?mode=edit&userid=<%=userid %>"><i class = "icon-white icon-pencil"></i>Edit</button>
			<button class = "btn btn-danger del-user" alt = "user_add.jsp?mode=edit&userid=<%=userid %>"><i class = "icon-white icon-remove"></i>Delete</button>
		</h2>
		<span class = 'designation'><%= user.getDesignation() %> - <%= deptname %> Department</span><br>
		
	</legend>
	
	<% if(user.getPhoto() != null) {
		if(!user.getPhoto().equals("")) {
		%>
		<img src = "../server/display_image.jsp?userid=<%= userid %>&mode=profile_picture" class = "profile-image img-rounded img-polaroid" width = 15%>
	<% } 
		} if(user.getPhoto() == null || user.getPhoto().equals("")) { %>
		<img src = "../img/profile_default.png" class = "profile-image img-rounded img-polaroid" width = 15%>
	<% } %>
	<span class = 'profile-info address'>
		<i class = 'icon-home'></i>
		<%= user.getAddress() %>
	</span><br>
	<span class = 'profile-info phone'>
		<i class = 'icon-user'></i>
		+<%= user.getPhone() %>
	</span><br>
	<span class = 'profile-info mobile'>
		<i class = 'icon-star'></i>
		+<%= user.getMobile() %>
	</span><br>
	<span class = 'profile-info email'>
		<i class = 'icon-envelope'></i>
		<a href = 'mailto:<%= user.getEmail() %>'> <%= user.getEmail() %></a>
	</span>
	<br><br><br><br><br>
	<legend>
		<h4><i class = "icon-list"></i>Recent Activity</h4>
	</legend>
	<ul style = "font-size:16px">
	<%
		vouchers = Voucher.list("USERID",userid,0);
		for(Voucher v:vouchers){
			java.text.SimpleDateFormat f = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date d = f.parse(v.getDate());
			PrettyTime timeago = new PrettyTime();
			String smarttime = timeago.format(d);
			%> 
			<li style = "margin-bottom:7px">
				<small style = "float:right">
					<%=smarttime %>
				</small>
				Added voucher <a href = 'voucher_view.jsp?id=<%=v.getVoucherid() %>'><%=v.getTitle() %></a>
			</li>
	<%
		}
		
		Status[] statlist = Status.list("USERID",userid);
		for(Status s:statlist){
			Voucher statvoucher = new Voucher(s.getVoucherid());
			User statuser = new User(statvoucher.getUserid());
			String startstr = "";
			if(s.getStatus().equals("sanctioned")) {
				startstr = "Sanctioned";
			}
			else if(s.getStatus().equals("accepted")){
				startstr = "Accepted";
			}
			else if(s.getStatus().equals("rejected")){
				startstr = "Rejected";
			}
			else if(s.getStatus().equals("under consideration")){
				startstr = "Considered";
			}
			else if(s.getStatus().equals("edited")){
				startstr = "Edited";
			}
			java.text.SimpleDateFormat f = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			java.util.Date d = f.parse(s.getTime().substring(0,s.getTime().lastIndexOf(".")+2));
			PrettyTime timeago = new PrettyTime();
			String smarttime = timeago.format(d);
	 %>
			<li style = "margin-bottom:7px">
				<small style = "float:right">
					<%=smarttime %>
				</small>
				<%= startstr %> voucher - <a href = "voucher_view.jsp?id=<%=statvoucher.getVoucherid() %>"><%=statvoucher.getTitle() %></a>
					<%
						if(!startstr.equals("Edited")) {
					%>
					submitted by <a href = "user_view.jsp?userid=<%=statuser.getUserid() %>"><%= statuser.getFirstName() + " " + statuser.getlastName() %></a>
					<% } %>
			</li>		
	 <%
		}
		
		
	%>
	</ul>
	<br>
	<legend>
		<h4><i class = "icon-road"></i>User Hierarchy</h4>
	</legend>
	<center>
	<%
		User hUser = new User(userid);
		Vector<User> hierarchy = new Vector<User>();
		while(true){
			hierarchy.add(hUser);
			Authentication auth = new Authentication(hUser.getUserid());
			if(auth.getRole().equals("md")){
				break;
			}
			hUser = new User(hUser.getManager());
		}
		
		for(i=hierarchy.size()-1;i>=0;i--){
			User u = hierarchy.get(i);
			String alertclass = "success";
			if(u.getUserid().equals(userid)){
				alertclass = "info";
			}
			%> 
			<a class = "alert alert-<%=alertclass %>" href = "user_view.jsp?userid=<%=u.getUserid()%>"><%=u.getFirstName() + " " + u.getlastName() %> ( <%=u.getDesignation() %> )</a><br><br>
			<%
				if(alertclass.equals("info")) {
					break;
				}
				else {
			%>
			<img src = "../img/up.png" style = "width:5%"><br><br>
		<%
				}
		}
		
		User[] subordinates = User.list("MANAGER",userid);
		if(subordinates.length > 0) {
			%>
			<img src = "../img/up.png" style = "width:5%"><br><br>	<%
					for(User u:subordinates){
						%> <a class = "alert alert-success" href = "user_view.jsp?userid=<%=u.getUserid() %>"><%= u.getFirstName() + " " + u.getlastName() %> (<%=u.getDesignation() %>)</a><br><br> <%
					}
				%>
			
			<%
		}
	%>
	</center>
</div>
