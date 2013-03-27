<%
	if(session.getAttribute("lang").toString().equals("hin"))
		session.setAttribute("lang","eng");
	else
		session.setAttribute("lang","hin");
	out.println(session.getAttribute("lang"));
%>

