/**
 * Package that contains classes related to voucher
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

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
		this.setTitle(rs.getString("title"));
		this.setDescription(rs.getString("description"));
		
		db.disconnect();
	}
	
	/**
	 * Gets the id of the voucher type
	 * 
	 * @return Integer
	 */

	public int getVtypeid() {
		return this.vtypeid;
	}
	
	/**
	 * Gets the title of the voucher type
	 * 
	 * @return String
	 */
	public String getTitle() {
		return this.title;
	}
	/**
	 * Sets the title of the voucher type
	 * 
	 * @return String
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * Gets the description of the voucher type
	 *   
	 * @return String
	 */	
	public String getDescription() {
		return this.description;
	}
	
	/**
	 * Sets the description of the voucher type
	 *   
	 * @return String
	 */

	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * Saves the local values to the database
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
		
		if(this.vtypeid == 0) {
						
			String values[] = {this.title,this.description};
			this.vtypeid = Integer.parseInt(db.insert(t_name, values, true,true).toString());
			n=1;
		}
		else {
			
			
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("TITLE",this.title);
			map.put("DESCRIPTION",this.description);
			
			n = db.update(t_name, map, "VTYPEID",Integer.toString(this.vtypeid));
			
		}
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}
	
	/**
	 * Returns a list of voucher types
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[voucher.Type]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Type[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value);
		rs.next();
		
		Type[] list = new Type[rs.getInt(1)];
		
		rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE " + column + " = '" + value);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Type(rs.getInt("VTYPEID"));
		}
		
		return list;
	}
	
}
