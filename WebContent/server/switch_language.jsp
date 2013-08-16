<%
	if(session.getAttribute("lang").toString().equals("hin"))
		session.setAttribute("lang","eng");
	else
		session.setAttribute("lang","hin");
	
	response.sendRedirect(session.getAttribute("redirectAfterLangChange").toString());
%>

