<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "java.sql.ResultSet,db.Db,utility.Utility,voucher.Voucher,voucher.Type,java.util.Date,java.text.SimpleDateFormat,voucher.Status,voucher.vouchertype.Policy"%>
<%@ include file = "../include/layout.jsp" %>	
<script type="text/javascript" src="../js/fancybox/source/jquery.fancybox.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="../js/fancybox/source/jquery.fancybox.css?v=2.1.4" media="screen" />
<script type = "text/javascript">
	$(document).ready(function(){
		$(".attach-img").click(function(){
			$.fancybox.open($("#large-image").html());
		});
		
		$("#edit-voucher").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$("#delete-voucher").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$("#reject").click(function(){
			$("#rejectdiv").attr("style","display:block");
		});
		
		$(".option-button").click(function(){
			if($(this).attr("id") == "continue") {
				if($("#rejectreason").val() == "") {
					alert("State a reason for your rejection");
				}
				else {
					window.location = $(this).attr("alt") + "&reason=" + $("#rejectreason").val();	
				}
			}
			else {
				window.location = $(this).attr("alt");
			}
		});
		
		$(".edit-status").click(function(){
			$("#option-buttons").attr("style","display:block");
			$("#accept").attr("alt",$("#accept").attr("alt")+"&mode=edit");
			$("#consider").attr("alt",$("#consider").attr("alt")+"&mode=edit");
			$("#continue").attr("alt",$("#continue").attr("alt")+"&mode=edit");
		});
		
		$(".mgr-accept").click(function(){
			$("#policydiv").attr("style","display:block");
		});
		
		$("#policy-continue").click(function(){
			window.location = $(this).attr("alt") + "&policyid=" + $("#accept-policy").val();
		});
	});
</script>
<style>
	#date {
		font-size: 14px;
	}
	
	.voucher-view {
		margin-top: 5px!important;
	}
	
	#description {
		background: #EEF4F9;
		padding:10px;
		border-radius:8px;
		margin-bottom : 20px;
		margin-top:15px;
		border: solid 1px #CDDDED;
	}
	
	.attach-img {
		margin-bottom:20px;
		margin-top:15px;
	}
	
	.attach-doc {
		margin-top:15px;
		margin-bottom:20px;
	}
	
</style>
<%
	int vid = Integer.parseInt(request.getParameter("id"));
	if(vid == 0){
		response.sendRedirect("dashboard.jsp");
		return;
	}
	Voucher voucher = new Voucher(vid);
	String title = voucher.getTitle();
	String amount = Double.toString(voucher.getAmount());
	
	Type type = new Type(voucher.getVtypeid());
	String date = voucher.getDate();
	
	SimpleDateFormat f1 = new SimpleDateFormat("yyyy-mm-dd");
	Date d = f1.parse(date);
	SimpleDateFormat f2 = new SimpleDateFormat("dd MMM yyyy");
	String dt = f2.format(d);
	String description = voucher.getDescription();
%>


