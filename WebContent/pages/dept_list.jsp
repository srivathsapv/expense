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
	});
</script>
<div id = "body-content">
	<h1>Department List</h1>
	<div class="accordion" id="accordion2">
	  <%
	  	Department[] dept = Department.list("","");
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
	      </div>
	    </div>
	  </div>
	  <% } %>
	</div>