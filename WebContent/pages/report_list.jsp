<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "report.Report,voucher.Voucher,org.apache.commons.lang3.ArrayUtils,user.Bookmark"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - My Reports</title>
<style>
	#sub-vouch-list > li {
		font-size: 18px!important;
	}
</style>
<script>
	$(document).ready(function(){
		$(".del-report").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id = "body-content">
	<legend>
		<h1>My Reports</h1>
	</legend>
	<table class = "table table-striped table-bordered">
	<%
		Report[] vlist = Report.list("USERID",session.getAttribute("sessionUsername").toString());
		
		if(vlist.length == 0) %> No reports found <%
		for(Report v: vlist){
			%>
			<tr>
				<td>
					<a href = "../server/report_view.jsp?id=<%=v.getReportid()%>"><%=v.getTitle() %></a>
				</td>
				<td>
					<button class = "btn btn-danger del-report" alt = "../server/delete.jsp?type=report&source=userlist&id=<%=v.getReportid()%>"><i class = "icon-white icon-remove"></i>Delete</button>
				</td>
			</tr> <%
		}
	%>
	</table>
</div>