<%@ page import="langConversion.Hindi"%>
<% Hindi h = new Hindi();
	String f = h.getConvertedText("Hindi");
	System.out.println(f);
	out.println(f);
%>