<%@ page import ="java.sql.ResultSet,java.sql.Blob,db.Db,java.io.OutputStream" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String userid = request.getParameter("userid");
	
	Db db = new Db();
	db.connect();
	
	ResultSet rs = db.executeQuery("SELECT PHOTO FROM USER WHERE USERID = '" + userid + "'");
	if(rs.next()) {
		if(!rs.getString(1).equals("")) {
			Blob image = rs.getBlob(1);
			byte[] imgdata = image.getBytes(1,(int)image.length());
			OutputStream outp = response.getOutputStream();
			response.setContentType("image/jpg");
			outp.write(imgdata);
			outp.flush();
			outp.close();
		}
		else {
			
		}
	}
%>