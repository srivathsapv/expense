<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "user.User,auth.Authentication,utility.Utility"%>
<%@ page import="java.util.*"
		import="javax.mail.*"
		import="javax.mail.internet.*" 
		import="email.Email" %>

<%
	String password = Utility.filter(request.getParameter("password"));
	
	User user = (User)session.getAttribute("sessionUser");
	
	Authentication auth = new Authentication(user.getUserid());
	auth.setPassword(password);
	boolean success = auth.save();
	
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

	try {
		Email email = new Email();
		email.setImg("http://i1307.photobucket.com/albums/s589/sasipraveen/logo_zpsc6b0c2d1.png");
		email.setTitle("Password Change");
		email.setContent("Your password has been changed successfully. You can login to your account from <a href = 'http://127.0.0.1:8080/expense/pages/login.jsp'>here</a>");
		
		Message message = new MimeMessage(session1);
		message.setFrom(new InternetAddress("admn.vowcher@gmail.com"));
		message.setRecipients(Message.RecipientType.TO,
			InternetAddress.parse(user.getEmail()));
		message.setSubject("Password Change");
		message.setContent(email.generateEmail(),"text/html");

		Transport.send(message);
		
		if(success){
			response.sendRedirect("../pages/change_password.jsp?status="+Utility.MD5("success"));
			return;
		}
	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
%>
