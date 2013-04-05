/**
 * Package that contains classes related to user
 */
package user;

import java.text.ParseException;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

import sms.SMS;

import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.Db;
import email.Email;

/**
 * @author	Srivathsa PV
 * @email	pv.srivathsa@gmail.com
 * @date	15/01/2013
 * 
 * Notifications are updates that appear on the user's dashboard. They contain information about
 * their submitted vouchers, its status etc.
 */
public class Notification {

	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "NOTIFICATION";
	
	/**
	 * Unique id of the notification
	 * 
	 * @var Integer
	 */
	private int id = 0;
	
	/**
	 * ID of the user to whom the notification is displayed
	 * 
	 * @var String
	 */
	private String userid;
	
	/**
	 * Category of the notification. Ex: voucher,new user request,password change etc.
	 * 
	 * @var String
	 */
	private String category;
	
	/**
	 * ID of the category entity
	 * 
	 * @var String
	 */
	private String categoryid;
	
	/**
	 * Time update of the notification
	 * 
	 * @var String
	 */
	private String timeupdate;
	
	/**
	 * Creates an empty object
	 */
	public Notification() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the notification to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Notification(int id) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE ID = " + id);
		rs.next();
		
		this.id = id;
		this.userid = rs.getString("USERID");
		this.category = rs.getString("CATEGORY");
		this.categoryid = rs.getString("CATEGORYID");
		this.timeupdate = rs.getString("TIMEUPDATE");
		
		db.disconnect();
	}
	
	/**
	 * Gets the Id of the notification
	 * 
	 * @return Integer
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * Gets the user id of the notification
	 * 
	 * @return String
	 */
	public String getUserid() {
		return this.userid;
	}
	
	/**
	 * Sets the user id of the notification
	 * 
	 * @param String
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	/**
	 * Gets the category of the notification
	 * 
	 * @return String
	 */
	public String getCategory() {
		return this.category;
	}
	
	/**
	 * Sets the category of the notification
	 * 
	 * @param String
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	
	/**
	 * Gets the category id of the notification
	 * 
	 * @return String
	 */
	public String getCategoryid() {
		return this.categoryid;
	}
	
	/**
	 * Sets the category id of the notification
	 * 
	 * @param String
	 */
	public void setCategoryid(String categoryid) {
		this.categoryid = categoryid;
	}
	
	/**
	 * Gets the timeupdate of the notification
	 * 
	 * @return String
	 */
	public String getTimeupdate() {
		return this.timeupdate;
	}
	
	/**
	 * Sets the timeupdate of the notification
	 *  
	 * @throws ParseException 
	 */
	public void setTimeupdate() throws ParseException {
		Date d = new Date();
		
		SimpleDateFormat f0 = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy");
		Date d0 = f0.parse(d.toString());
		
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
		this.timeupdate = f.format(d0);

	}
	
	/**
	 * Saves the local values to the database
	 * 
	 * @return int - Returns number greater than zero on success
	 * 			   - Returns zero on failure
	 * 			   - Returns -1 on email error
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public int save() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String query = "";
		
		int n = 0;
		
		if(this.id == 0) {
			query = "INSERT INTO " + t_name +
					" VALUES(DEFAULT,'" + this.userid  + "','" + this.category + "','" + 
					this.categoryid + "','" + this.timeupdate + "')";
			
			String values[] = {this.userid,this.category,this.categoryid,this.timeupdate};
			this.id = Integer.parseInt(db.insert(t_name,values,true,true).toString());
			n = this.id;
			
			//mail notifications
			user.User usr = new User(this.userid);
			if(this.category.equals("voucher status change")){
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
					String subject = "";
					String content = "";
					
					voucher.Status stat = new voucher.Status(Integer.parseInt(this.categoryid));
					voucher.Voucher vouch = new voucher.Voucher(stat.getVoucherid());
					if(stat.getStatus().equals("accepted")){
						subject = "Voucher Accepted";
					}
					else if(stat.getStatus().equals("rejected")) {
						subject = "Voucher Rejected";
					}
					else if(stat.getStatus().equals("under consideration")){
						subject = "Voucher Considered";
					}
					else if(stat.getStatus().equals("sanctioned")){
						subject = "Voucher Sanctioned";
					}
					
					String statstr = stat.getStatus();
					if(statstr.equals("under consideration")) statstr = "considered";
					user.User statuser = new User(stat.getUserid());
					String statusername = statuser.getFirstName() + " " + statuser.getlastName();
					
					content = "Your voucher <a href = 'http://127.0.0.1:8080/expense/pages/voucher_view.jsp?id="
							  + vouch.getVoucherid() + "'>" + vouch.getTitle() + "</a> has been " + statstr
							  + " by <a href = 'http://127.0.0.1:8080/expense/pages/user_view.jsp?userid=" + stat.getUserid() + "'>"
							  + statusername + "</a>";
					
					Email email = new Email();
					email.setImg("http://i1307.photobucket.com/albums/s589/sasipraveen/logo_zpsc6b0c2d1.png");
					email.setTitle(subject);
					email.setContent(content);
					
					Message message = new MimeMessage(session1);
					message.setFrom(new InternetAddress("admn.vowcher@gmail.com"));
					message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(usr.getEmail()));
					message.setSubject(subject);
					message.setContent(email.generateEmail(),"text/html");
		 
					Transport.send(message);
					
				} catch (Exception e) {
					return -1;
				}
			}
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("USERID", this.userid);
			map.put("CATEGORY",this.category);
			map.put("CATEGORYID",this.categoryid);
			map.put("TIMEUPDATE",this.timeupdate);
			
			n = db.update(t_name,map,"ID",Integer.toString(this.id));
			
		}
		db.disconnect();
		
		return n;
	}
	
	/**
	 * Returns a list of notification objects
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[user.Notification]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Notification[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String cnt_query = "";
		String query = "";
		if(column.equals("")){
			query = "SELECT * FROM " + t_name + " ORDER BY TIMEUPDATE DESC";
			cnt_query = "SELECT COUNT(*) FROM " + t_name;
			
		}
		else {
			query = "SELECT * FROM " + t_name + " WHERE " + column + " = '" + value + "' ORDER BY TIMEUPDATE DESC";
			cnt_query = "SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'";
		}
		
		ResultSet rs = db.executeQuery(cnt_query);
		rs.next();
		
		Notification[] list = new Notification[rs.getInt(1)];
		
		rs = db.executeQuery(query);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Notification(rs.getInt("ID"));
		}
		
		return list;
	}
	
	/**
	 * Returns a count based on the values
	 * 
	 * @param String - Column name as filter parameter
	 * @param String - Value
	 * 
	 * @return Integer - The count
	 * 
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public static int count(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value);
		rs.next();
		
		return rs.getInt(1);
	}
	
	/**
	 * Deletes the voucher
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		
		db.delete("NOTIFICATION", "ID", Integer.toString(this.id));
				
		db.disconnect();
	}
}
