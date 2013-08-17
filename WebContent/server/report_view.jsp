<%@ page import ="java.sql.ResultSet,java.sql.Blob,db.Db,java.io.*"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	int reportid = Integer.parseInt(request.getParameter("id"));
	Db db = new Db();
	db.connect();
	ResultSet rs = db.executeQuery("SELECT FILE,TITLE FROM REPORT WHERE REPORTID = '" + reportid + "'");
	if(rs.next()) {
		if(rs.getString(1) != null){
			if(!rs.getString(1).equals("")) {
				Blob image = rs.getBlob(1);
				
				byte[] imgdata = image.getBytes(1,(int)image.length());
				
				String filename = rs.getString(2) + ".pdf";
				
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