<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.io.File"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	File file = new File(config.getServletContext().getRealPath("/")+"drafts/"+request.getParameter("filename"));
	file.delete();
	if(request.getParameter("source") != null){
		if(request.getParameter("source").equals("list")){
			response.sendRedirect("../pages/draft_list.jsp");
			return;
		}
	}
	else {
		response.sendRedirect("../pages/dashboard.jsp");
		return;
	}
%>