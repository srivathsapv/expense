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
				java.util.Date,
				org.json.JSONArray,
				org.json.JSONObject"%>
<%
	String username = Utility.filter(request.getParameter("username"));
	String password = Utility.filter(request.getParameter("password"));
	
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
			
			// for OpenAuthentication
			if(request.getParameter("mode") != null){
				if(request.getParameter("mode").equals("sid") && request.getMethod().equals("POST")){
					Date d = new Date();
					Timestamp t = new Timestamp(d.getTime());
					String timestamp = t.toString();
					String encUnameStr = Utility.MD5(Utility.MD5("{vowcher---secure--id--!|-" + username + "==|=" + password + "}"));
					String sid = Utility.MD5(encUnameStr + Utility.MD5(timestamp));
					
					Authentication secureAuth = new Authentication(username);
					secureAuth.setSecureId(sid);
					secureAuth.save();
					
					JSONObject json_obj = new JSONObject();
					json_obj.put("USERNAME",username);
					json_obj.put("SECUREID",sid);
					json_obj.put("FULLNAME",sessionUser.getFirstName() + " " + sessionUser.getlastName());
					
					out.println(json_obj.toString());
					return;
				}
			}
			
			session.setAttribute("sessionUser",sessionUser);
			session.setAttribute("sessionUsername",username);
			
			//writing currency details to the session
			session.setAttribute("currency","rupees");
			session.setAttribute("currencyText","Indian Rupees");
			session.setAttribute("currencyISO","INR");
			
			//writing the GUI language to the session
			session.setAttribute("lang","eng");
			
			// Writing the last login timestamp to the session
			Authentication auth = new Authentication(username);
			String lastLogin = auth.getLastlogin();
			session.setAttribute("sessionUserRole",auth.getRole());
			
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
			if(request.getParameter("mode") != null){
				if(request.getParameter("mode").equals("sid") && request.getMethod().equals("POST")){
					out.println("AUTH_ERROR");
					return;
				}
			}
			java.util.Date date = new java.util.Date();
			String timeStamp = new Timestamp(date.getTime()).toString();
			session.setAttribute("timestamp",timeStamp);
			
			String status = "{failed}" + timeStamp;
	        String hashedstatus = Utility.MD5(status);
	        
	        if(request.getParameter("redirect") != null){
	        	response.sendRedirect("../pages/login.jsp?status="+hashedstatus+"&redirect_to="+request.getParameter("redirect"));
	        	return;
	        }
	        else{
	        	response.sendRedirect("../pages/login.jsp?status="+hashedstatus);
	        	return;
	        }
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	db.disconnect();
%>