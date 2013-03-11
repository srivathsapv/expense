<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "org.w3c.dom.*,
    							   java.io.File,
    							   javax.xml.parsers.*,
    							   javax.xml.transform.*,
    							   javax.xml.transform.dom.*,
    							   javax.xml.transform.stream.*,
    							   java.sql.Timestamp,user.User,utility.Utility"%>
<%@ include file = "server_authenticate.jsp" %>
<%
	if(session.getAttribute("sessionUser") == null) return;
	
	String title = request.getParameter("title");
	String amount = request.getParameter("amount");
	String type = request.getParameter("type");
	String date = request.getParameter("date");
	String description = request.getParameter("description");
	
	User user = (User)session.getAttribute("sessionUser");
	String username = user.getUserid();
	
	String hashkey = Utility.MD5(title+amount+type+date+description+user);
	
	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	
	Document doc = docBuilder.newDocument();
	Element rootElement = doc.createElement("voucher");
	doc.appendChild(rootElement);
	
	Element titleElement = doc.createElement("title");
	titleElement.appendChild(doc.createTextNode(title));
	rootElement.appendChild(titleElement);
	
	Element amountElement = doc.createElement("amount");
	amountElement.appendChild(doc.createTextNode(amount));
	rootElement.appendChild(amountElement);
	
	Element typeElement = doc.createElement("type");
	typeElement.appendChild(doc.createTextNode(type));
	rootElement.appendChild(typeElement);
	
	Element dateElement = doc.createElement("date");
	dateElement.appendChild(doc.createTextNode(date));
	rootElement.appendChild(dateElement);
	
	Element descriptionElement = doc.createElement("description");
	descriptionElement.appendChild(doc.createTextNode(description));
	rootElement.appendChild(descriptionElement);
	
	TransformerFactory transformerFactory = TransformerFactory.newInstance();
	Transformer transformer = transformerFactory.newTransformer();
	DOMSource source = new DOMSource(doc);
	
	String filename = username + "-" + title + "-" + hashkey;
	
	String directory_path = config.getServletContext().getRealPath("/")+"drafts/";
	String files;
	File folder = new File(directory_path);
	File[] listOfFiles = folder.listFiles(); 

	for (int i = 0; i < listOfFiles.length; i++) 
	{
		if (listOfFiles[i].isFile()) 
 		{
 			files = listOfFiles[i].getName();
 			if(files.equals(filename)){
 				%> duplicate <%
 				return;
 			}
    	}
	}
	
	String path = config.getServletContext().getRealPath("/")+"drafts/"+filename + ".xml";
	StreamResult result = new StreamResult(new File(path));
	
	//StreamResult result = new StreamResult(System.out);
	transformer.transform(source, result);
	
	%> saved <%
%>