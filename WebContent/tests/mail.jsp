<%@ page import="java.util.*"
		import="javax.mail.*"
		import="javax.mail.internet.*" 
		import="email.Email" %>


<%  
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
 
		try {
 			
			Email email = new Email();
			email.setImg("http://i1307.photobucket.com/albums/s589/sasipraveen/logo_zpsc6b0c2d1.png");
			email.setTitle("Title Title....");
			email.setContent("This mail is sent automatically <br/>from Vowcher");
			
			
			Message message = new MimeMessage(session1);
			message.setFrom(new InternetAddress("admn.vowcher@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("pv.srivathsa@gmail.com"));
			message.setSubject("Testing Subject");
			message.setContent(email.generateEmail(),"text/html");
 
			Transport.send(message);
 
			out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	
%>