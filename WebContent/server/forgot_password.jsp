<%@ page import="java.util.Properties,
				 user.User,
				 email.Email,
				 utility.Utility,
				 auth.Authentication,
				 javax.mail.Message,
				 javax.mail.PasswordAuthentication,
				 javax.mail.Session,
				 javax.mail.Transport,
				 javax.mail.internet.InternetAddress,
				 javax.mail.internet.MimeMessage" %>

<%
	String userid = request.getParameter("username");
	
	String randomPwd = Utility.randomstr(8);
	
	Authentication auth = new Authentication(userid);
	auth.setPassword(randomPwd);
	auth.save();
	
	User user = new User(userid);
	String emailId = user.getEmail();
	
	final String username = "admn.vowcher@gmail.com";
	final String password = "asdfasdfasdf";
	
	Properties props = new Properties();
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.port", "587");

	Session session1 = Session.getInstance(props,
	  new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
		}
	  });
	
	
	String content = "A request to reset your password has been recieved. Your new password is <b>" + randomPwd + "</b>." +
					 "You can later change your password <a href ='http://127.0.0.1:8080/WebApp_ID/pages/change_password.jsp'>here</a>.";
	
 	Email email = new Email();
	email.setImg("http://i1307.photobucket.com/albums/s589/sasipraveen/logo_zpsc6b0c2d1.png");
	email.setTitle("Password Reset");
	email.setContent(content);
	
	Message message = new MimeMessage(session1);
	message.setFrom(new InternetAddress("admn.vowcher@gmail.com"));
	message.setRecipients(Message.RecipientType.TO,
	InternetAddress.parse(emailId));
	message.setSubject("Password Reset");
	message.setContent(email.generateEmail(),"text/html");

	Transport.send(message);
	
	response.sendRedirect("../pages/login.jsp?msg=password_reset");
	return;
%>