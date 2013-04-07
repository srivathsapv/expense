<%@ page import="utility.Utility,user.User,auth.Authentication,java.text.*,java.sql.Timestamp" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*"
		import="javax.mail.*"
		import="javax.mail.internet.*" 
		import="email.Email" %>

<%@ include file = "server_authenticate.jsp" %>
<%
	String values[] = new String[18];
	int i =0;
	String path = "";
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
	} else {
    	FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
        	items = upload.parseRequest(request);
        } 
        catch (FileUploadException e) {
        	e.printStackTrace();
        }
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
	        FileItem item = (FileItem) itr.next();
	        if (item.isFormField()) {
	        		values[i++] = item.getString();
	        } 
	        else {
	        	try {	        		
		            String itemName = item.getName();
		            path = config.getServletContext().getRealPath("/")+"uploads/"+itemName;
		            File savedFile = new File(path);
		            item.write(savedFile);
	                          
	            } catch (Exception e) {
	            	e.printStackTrace();
	            }
	       	}
    	}
  	}
	
	//create new login
	Authentication new_login = null;
	if(values[16].equals("")) {
		 new_login = new Authentication();
	}
	else {
		new_login = new Authentication(values[16]);
	}
	
	String randomstr = Utility.randomstr(8);
	
	new_login.setUserid(values[0]);
	new_login.setPassword(randomstr);
	new_login.setRole(values[7]);
	new_login.setLastlogin();
	new_login.setSecureId(""); //OAuth ID is initially null
	
	boolean login_success = new_login.save();
	
	String modestr = "added";
	
	//create new user
	User user = null;
	if(values[16].equals("")){
		user = new User();	
	}
	else {
		modestr = "edited";
		user = new User(values[16]);
	}
	
	user.setUserid(values[0]);
	user.setFirstName(values[1]);
	user.setMiddleName(values[2]);
	user.setlastName(values[3]);
	user.setSocialSecurity(values[4]);
	
	SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
	Date d1 = fmt.parse(values[5]);
	
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String d2 = fmt2.format(d1);
	
	user.setDate(d2);
	
	user.setGender(values[6]);
	user.setDeptid(Integer.parseInt(values[8]));
	user.setManager(values[9]);
	user.setDesignation(values[10]);
	user.setAddress(values[11]);
	user.setPhone(values[12]);
	user.setMobile(values[13]);
	user.setEmail(values[14]);
	if(!path.equals(""))
		user.setPhoto(path);
	
	boolean user_success = user.save();
	
	final String username = "admn.vowcher@gmail.com";
	final String pwd = "asdfasdfasdf";

	Properties props = new Properties();
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.port", "587");

	Session session1 = Session.getInstance(props,
	  new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, pwd);
		}
	  });
	if(modestr.equals("added")){
		try {
			Email email = new Email();
			email.setImg("http://i1307.photobucket.com/albums/s589/sasipraveen/logo_zpsc6b0c2d1.png");
			email.setTitle("Welcome to Vowcher");
			email.setContent("<p>Hello " + user.getFirstName() + ",</p><br>"
							 +"Vowcher is an online expense management system that takes care of your entire expense claim process."
							 + "Its meticulously designed voucher flow hierarchical system takes care the needs of your reimbursement process."
							 + "Some of Vowcher's exciting features are <br><br>"
							 + "<ul>"
							 + "<li>Graphical reports exportable in PDF Format</li>"
							 + "<li>Quick access to users and vouchers through search</li>"
							 + "<li>Notifications in dashboard and also through email</li>"
							 + "<li>Mobile Application to upload vouchers from mobile</li>"
							 + "<li>GUI provided both in English and Hindi</li>"
							 + "<li>Intuitive menu driven and easy to understand GUI for greater user experience</li><br><br>"
							 + "Want to get the real taste of Vowcher? Login <a href = 'http://localhost:8080/expense/pages/login.jsp'>here</a> using the following credentials <br><br>"
							 + "<b>Username:</b>" + user.getUserid() + "<br><br>"
							 + "<b>Password:</b>" + randomstr +"<br><br>"
							 + "You can later change the password <a href = 'http://localhost:8080/expense/pages/change_password.jsp'>here</a>");
			
			Message message = new MimeMessage(session1);
			message.setFrom(new InternetAddress("admn.vowcher@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(user.getEmail()));
			message.setSubject("Welcome to Vowcher");
			message.setContent(email.generateEmail(),"text/html");

			Transport.send(message);
			
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}	
	}
	
	if(user_success && login_success){
		response.sendRedirect("../pages/user_view.jsp?status=" + Utility.MD5("success") + "&userid="+values[0] + "&message=User " + modestr + " successfully");
		return;
	}
	else {
		response.sendRedirect("../pages/user_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>