<%
	String word = request.getParameter("word");
	out.println(langConversion.Hindi.getHindiWord(word));
%>