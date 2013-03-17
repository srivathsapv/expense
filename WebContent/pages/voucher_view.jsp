<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "utility.Utility,voucher.Voucher,voucher.Type,java.util.Date,java.text.SimpleDateFormat,voucher.Status"%>
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
				%> <div class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button>Voucher added successfully</div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("error"))) {
				%> <div class = "alert alert-error">Error while adding voucher</div> <%	
			}	
		}
	%>
	<legend>
		<h2>
			<%= title %>
			<%
				Status status[] = Status.list("VOUCHERID",Integer.toString(vid));
				Status stat = null;
				String vstatus = "";
				if(status.length != 0){
					stat = status[0];
					vstatus = stat.getStatus();
					if(vstatus.equals("pending")) {
						%> <button class = "btn btn-warning" id = "edit-voucher" alt = "voucher_add.jsp?mode=edit&vid=<%=vid%>"><i class = "icon-white icon-pencil"></i>Edit</button> <%		
					}	
				}
			%>
			<%
				if(session.getAttribute("sessionUsername").equals(voucher.getUserid())) {
					%> <button class = "btn btn-danger" id = "delete-voucher" alt = "../server/delete.jsp?type=voucher&vid=<%=vid %>&source=view"><i class = "icon-white icon-remove"></i>Delete</button> <%	
				}
			%>
		</h2>
		<h4><b>Voucher Amount - </b><span class="add-on rupee" style = "font-size:20px">`</span> <%=amount %></h4>
		<h4><b>Category</b> - <a href = "vouchertype_list.jsp?vtype=<%= voucher.getVtypeid() %>"><%= type.getTitle() %></a></h4>
		<i class = "voucher-view icon-calendar"></i><span id = "date">Last update on <%= dt %></span>	
	</legend>
	<legend> 
		<h4><i class = "voucher-view icon-th-list"></i>Description</h4><div class = "well well-large"><%= description %></div>
	</legend>
	<legend>
		<h4><i class = "voucher-view icon-envelope"></i>Attachment</h4>
		<%
			String ext = voucher.getExtension().toLowerCase();
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
	<% if(!vstatus.equals("")) { %>
	<legend>
		
		<h4><i class = "icon-flag"></i>Status</h4>
		<%
			String disp_class = "";
			String disp_msg = "";
			String disp_time = "";
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
			else if(vstatus.equals("rejected")){
				disp_class = "danger";
				disp_msg = "Rejected for the following reason :\n";
				disp_msg += voucher.getRejectReason();
			}
			else if(vstatus.equals("accepted")){
				disp_class = "info";
				disp_msg = "Accepted. Request forwarded to accounts department";
			}
			else if(vstatus.equals("sanctioned")){
				disp_class = "success";
				policy.Policy accept_policy = new policy.Policy(voucher.getPolicyid());
				double pcent = accept_policy.getAmountPercent();
				double ramnt = voucher.getAmount();
				double sanctioned = ramnt * (pcent/100);
				disp_msg  = "Sanctioned <span class = 'add-on rupee'>`</span>" + sanctioned;
			}
			String time = stat.getTime();
			String updateTime = "";
			f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date udate = f1.parse(time);
			
			f2 = new SimpleDateFormat("dd MMM yyyy - hh:mm a");
			updateTime = f2.format(udate);
			updateTime = updateTime.replace("-","at");
			
		%>
		<div class = "alert alert-<%=disp_class %>">
			<%=disp_msg %><br>
			<span class = "font-italic"><small>Last update on <%= updateTime%></small></span>
		</div>
	</legend>
	<% } %>
	<%
		if(!session.getAttribute("sessionUsername").equals(voucher.getUserid())){
			User sUser = new User(voucher.getUserid());
			if(sUser.getManager().equals(session.getAttribute("sessionUsername"))){
				Authentication mgr = new Authentication(session.getAttribute("sessionUsername").toString());
				%>
				<legend>
					<h4><i class = "icon-wrench"></i>Options</h4>
					<button class = "btn btn-success" id = "accept"><i class = "icon-white icon-ok"></i>Accept</button>
					<%
						if(!mgr.getRole().equals("md")) {
							%> <button class = "btn btn-warning" id = "passon"><i class = "icon-white icon-chevron-right"></i>Pass On</button> <%
						}
					%>
					<button class = "btn btn-info" id = "consider"><i class = "icon-white icon-exclamation-sign"></i>Consider</button>
					<button class = "btn btn-danger" id = "reject"><i class = "icon-white icon-minus"></i>Reject</button><br><br>
					<div id = "rejectdiv" style = "display:none">
						<button class="close" data-dismiss="alert" type="button">×</button>
						<input class = "span4" type="text" id = "rejectreason" placeholder="Enter a reason for rejection"><br>
						<button class = "btn btn-info" id = "continue"><i class = "icon-white icon-arrow-right"></i>Continue</button><br>
					</div>
				</legend>
				
				<%
			}
		}
	%>
</div>