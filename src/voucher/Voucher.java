/**
 * Package that contains classes related to voucher
 */
package voucher;
	
import java.sql.ResultSet;

import org.json.JSONException;
import org.json.JSONObject;

import utility.Utility;

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
	 * @var String
	 */
	private String date;
	
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
	 * File extension of the attachment
	 * 
	 * @var String
	 */
	private String extension;
	
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
	
	/**
	 * Internal variable to keep track whether attachment has been set
	 * 
	 * @var Boolean
	 */
	private boolean attached = false;
	
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
		this.date=rs.getString("DATE");
		this.description=rs.getString("DESCRIPTION");
		this.attachment=rs.getString("ATTACHMENT");
		this.extension = rs.getString("EXTENSION");
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
	public double getAmount() {
		return this.amount;
	}
	
	/**
	 * Sets the amount of the voucher
	 * 
	 * @param Double
	 */
	public void setAmount(double amount) {
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
	 * @return String
	 */
	public String getDate() {
		return this.date;
	}
	
	/**
	 * Sets the title of the voucher
	 * 
	 * @param String
	 */
	public void setDate(String d) {
		this.date = d;
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
		this.attached = true;
	}
	
	/**
	 * Gets the file extension of the attachment
	 * 
	 * @return String
	 */
	public String getExtension() {
		return this.extension;
	}
	
	/**
	 * Sets the file extension of the attachment
	 * 
	 * @param String
	 */
	public void setExtension(String ext){
		this.extension = ext;
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
	 * Get JSON representation of the class
	 * 
	 * @return org.json.JSONObject
	 * @throws JSONException 
	 */
	public String getJSON() throws JSONException{
		JSONObject voucher = new JSONObject();
		
		voucher.put("title", this.title);
		voucher.put("amount",this.amount);
		voucher.put("type",this.vtypeid);
		voucher.put("date",this.date);
		
		String desc = this.description;
		desc = desc.replaceAll("<","&lt;");
		desc = desc.replaceAll(">","&gt;");
		desc = desc.replaceAll("/","&#47");
		desc = desc.replaceAll("\\/","");

		voucher.put("description",desc);
		
		return voucher.toString();
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
							   this.description,null,this.extension,this.rejectReason,Integer.toString(this.policyid)};
			
			this.voucherid = Integer.parseInt(db.insert(t_name,values,true,true).toString());
			
			//insert attachment
			if(this.attached)
				db.updateBlob(t_name,"ATTACHMENT","VOUCHERID",Integer.toString(this.voucherid),this.attachment);
			
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
			map.put("EXTENSION", this.extension);
			if(this.rejectReason == null)
				map.put("REJECTREASON","");
			else
				map.put("REJECTREASON",this.rejectReason);
			map.put("POLICYID",Integer.toString(this.policyid));
			
			n = db.update(t_name, map, "VOUCHERID", Integer.toString(this.voucherid));
			
			//update attachment
			if(this.attached) {
				if(!this.attachment.equals(""))
					db.updateBlob(t_name,"ATTACHMENT","VOUCHERID",Integer.toString(this.voucherid),this.attachment);
			}
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
	public static Voucher[] list(String column,String value,int limit) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'");
		rs.next();
		
		Voucher[] list = new Voucher[rs.getInt(1)];
		
		String query = "SELECT * FROM " + t_name + " WHERE " + column + " = '" + value + "'";
		
		if(limit != 0) {
			query += " ORDER BY DATE FETCH FIRST " + Integer.toString(limit) + " ROWS ONLY";
			list = new Voucher[limit];
		}
		
		rs = db.executeQuery(query);
		
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
	
	/**
	 * Deletes the voucher
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		
		db.delete("VOUCHER_STATUS", "VOUCHERID", Integer.toString(this.voucherid));
		db.delete("VOUCHER", "VOUCHERID", Integer.toString(this.voucherid));
		
		ResultSet rs = db.executeQuery("SELECT * FROM WHERE CATEGORY IN('voucher','voucher status change','sanctioned') AND CATEGORYID = " + Integer.toString(this.voucherid));
		while(rs.next()){
			user.Notification n = new user.Notification(rs.getInt(1));
			n.delete();
		}
		
		db.disconnect();
	}

}