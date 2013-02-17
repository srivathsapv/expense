<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utility.Utility,
				db.Db,
				auth.Authentication,
				java.sql.*,
				user.User,
				auth.Authentication,
				java.math.BigInteger,
				java.security.MessageDigest,
				java.security.NoSuchAlgorithmException,
				java.sql.Timestamp,
				java.text.SimpleDateFormat,
				java.util.Date" 
%>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	Db db = new Db();
	db.connect();
	
	String wherecols[] = {"USERID","PASSWORD"};
	String wherevals[] = {username,Authentication.publicEncrypt(password, username)};
	String logicalconnectors[] = {"","AND"};
	
	ResultSet rs = db.select("LOGIN","COUNT(*)",wherecols,wherevals,logicalconnectors); 
	try{
		rs.next();
		if(rs.getInt(1) == 1) {
			 // Writing the user object to the session
			User sessionUser = new User(username);
			session.setAttribute("sessionUser",sessionUser);
			
			// Writing the last login timestamp to the session
			Authentication auth = new Authentication(username);
			String lastLogin = auth.getLastlogin();
			
			SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date d = f1.parse(lastLogin);
			
			SimpleDateFormat f2 = new SimpleDateFormat("dd MMM yyyy - hh:mm a");
			lastLogin = f2.format(d);
			lastLogin = lastLogin.replace("-","at");
			session.setAttribute("lastlogin",lastLogin);
			
			auth.setLastlogin();
			auth.save();			
			if(request.getParameter("redirect").equals("dashboard")) {	
				response.sendRedirect("../pages/dashboard.jsp");
				return;
			}
			else {
				response.sendRedirect(request.getParameter("redirect"));
				return;	
			}
		}
		else {
			java.util.Date date = new java.util.Date();
			String timeStamp = new Timestamp(date.getTime()).toString();
			session.setAttribute("timestamp",timeStamp);
			
			String status = "{failed}" + timeStamp;
	        String hashedstatus = Utility.MD5(status);
	        
			response.sendRedirect("../pages/login.jsp?status="+hashedstatus);
			return;	
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	db.disconnect();
%>