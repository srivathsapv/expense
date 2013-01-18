	/**
	 * Package that contains classes related to voucher
	 */
	package voucher;
	
	
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import  java.util.Date;

import org.omg.CORBA.Current;

import db.Db;

	 
	/**
	 * @author	Saranya C
	 * @email	saranyachidambaram11@gmail.com
	 * @date	12/01/2013
	 * 
	 * Voucher contains detail regarding the employee's expense.
	 */


public class Voucher {
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "VOUCHER";
	/**
	 * Unique identity of the Voucher.
	 * 
	 * @var Integer
	 */
	private int voucherid;

	/**
	 * Id of the user who has created the Voucher.
	 * 
	 * @var String
	 */
	private String userid;
	
	/**
	 * Title of the Voucher.
	 * 
	 * @var String
	 */
	private String title;
	

	/**
	 * Amount that the user claim using the Voucher
	 * 
	 * @var  Double
	 */
	private double amount;
	
	/**
	 * Id of the voucher type to which the voucher belong to
	 * 
	 * @var Integer
	 */
	private int vtypeid;
	
	/**
	 * Date of creation of the voucher
	 * 
	 * @var Date
	 */
	private Date date;
	
	/**
	 * Description about the voucher
	 * 
	 * @var String
	 */
	private String description;
	
	 
	/**
	 * Attachments to the voucher
	 * 
	 * @var String
	 */
	private String attachment;
	
	/**
	 * Reason for the rejection of the voucher
	 * 
	 * @var String
	 */
	private String rejectReason;
	
	/**
	 * Id of the policy to which the voucher belongs 
	 * 
	 * @var Integer
	 */
	private int policyid;
	
	/**
	 * Creates an empty object
	 */
	public Voucher(){}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the voucher to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Voucher(int voucherid) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE voucherid = " + voucherid);
		rs.next();
		
		this.voucherid = voucherid;
		this.userid = rs.getString("userid");
		this.title = rs.getString("title");
		this.amount = rs.getInt("amount");
		this.vtypeid=rs.getInt("vtypeid");
		this.date=rs.getDate("date");
		this.description=rs.getString("description");
		this.attachment=rs.getString("attachment");
		this.rejectReason=rs.getString("rejectReason");
		this.policyid=rs.getInt("policyid");
		
		
		db.disconnect();
	}
	
	/**
	 * Gets the id of the voucher
	 * 
	 * @return Integer
	 */
	public int getVoucherid() {
		return this.voucherid;
	}
	/**
	 * Gets the id of the user who has created the voucher
	 * 
	 * @return String
	 */
	public String getUserid() {
		return this.userid;
	}
	
	/**
	 * Sets the id of the user who has created the voucher
	 * 
	 * @param String
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	/**
	 * Gets the title of the voucher
	 * 
	 * @return String
	 */
	public String getTitle() {
		return this.title;
	}
	
	/**
	 * Sets the title of the voucher
	 * 
	 * @param String
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * Gets the amount of the voucher
	 * 
	 * @return Double
	 */
	public Double getAmount() {
		return this.amount;
	}
	
	/**
	 * Sets the amount of the voucher
	 * 
	 * @param Double
	 */
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
	/**
	 * Gets the voucher type id of the voucher
	 * 
	 * @return Integer
	 */
	public int getVtypeid() {
		return this.vtypeid;
	}
	
	/**
	 * Sets the voucher type id of the voucher
	 * 
	 * @param Integer
	 */
	public void setVtypeid(int vtypeid) {
		this.vtypeid = vtypeid;
	}
	
	/**
	 * Gets the date of creation of the voucher
	 * 
	 * @return Date
	 */
	public Date getDate() {
		return this.date;
	}
	
	/**
	 * Sets the title of the voucher
	 * 
	 * @param String
	 */
	public void setDate() {
		this.date = new java.util.Date();
	}
	
	/**
	 * Gets the description of the voucher
	 * 
	 * @return String
	 */
	public String getDescription() {
		return this.description;
	}
	
	/**
	 * Sets the description of the voucher
	 * 
	 * @param String
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * Gets the attachment of the voucher
	 * 
	 * @return String
	 */
	public String getAttachment() {
		return this.attachment;
	}
	
	/**
	 * Sets the attachment to the voucher
	 * 
	 * @param String
	 */
	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	/**
	 * Gets the reject reason of the voucher
	 * 
	 * @return String
	 */
	public String getRejectReason() {
		return this.rejectReason;
	}
	
	/**
	 * Sets the reject reason of the voucher
	 * 
	 * @param String
	 */
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
	/**
	 * Gets the policy id of the voucher
	 * 
	 * @return Integer
	 */
	public int getPolicyid() {
		return this.policyid;
	}
	
	/**
	 * Sets the policy id of the voucher
	 * 
	 * @param String
	 */
	public void setPolicyid(int policyid) {
		this.policyid = policyid;
	}
	/**
	 * Creates a new voucher with necessary detail
	 * 
	 * @return Boolean - Returns true on success
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public boolean createVoucher() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String query = "";
		
		if(this.voucherid == 0) {
			query = "INSERT INTO " + t_name +
					" VALUES(DEFAULT,'" + this.userid  + "','" + this.title + "','" + this.amount + "','" + this.vtypeid + "','"+ this.date + "','" + this.description + "','" + this.attachment + "','" + this.rejectReason+ "','" + this.policyid + "')";
		}
		else {
			query = "UPDATE " + t_name + " SET USERID = '" + this.userid + "', " +
					"TITLE = '" + this.title + "', AMOUNT = '" + this.amount + "', VTYPEID = '" + this.vtypeid+ "', DATE = '" + this.date +"', DESCRIPTION = '" + this.description +"', ATTACHMENT = '" + this.attachment + "', REJECT_REASON = '" + this.rejectReason + "', POLICYID = '" + this.policyid +"' WHERE VOUCHERID = '" + this.voucherid + "'";
			
			
		}
		int n = db.executeUpdate(query);
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}

}