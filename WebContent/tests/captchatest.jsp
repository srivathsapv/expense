<%@page import = "nl.captcha.Captcha" %>
<%
	Captcha c = (Captcha)session.getAttribute(Captcha.NAME);
	request.setCharacterEncoding("UTF-8");
	String answer = request.getParameter("answer");
	if(c.isCorrect(answer)){ %>
		correct!!
	<%
	}
	else { %> wrong!!! <% }
%>