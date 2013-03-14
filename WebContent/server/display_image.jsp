<%@ page import ="java.sql.ResultSet,java.sql.Blob,db.Db,java.io.OutputStream" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String mode = request.getParameter("mode");

	Db db = new Db();
	db.connect();
	
	if(mode.equals("profile_picture")){
		String userid = request.getParameter("userid");	
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
		}	
	}
	else if(mode.equals("attachment_image")) {
		String vid = request.getParameter("vid");
		String ext = request.getParameter("ext");
		
		ResultSet rs = db.executeQuery("SELECT ATTACHMENT FROM VOUCHER WHERE VOUCHERID = '" + vid + "'");
		if(rs.next()){
			if(!rs.getString(1).equals("")){
				Blob image = rs.getBlob(1);
				byte[] imgdata = image.getBytes(1,(int)image.length());
				OutputStream outp = response.getOutputStream();
				response.setContentType("image/"+ext);
				outp.write(imgdata);
				outp.flush();
				outp.close();
			}
		}
	}
	db.disconnect();
%>