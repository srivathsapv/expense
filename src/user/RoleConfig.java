/**
 * Package that contains classes related to user
 */
package user;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import db.Db;

/**
 * @author	Srivathsa PV
 * @email	pv.srivathsa@gmail.com
 * @date	10/01/2013
 * 
 * Role based acceptance/claim limit
 */

public class RoleConfig {
	
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "ROLECONFIG";
	
	/**
	 * Unique identity of the role config
	 * 
	 * @var Integer
	 */
	private int id = 0;
	
	/**
	 * Role of the user
	 * 
	 * @var String
	 */
	private String role;
	
	/**
	 * Claim limit
	 * 
	 * @var Integer
	 */
	private int claimLimit;
	
	/**
	 * Acceptance Limit
	 * 
	 * @var Integer
	 */
	private int acceptLimit;
	
	/**
	 * Constructs an empty object
	 */
	public RoleConfig() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the bookmark to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public RoleConfig(int id) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE ID = " + id);
		rs.next();
		
		this.id = id;
		this.role = rs.getString("ROLE");
		this.acceptLimit = rs.getInt("ACCEPT_LIMIT");
		this.claimLimit = rs.getInt("CLAIM_LIMIT");
		
		db.disconnect();
	}
	
	/**
	 * Gets the id of the bookmark
	 * 
	 * @return Integer
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * Gets the role
	 * 
	 * @return String
	 */
	public String getRole() {
		return this.role;
	}
	
	/**
	 * Sets the role
	 * 
	 * @param String
	 */
	public void setRole(String rl) {
		this.role = rl;
	}
	
	/**
	 * Gets the acceptance 
	 * 
	 * @return Integer
	 */
	public int getAcceptLimit() {
		return this.acceptLimit;
	}
	
	/**
	 * Sets the accept limit
	 * 
	 * @param Integer
	 */
	public void setAcceptLimit(int alimit) {
		this.acceptLimit = alimit;
	}
	
	/**
	 * Gets the claim limit
	 * 
	 * @return int
	 */
	public int getClaimLimit() {
		return this.claimLimit;
	}
	
	/**
	 * Sets the claim limit
	 * 
	 * @param claim limit
	 */
	public void setClaimLimit(int climit) {
		this.claimLimit = climit;
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
		
		int n=0;
		if(this.id == 0) {
			String values[] = {this.role,Integer.toString(this.claimLimit),Integer.toString(this.acceptLimit)};
			this.id = Integer.parseInt(db.insert(t_name, values, true,true).toString());
			n=1;
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("ROLE",this.role);
			map.put("CLAIM_LIMIT",Integer.toString(this.claimLimit));
			map.put("ACCEPT_LIMIT",Integer.toString(this.acceptLimit));
			
			n = db.update(t_name,map,"ID",Integer.toString(this.id));
		}
		
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}
	
	/**
	 * Returns a list of bookmark objects
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[user.Bookmark]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static RoleConfig[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'");
		rs.next();
		
		RoleConfig[] list = new RoleConfig[rs.getInt(1)];
		
		rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE " + column + " = '" + value + "'");
		
		int i=0;
		while(rs.next()) {
			list[i++] = new RoleConfig(rs.getInt("ID"));
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
