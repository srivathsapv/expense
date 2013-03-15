<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "utility.Utility,voucher.Voucher,voucher.Type,java.util.Date,java.text.SimpleDateFormat"%>
<%@ include file = "../include/layout.jsp" %>
	
	<script type="text/javascript" src="../js/fancybox/source/jquery.fancybox.js?v=2.1.4"></script>
	<link rel="stylesheet" type="text/css" href="../js/fancybox/source/jquery.fancybox.css?v=2.1.4" media="screen" />

<script type = "text/javascript">
	$(document).ready(function(){
		$(".attach-img").click(function(){
			$.fancybox.open($("#large-image").html());
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
		<h2><%= title %></h2>
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
</div>