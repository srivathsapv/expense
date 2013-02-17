/**
 * Package that contains classes related to voucher
 */
package voucher;
	
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;

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
		this.userid = rs.getString("USERID");
		this.title = rs.getString("TITLE");
		this.amount = rs.getInt("AMOUNT");
		this.vtypeid=rs.getInt("VTYPEID");
		this.date=rs.getDate("DATE");
		this.description=rs.getString("DESCRIPTION");
		this.attachment=rs.getString("ATTACHMENT");
		this.rejectReason=rs.getString("REJECTREASON");
		this.policyid=rs.getInt("POLICYID");
		
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
	public boolean save() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		int n = 0;
		if(this.voucherid == 0) {
			String values[] = {this.userid,this.title,Double.toString(this.amount),
							   Integer.toString(this.vtypeid),this.date.toString(),
							   this.description,this.attachment,this.rejectReason,Integer.toString(this.policyid)};
			
			this.voucherid = Integer.parseInt(db.insert(t_name,values,true,true).toString());
			n = 1;
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("USERID",this.userid);
			map.put("TITLE",this.title);
			map.put("AMOUNT",Double.toString(this.amount));
			map.put("VTYPEID",Integer.toString(this.vtypeid));
			map.put("DATE",this.date.toString());
			map.put("DESCRIPTION",this.description);
			map.put("ATTACHMENT",this.attachment);
			map.put("REJECTREASON",this.rejectReason);
			map.put("POLICYID",Integer.toString(this.policyid));
			
			n = db.update(t_name, map, "VOUCHERID", Integer.toString(this.voucherid));
		}
		
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}
	
	/**
	 * Returns a list of user objects
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[user.User]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Voucher[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value);
		rs.next();
		
		Voucher[] list = new Voucher[rs.getInt(1)];
		
		rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE " + column + " = '" + value);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Voucher(rs.getInt("VOUCHERID"));
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

}