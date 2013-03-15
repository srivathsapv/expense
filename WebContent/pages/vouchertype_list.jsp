<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.*,voucher.vouchertype.*"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Voucher Types</title>
<script type="text/javascript" src="../js/fancybox/source/jquery.fancybox.js?v=2.1.4"></script>
<link rel = "stylesheet" href = "../less/popovers.css">
<script type = "text/javascript" src = "../js/bootstrap-popover.js"></script>
<link rel="stylesheet" type="text/css" href="../js/fancybox/source/jquery.fancybox.css?v=2.1.4" media="screen" />
	
<script>
	$(document).ready(function(){
		$("#new-vtype").click(function(){
			window.location = "vouchertype_add.jsp";
		});
		
		$(".type-view").click(function(){
			var vtypeid = $(this).attr("id").substring(1,$(this).attr("id").length);
			
			$.ajax({
				type: "POST",
				dataType : "json",
				url : "../server/vtype_info.jsp",
				data : "vtypeid="+vtypeid,
				success:function(msg){
					$("#vtype-title").html(msg.title);
					$("#vtype-desc").html(msg.description);
					$("#vtype-policies").html(msg.policies);
					$("#vtype-departments").html(msg.departments);
					
					$.fancybox.open($("#vtype-info").html());
				}
			});
		});
		
		$(".del-vtype").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<style>
	.btn-danger > a {
		color:white;
		text-decoration:none;
	}
	
	.desc-ico {
		margin-left:3px;
		margin-top:3px;
	}
	
	.vtinfo {
		font-size:14px!important;
	}
</style>
<div id = "body-content">
	<%
		int vtype=0;
		if(request.getParameter("vtype") != null) {
			vtype = Integer.parseInt(request.getParameter("vtype"));
		}
		
	%>
	<legend>
		<h3>Voucher Types</h3>
	</legend>
	<table class = "table table-striped table-bordered">
		<thead>
			<tr>
				<th>
					<h4>Voucher Type Name</h4>
				</th>
				<th>
					<h4>Description</h4>
				</th>
				<th>
					<h4>View</h4>
				</th>
				<th>
					<h4>Delete</h4>
				</th>
			</tr>
		</thead>
		<tbody>
			<%
				Type[] types = Type.list("","");
				for(Type t:types){
					String desc = t.getDescription();
					if(desc.length() > 45){
						desc = desc.substring(0,45) + "...";
					}
					String tclass = "";
					if(t.getVtypeid() == vtype){
						tclass = "info";
					}
					%> 
					<tr class = "<%=tclass%>">
						<td><%= t.getTitle() %></td>
						<td><%= desc%> </td>
						<td>
							<button class = "btn btn-info type-view" id = "t<%=t.getVtypeid()%>">
								<i class = "icon-search icon-white"></i>
							</button>
						</td>
						<td>
							<button class = "btn btn-danger del-vtype" alt = "../server/delete.jsp?type=vtype&source=list&vtypeid=<%=t.getVtypeid() %>">
								x
							</button>
						</td>
					</tr> <%
				}
			%>
		</tbody>
	</table>
	<button class = "btn btn-success" id = "new-vtype"><i class = "icon-plus-sign icon-white"></i>Add New</button>
	<div style = "display:none">
		<div id = "vtype-info">
			<legend>
				<h3 id = "vtype-title"></h3>
			</legend>
			<legend>
				<div class = "well well-large" id = "vtype-desc">
				</div>
			</legend>
			<legend>
				<h4>Policies under which this voucher type can be submitted</h4>
				<div id = "vtype-policies">
				</div>
			</legend>
			<legend>
				<h4>Departments that can use this voucher type</h4>
				<div id = "vtype-departments">
				</div>
			</legend>
		</div>
	</div>
</div>
