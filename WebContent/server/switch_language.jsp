<%
	session.setAttribute("lang",request.getParameter("lang"));
	response.sendRedirect(request.getParameter("redirect"));
	return;
%>