/**
 * Package that contains classes related to voucher
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
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
		this.voucherid= rs.getInt("voucherid");
		this.status = rs.getString("status");
		this.userid=rs.getString("userid");
		this.time=rs.getDate("time");
		
		
		db.disconnect();
	}
}
