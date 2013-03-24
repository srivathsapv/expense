<%@page import = "user.Bookmark" %>
<%
	String title = request.getParameter("title");
	String link = request.getParameter("link");
	
	Bookmark bm = new Bookmark();
	bm.setTitle(title);
	bm.setLink(link);
	bm.setUserid(session.getAttribute("sessionUsername").toString());
	bm.save();
%>
OK