<title>Vowcher View - <%=title %></title>
<div id = "body-content">
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button><%=request.getParameter("message") %></div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("error"))) {
				%> <div class = "alert alert-error"><button class="close" data-dismiss="alert" type="button">×</button><%=request.getParameter("message") %></div> <%	
			}	
		}
	%>
	<legend>
		<h2>
			<%= title %>
			<%
				Status status[] = Status.list("VOUCHERID",Integer.toString(vid));
				String vstatus = "";
				if(status.length != 0){
					vstatus = status[0].getStatus();
					if((vstatus.equals("pending") || vstatus.equals("rejected")) && voucher.getUserid().equals(session.getAttribute("sessionUsername").toString())) {
						%> <button class = "btn btn-warning" id = "edit-voucher" alt = "voucher_add.jsp?mode=edit&vid=<%=vid%>"><i class = "icon-white icon-pencil"></i>Edit</button> <%		
					}	
				}
			%>
			<%
				if((vstatus.equals("pending") || vstatus.equals("rejected")) && session.getAttribute("sessionUsername").equals(voucher.getUserid())) {
					%> <button class = "btn btn-danger" id = "delete-voucher" alt = "../server/delete.jsp?type=voucher&vid=<%=vid %>&source=view"><i class = "icon-white icon-remove"></i>Delete</button> <%	
				}
			%>
		</h2>
		<%
			if(!session.getAttribute("sessionUsername").toString().equals(voucher.getUserid())){
				User vouch_user = new User(voucher.getUserid());
				
				String vouch_username = vouch_user.getFirstName() + " " + vouch_user.getlastName();
				%> <h4><b>Submitted by <a href = "user_view.jsp?userid=<%=vouch_user.getUserid() %>"><%= vouch_username %></a></b></h4> <%
			}
		%>
		<h4><b>Voucher Amount - </b><span><img class = "currency-change-img" src = "../img/rupees.png"><span class = "currency-change-amount"><%=amount %></span></h4>
		<h4><b>Category</b> - <a href = "vouchertype_list.jsp?vtype=<%= voucher.getVtypeid() %>"><%= type.getTitle() %></a></h4>
		<i class = "voucher-view icon-calendar"></i><span id = "date">Last update on <%= dt %></span>	
	</legend>
	<legend> 
		<h4><i class = "voucher-view icon-th-list"></i>Description</h4><div class = "well well-large"><%= description %></div>
	</legend>
	<legend>
		<h4><i class = "voucher-view icon-envelope"></i>Attachment</h4>
		<%
			String ext = "";
			if(voucher.getExtension() != null)
				ext = voucher.getExtension().toLowerCase();
			if(ext.equals("")){
				%> No attachments added <%
			}
			if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png")){
				%>
				<img class = "poi attach-img img-rounded img-polaroid" src = "../server/display_image.jsp?mode=attachment_image&vid=<%=vid %>&ext=<%=ext %>" width = 20%> 
				<div style="display:none">
					<div id = "large-image">
						<img src = "../server/display_image.jsp?mode=attachment_image&vid=<%=vid %>&ext=<%=ext %>">
					</div>
				</div>
				<%
			}
			else {
				if(ext.equals("pdf")){
					%> <a target = "_blank" href = "../server/view_attachment.jsp?vid=<%=vid %>"><img src = "../img/pdf.png" class = "attach-doc" width = 12%></a> <%
				}
				else if(ext.equals("doc") || ext.equals("docx")){
					%> <a target = "_blank" href = "../server/view_attachment.jsp?vid=<%=vid %>"><img src = "../img/word.png" class = "attach-doc" width = 12%></a> <%
				}
			}
		%>
	</legend>
	<%
	boolean edit_status = false;	
	if(!vstatus.equals("")) { %>
	<legend>
		<h4><i class = "icon-flag"></i>Status</h4>
		<%
			
			String disp_class = "";
			String disp_msg = "";
			String disp_time = "";
			i = 1;
			
			for(Status stat: status) {
				vstatus = stat.getStatus();
				if(vstatus.equals("pending") || vstatus.equals("under consideration") || vstatus.equals("passed on")){
					disp_class = "warning";
					
					if(vstatus.equals("pending")){
						disp_msg = "Pending";
					}
					else if(vstatus.equals("under consideration")){
						disp_msg = "Under Consideration";
					}
					else if(vstatus.equals("passed on")){
						User passed_on_user = new User(stat.getUserid());
						disp_msg = "Passed on to <a href = 'user_view.jsp?userid=" +stat.getUserid() + "'>" + passed_on_user.getFirstName() + " " + passed_on_user.getlastName() + "</a>";
					}
				}
				else if(vstatus.equals("edited")){
					disp_class = "warning";
					disp_msg = "Edited followed by a rejection.";
				}
				else if(vstatus.equals("rejected")){
					disp_class = "danger";
					disp_msg = "Rejected for the following reason :\n";
					disp_msg += voucher.getRejectReason();
				}
				else if(vstatus.equals("accepted")){
					
					disp_class = "info";
					Db db = new Db();
					db.connect();
					ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM VOUCHER_STATUS WHERE STATUS = 'accepted' AND VOUCHERID = " + vid);
					rs.next();
					
					ResultSet rs1 = db.executeQuery("SELECT MAXCOUNT FROM AMOUNT_CONFIG WHERE LOWER_LIMIT <= " + amount + " AND UPPER_LIMIT >= " + amount);
					rs1.next();
					
					policy.Policy pol = new policy.Policy(voucher.getPolicyid());
					String policystr = "";
					
					User vouchuser = new User(voucher.getUserid());
					if(stat.getUserid().equals(vouchuser.getManager()))
						policystr = " by policy - <a href = 'policy_list.jsp?pid=" + pol.getPolicyid() + "#p" + pol.getPolicyid() + "'>" + pol.getTitle() + "</a>";	
					Authentication stat_user = new Authentication(stat.getUserid());
					if((rs.getInt(1) == rs1.getInt(1) || stat_user.getRole().equals("md")) && i == 1) {
						disp_msg = "Accepted" + policystr + ". Request forwarded to accounts department";	
					}
					else {
						disp_msg = "Accepted" + policystr + ". Waiting for approval from higher authorities";
					}
					db.disconnect();
				}
				else if(vstatus.equals("sanctioned")){
					
					disp_class = "success";
					
					policy.Policy accept_policy = new policy.Policy(voucher.getPolicyid());
					
					double pcent = accept_policy.getAmountPercent();
					double ramnt = voucher.getAmount();
					double sanctioned = ramnt * (pcent/100);
					disp_msg  = "Sanctioned <img src = '../img/rupee.png' class = 'currency-change-img'><span class = 'currency-change-amount'>" + sanctioned + "</span>";
				}
				
				String time = stat.getTime();
				String updateTime = "";
				f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date udate = f1.parse(time);
				
				f2 = new SimpleDateFormat("dd MMM yyyy - hh:mm a");
				updateTime = f2.format(udate);
				updateTime = updateTime.replace("-","at");
				
				User statusUser = new User(stat.getUserid());
				String by_username = statusUser.getFirstName() + " " + statusUser.getlastName();
				
				if(i == 2) %> Status History<br><br><%
			%>
			<div class = "alert alert-<%=disp_class %>"
			<%
				if(i==1)
					%> id = "current-status" alt = "<%=vstatus %>" <%
			%>>
				<%=disp_msg %><br>
				<span class = "font-italic"><small>Last update on <%= updateTime%> by <a href = "user_view.jsp?userid=<%=stat.getUserid()%>"><%= by_username%></a></small></span>
			</div>
			<%
				
				if(i==1){
					if(!session.getAttribute("sessionUsername").equals(voucher.getUserid()) && !session.getAttribute("sessionUserRole").toString().equals("finance") && stat.getUserid().equals(session.getAttribute("sessionUsername").toString()) && !stat.getStatus().equals("pending") && !stat.getStatus().equals("rejected")){
						edit_status = true;
						%> <button class = "btn btn-warning edit-status"><i class = "icon-white icon-edit"></i>Edit</button> <%
					}
				}
			%>
		</legend>
		<%		i++; 
			} 	
		}
	
		String dispstyle = "display:none";
		
		Db db = new Db();
		db.connect();
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM NOTIFICATION WHERE USERID = '" + session.getAttribute("sessionUsername").toString() + "' AND CATEGORY = 'voucher' AND CATEGORYID = '" + Integer.toString(vid) + "'");
		rs.next();
		
		String query = "";
		User vouch_user = new User(voucher.getUserid());
		if(session.getAttribute("sessionUsername").toString().equals(vouch_user.getManager())){
			query = "SELECT COUNT(*) FROM VOUCHER_STATUS WHERE USERID = '" + session.getAttribute("sessionUsername").toString() + "' AND VOUCHERID = '" + Integer.toString(vid) + "' AND STATUS NOT IN('pending')";
		}
		else {
			query = "SELECT COUNT(*) FROM VOUCHER_STATUS WHERE USERID = '" + session.getAttribute("sessionUsername").toString() + "' AND VOUCHERID = '" + Integer.toString(vid) + "' AND STATUS NOT IN('pending','rejected')";
		}
		ResultSet rs2 = db.executeQuery(query);
		rs2.next();
		
		ResultSet rs3 = db.executeQuery("SELECT COUNT(*) FROM NOTIFICATION WHERE USERID = '" + session.getAttribute("sessionUsername").toString() + "' AND CATEGORY = 'voucher edited' AND CATEGORYID = '" + Integer.toString(vid) + "'");
		rs3.next();
		
		
		if(rs3.getInt(1) > 0 || (rs.getInt(1) > 0 && rs2.getInt(1) == 0)) {
			if(!edit_status)
				dispstyle = "display:block";
		}
		db.disconnect();
		%>
		
		<legend id = "option-buttons" style = "<%=dispstyle%>">
			<h4><i class = "icon-wrench"></i>Options</h4>
			<%
				User vouchuser = new User(voucher.getUserid());
				if(session.getAttribute("sessionUsername").toString().equals(vouchuser.getManager())){
					%><button class = "btn btn-success mgr-accept" id = "accept"><i class = "icon-white icon-ok"></i>Accept</button> <% 
				}
				else {
					%><button class = "btn btn-success option-button" id = "accept" alt = "../server/voucher_status.jsp?vid=<%=vid %>&status=accept"><i class = "icon-white icon-ok"></i>Accept</button> <%
				}
			%>
			<button class = "btn btn-warning option-button" alt = "../server/voucher_status.jsp?vid=<%=vid %>&status=consider" id = "consider"><i class = "icon-white icon-exclamation-sign"></i>Consider</button>
			<button class = "btn btn-danger" id = "reject"><i class = "icon-white icon-minus"></i>Reject</button><br><br>
			<div id = "policydiv" style = "display:none">
				<select class = "span4" id = "accept-policy">
					<%
						Policy[] vtypepolicies = Policy.list("VTYPEID",Integer.toString(voucher.getVtypeid()));
						for(Policy p:vtypepolicies){
							policy.Policy pol = new policy.Policy(p.getPolicyid());
							if(pol.getAvailable() == 1)
								%> <option value = "<%=pol.getPolicyid() %>"><%=pol.getTitle() %></option> <%
						}
					%>
				</select><br>
				<button class = "btn btn-info" id = "policy-continue" alt = "../server/voucher_status.jsp?vid=<%=vid %>&status=accept"><i class = "icon-white icon-arrow-right"></i>Continue</button>
			</div>
			<div id = "rejectdiv" style = "display:none">
				<button class="close" data-dismiss="alert" type="button">×</button>
				<input class = "span4" type="text" id = "rejectreason" placeholder="Enter a reason for rejection"><br>
				<button class = "btn btn-info option-button" id = "continue" alt = "../server/voucher_status.jsp?vid=<%=vid %>&status=reject" ><i class = "icon-white icon-arrow-right"></i>Continue</button><br>
			</div>
		</legend>
		<%
			db.connect();
			rs = db.executeQuery("SELECT COUNT(*) FROM VOUCHER_STATUS WHERE VOUCHERID = " + Integer.toString(vid) + " AND STATUS = 'accepted'");
			rs.next();
			
			rs2 = db.executeQuery("SELECT MAXCOUNT FROM AMOUNT_CONFIG WHERE LOWER_LIMIT <= " + amount + " AND UPPER_LIMIT >= " + amount);
			rs2.next();
			
			Status[] vstatuses = Status.list("VOUCHERID",Integer.toString(vid));
			boolean ismd = false;
			if(vstatuses.length > 0){
				Status vstat = vstatuses[0];
				Authentication vstat_user = new Authentication(vstat.getUserid());
				if(vstat_user.getRole().equals("md")){
					ismd = true;
				}
			}
			
			if(rs.getInt(1) == rs2.getInt(1) || ismd) {
				query = "SELECT COUNT(*) FROM VOUCHER_STATUS WHERE VOUCHERID = " + Integer.toString(vid) + " AND STATUS = 'sanctioned'";
				
				rs3 = db.executeQuery(query);
				rs3.next();
				
				if(session.getAttribute("sessionUserRole").equals("finance") && rs3.getInt(1) == 0){
					%> <button id = "sanction" class = "btn btn-success option-button" alt = "../server/voucher_status.jsp?status=sanction&vid=<%=vid%>"><i class = "icon-white icon-ok"></i>Sanction</button> <%
				}
			}
			db.disconnect();
		%>
</div>