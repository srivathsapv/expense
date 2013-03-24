package email;

/**
 * 
 * @author Sasi Praveen
 * @email sasipraveen39@mail.com
 * @date 23/03/2013
 * 
 * Email is class that is used to generate the format for an html mail
 */


public class Email {

	/**
	 * Title of the E-mail to be sent
	 * 
	 * @var String 
	 */
	private String title;
	
	/**
	 * URL of the image to be displayed as logo
	 * 
	 * @var String
	 */
	private String img;
	
	/**
	 * Body of the E-mail to be sent
	 * 
	 * @var String
	 */
	private String content;
	
	/**
	 * Signature of the Personnel who is sending the E-mail
	 */
	private String signature;
	
	/**
	 * initialize all the variables to empty String
	 */
	public Email() {
		this.title="";
		this.img="";
		this.content="";
		this.signature="";
	}
	
	/**
	 * Returns the title of the E-mail
	 * 
	 * @return String 
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * Sets the title of the E-mail
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * Returns the Image URL of the E-mail logo
	 * 
	 * @return String 
	 */
	public String getImg() {
		return img;
	}
	
	/**
	 * Sets the Image URL of the E-mail logo
	 * 
	 * @param title
	 */
	public void setImg(String img) {
		this.img = img;
	}
	
	/**
	 * Returns the body content of the E-mail
	 * 
	 * @return String 
	 */
	public String getContent() {
		return content;
	}
	
	/**
	 * Sets the body content of the E-mail
	 * 
	 * @param title
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * Returns the Signature of the E-mail
	 * 
	 * @return String 
	 */
	public String getSignature() {
		return signature;
	}
	
	/**
	 * Sets the Signature of the E-mail
	 * 
	 * @param title
	 */
	public void setSignature(String signature) {
		this.signature = signature;
	}
	
	/**
	 * Generates the final E-mail with all the fields
	 * 
	 * @return String  
	 */
	public String generateEmail(){
		String message = "";
		
		message="<div style=\"background-color:#202020;\">" 
				+"<table width=\"100%\" style=\"padding:5px 5px 0px;\">" +
				"<tr>"
				+"<td><img src=\""+this.img+"\"></td>"
				+"<td style=\"color:white;\"><h3>"+this.title+"</h3></td>" +
						"</tr>" +
						"</table>"
				+"<div style=\"background-color:#ffffff;border-top:#447FB8 solid 6px;border-bottom:#447FB8 solid 3px\">"
				+"<p style=\"padding:20px 5px 20px\">"+this.content+"</p>"
				+"</div>"+
				"<table width=\"100%\" style=\"color:#ffffff;padding:0px 5px 0px\">" +
				"<tr>"+		
				"<td><small>This is an auto generated mail. Do not reply</small></td>" +
						"<td style=\"text-align:right;\"><small>Copyrights Reserved 2013</small></td>" +
						"</tr>" +
						"</table>"
				+"</div>";
		
		return message;
	}
	
}
