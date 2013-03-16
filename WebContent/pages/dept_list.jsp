<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,utility.Utility,user.Department,voucher.vouchertype.Policy"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Department List</title>
<script type = "text/javascript" src = "../js/bootstrap-collapse.js"></script>
<script>
	$(document).ready(function(){
		$(".view-users").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".edit-dept").click(function(){
			window.location = $(this).attr("alt");
		});
		
		$(".delete-dept").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<style>
	legend {
		font-size:14px!important;
	}
</style>
<div id = "body-content">
	<h1>Department List</h1>
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<%= request.getParameter("message") %>
				</div> <%
			}
		}
	%>
	<div class="accordion" id="accordion2">
	  <%
	  	Department[] dept = Department.list("","");
	  	if(dept.length == 0) {
	  		%> No departments added <%
	  	}
	  	for(Department d:dept) {
	  		User user = new User(d.getUserid());
	  		
	  %>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse<%=d.getDeptid()%>">
	        <%= d.getDeptname() %> ( <%= d.getShortname() %> )
	      </a>
	    </div>
	    <div id="collapse<%=d.getDeptid() %>" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<h4>CEO - <a href = "user_view.jsp?userid=<%=user.getUserid() %>"><%= user.getFirstName() + " " + user.getlastName() %></a></h4>
	       	</legend>
	       	<legend>
	       		<i class = "icon-question-sign"></i><%= d.getDescription() %>
	       	</legend>
	       	<h4>Voucher types allowed</h4>
	       	<ul>
		       	<%
		       		voucher.vouchertype.Department[] vtypedepts = voucher.vouchertype.Department.list("DEPTID",Integer.toString(d.getDeptid()));
		       		for(voucher.vouchertype.Department vtypedept: vtypedepts){
		       			voucher.Type vtype = new voucher.Type(vtypedept.getVtypeid());
		       			%> <li><a href = "vouchertype_list.jsp?vtype=<%=vtype.getVtypeid() %>"><%= vtype.getTitle() %></a></li><%	
		       		}
		       	%>
	       	</ul>
	       	<button class = "btn btn-info view-users" alt = "user_list.jsp?deptid=<%=d.getDeptid() %>"><i class = "icon-white icon-th-list"></i>View Users</button>
	       	<button class = "btn btn-warning edit-dept" alt = "dept_add.jsp?mode=edit&deptid=<%=d.getDeptid() %>"><i class = "icon-white icon-pencil"></i>Edit</button>
	       	<button class = "btn btn-danger delete-dept" alt = "../server/delete.jsp?type=dept&source=list&deptid=<%=d.getDeptid() %>"><i class = "icon-white icon-remove"></i>Delete</button>
	      </div>
	    </div>
	  </div>
	  <% } %>
	</div>