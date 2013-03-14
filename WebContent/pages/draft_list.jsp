<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<style>
	.all-drafts > li > a {
		font-size:18px!important;
	}
	
	.btn-danger > a {
		color:white!important;
		text-decoration:none!important;
	}
	
	td {
		padding: 10px;
	}
</style>
<title>Vowcher - Draft List</title>
<div id = "body-content">
	<h2>All drafts</h2>
	<table class = "all-drafts table">
	<%
	i =0;
	for (i = 0; i < listOfFiles.length; i++) 
	{
		if (listOfFiles[i].isFile()) 
			{
				files = listOfFiles[i].getName();
				String[] parts = files.split("-");
				if(parts[0].equals(layout_username)){
					String shortened_filename = parts[1];
					if(parts[1].length() > 15){
						shortened_filename = parts[1].substring(0,15) + "...";
					}
					%> 
					<tr>
					   <td><a href = '../pages/voucher_add.jsp?mode=drafts&filename=<%=files%>'><%= shortened_filename %></a></td>
					   <td><button class = "btn btn-danger"><a href = '../server/delete_draft.jsp?source=list&filename=<%=files %>'>Delete</a></button></td>
					</tr> <%
				}
	   	}
	}
	if(i==0) { %> <h4>No drafts saved </h4><% }
	%>
	
	</table>
</div>
