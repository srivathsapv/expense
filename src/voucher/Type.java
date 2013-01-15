/**
 * Package that contains classes related to voucher
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;

import db.Db;

/**
 * @author	Saranya.C
 * @email	saranyachidambaram11@gmail.com
 * @date	13/01/2013
 * 
 * Types of vouchers that can be created
 */

public class Type {
	
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "VOUCHER_TYPE";
	
	/**
	 * Unique identity of the voucher type
	 * 
	 * @var Integer
	 */
	private int vtypeid;
	
	/**
	 * Title of the voucher type
	 * 
	 * @var String
	 */
	private String title;
	
	/**
	 *Description about the voucher type
	 * 
	 * @var String
	 */
	private String description;
	
	/**
	 * Creates an empty object
	 */
	public Type() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the voucher type to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Type(int vtypeid) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE vtypeid = " + vtypeid);
		rs.next();
		
		this.vtypeid = vtypeid;
		this.title = rs.getString("title");
		this.description = rs.getString("description");
		
		db.disconnect();
	}
}
