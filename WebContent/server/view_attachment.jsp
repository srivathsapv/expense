<%@ page import ="java.sql.ResultSet,java.sql.Blob,db.Db,java.io.*"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	Db db = new Db();
	db.connect();
	String vid = request.getParameter("vid");	
	ResultSet rs = db.executeQuery("SELECT ATTACHMENT,EXTENSION,TITLE FROM VOUCHER WHERE VOUCHERID = '" + vid + "'");
	if(rs.next()) {
			if(rs.getString(1) != null){
				if(!rs.getString(1).equals("")) {
					Blob image = rs.getBlob(1);
					
					String app_type = "";
					if(rs.getString(2).equals("pdf")){
						app_type = "pdf";
					}
					else if(rs.getString(2).equals("doc") || rs.getString(2).equals("docx")){
						app_type = "msword";
					}
					response.setContentType("application/"+app_type);
					byte[] imgdata = image.getBytes(1,(int)image.length());
					
					String filename = rs.getString(3) + "." +rs.getString(2);
					
					FileOutputStream fout = new FileOutputStream(new File(config.getServletContext().getRealPath("/")+"temp/"+filename));
					fout.write(imgdata);
					fout.flush();
					fout.close();
					db.disconnect();		
					response.sendRedirect("../temp/"+filename);
					return;
				}
			}
		}
		
	
%>