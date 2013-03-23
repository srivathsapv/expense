<%@page import = "org.json.*" %>
<%
	JSONObject obj = new JSONObject();
	obj.put("name","srivathsa");
	obj.put("dept","cse");
	System.out.println(obj);
%>