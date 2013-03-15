<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.Voucher"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - List</title>
<script>
	$(document).ready(function(){
		$(".del-voucher").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id = "body-content">
	<h1>Voucher List</h1>
	<table class = "table">
	<%
		Voucher[] vlist;
		if(request.getParameter("userid") != null){
			String userid = request.getParameter("userid");
			vlist = Voucher.list("USERID",userid,0);
		}
		else {
			vlist = Voucher.list("","",0);
		}
		for(Voucher v: vlist){
			%><tr><td><a href = "voucher_view.jsp?id=<%=v.getVoucherid()%>"><%=v.getTitle() %></a></td><td><button alt = "../server/delete.jsp?type=voucher&source=userlist&vid=<%=v.getVoucherid() %>" class = "del-voucher btn btn-danger">Delete</button></td></tr> <%
		}
	%>
	</table>
</div>

