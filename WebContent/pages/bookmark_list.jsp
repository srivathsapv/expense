<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.Voucher,org.apache.commons.lang3.ArrayUtils,user.Bookmark"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Bookmark List</title>
<style>
	#sub-vouch-list > li {
		font-size: 18px!important;
	}
</style>
<script>
	$(document).ready(function(){
		$(".del-bookmark").click(function(){
			window.location = $(this).attr("alt");
		});
	});
</script>
<div id = "body-content">
	<legend>
		<h1>My Bookmarks</h1>
	</legend>
	<table class = "table table-striped table-bordered">
	<%
		Bookmark[] vlist = Bookmark.list("USERID",request.getParameter("userid"));
		
		if(vlist.length == 0) %> No bookmarks found <%
		for(Bookmark v: vlist){
			%>
			<tr>
				<td>
					<a href = "../pages/<%=v.getLink()%>"><%=v.getTitle() %></a>
				</td>
				<td>
					<button alt = "../server/delete.jsp?type=bookmark&source=userlist&link=<%=v.getLink()%>" class = "del-bookmark btn btn-danger"><i class = "icon-white icon-remove"></i>Delete</button>
				</td>
			</tr> <%
		}
	%>
	</table>
</div>