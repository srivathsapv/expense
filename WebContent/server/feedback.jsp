<%@ page import="email.Email"
		import="java.util.*"
		import="javax.mail.*"
		import="javax.mail.internet.*" 
		import="email.Email" 
		import="utility.Utility"%>

<%
	String name = request.getParameter("name");
	String email_id = request.getParameter("email");
	String feedback = request.getParameter("feedback");
	
	
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
		email.setTitle("Feedback from "+name);
		email.setContent("Name: "+name+"<br/> Email-id: "+email_id+"<br/> Feedback: <br/>"+feedback);
		
		Message message = new MimeMessage(session1);
		message.setFrom(new InternetAddress(email_id));
		message.setRecipients(Message.RecipientType.TO,
			InternetAddress.parse("admn.vowcher@gmail.com"));
		message.setSubject("Feedback from " + name);
		message.setContent(email.generateEmail(),"text/html");

		Transport.send(message);
		
		response.sendRedirect("../pages/feedback.jsp?status="+Utility.MD5("success"));		
		} catch (MessagingException e) {
			response.sendRedirect("../pages/feedback.jsp?status="+Utility.MD5("email-error"));
		}
	
	%> 