/**
 * Package that contains classes related to voucher
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import policy.Policy;
import db.Db;

/**
 * @author	Saranya.C
 * @email	saranyachidambaram11@gmail.com
 * @date	13/01/2013
 * 
 * Types of vouchers that can be created
 */

public class Status{
	
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "STATUS";
	
	/**
	 * Unique identity of the Status
	 * 
	 * @var Integer
	 */
	private int statusid;
	
	/**
	 * Unique identity of the voucher
	 * 
	 * @var Integer
	 */
	
	private int voucherid;
	
	/**
	 * Current status of the voucher
	 * 
	 * @var String
	 */
	private String status;
	
	/**
	 * Unique identity of the user
	 * 
	 * @var String
	 */
	
	private String userid;
	
	/**
	 * Time of updation of the voucher status
	 * 
	 * @var Date
	 */
	private Date time;
	
	/**
	 * Creates an empty object
	 */
	public Status() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the voucher type to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Status(int statusid) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE statusid = " + statusid);
		rs.next();
		
		this.statusid = statusid;
		this.setVoucherid(rs.getInt("voucherid"));
		this.setStatus(rs.getString("status"));
		this.setUserid(rs.getString("userid"));
		this.setTime(rs.getDate("time"));
		
		
		db.disconnect();
	}
	/**
	 * Gets the id of the status
	 * 
	 * @return Integer
	 */
	public int getStatusid() {
		return statusid;
	}
	
	/**
	 * Gets the id of the voucher
	 * 
	 * @return Integer
	 */
	public int getVoucherid() {
		return voucherid;
	}
	/**
	 * Sets the id of the voucher
	 * 
	 * @return Integer
	 */
	public void setVoucherid(int voucherid) {
		this.voucherid = voucherid;
	}
	/**
	 * Gets the status of the voucher
	 * 
	 * @return Integer
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * Sets the status of the voucher
	 * 
	 * @return Integer
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * Gets the id of the user
	 * 
	 * @return Integer
	 */
	public String getUserid() {
		return userid;
	}
	/**
	 * Sets the id of the user
	 * 
	 * @return Integer
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * Gets the time of the status
	 * 
	 * @return Integer
	 */
	public Date getTime() {
		return time;
	}
	/**
	 * Sets the time of the status
	 * 
	 * @return Integer
	 */
	public void setTime(Date time) {
		this.time = time;
	}
	
	/**
	 * Returns a list of status
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[voucher.Status]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Status[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM"+ t_name +" WHERE " + column + " = '" + value);
		rs.next();
		
		Status[] list = new Status[rs.getInt(1)];
		
		rs = db.executeQuery("SELECT * FROM"+ t_name +"WHERE " + column + " = '" + value);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Status(rs.getInt("STATUSID"));
		}
		
		return list;
	}


	/**
	 * Saves the local values to the database
	 * 
	 * @return Boolean - Returns true on success
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public boolean saveStatus() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String query = "";
		
		if(this.statusid == 0) {
			query = "INSERT INTO " + t_name +
					" VALUES(DEFAULT,'" + this.voucherid + "','" + this.status + "','" + this.userid + "','" + this.time +"')";
		}
		else {
			query = "UPDATE " + t_name + " SET VOUCHERID = '" + this.voucherid + "', " +
					"STATUS = '" + this.status + "', USERID = '" + this.userid + "', TIME = '" + this.time + "' WHERE STATUSID = '" + this.statusid + "'";
			
		}
		int n = db.executeUpdate(query);
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}

}
