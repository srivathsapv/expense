<%@ page import="langConversion.Hindi"%>
<% Hindi h = new Hindi();
	String f = h.getConvertedText("Welcome");
	System.out.println(f);
	out.println(f);
	%>