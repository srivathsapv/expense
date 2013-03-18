/**
 * Package that contains classes related to user
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import user.User;

import db.Db;

/**
 * @author	Srivathsa PV
 * @email	pv.srivathsa@gmail.com
 * @date	10/01/2013
 * 
 * Bookmarks are easy to access links that appear on the user's dashboard
 */

public class AmountConfig {
	
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "AMOUNT_CONFIG";
	
	/**
	 * Unique id of the amount config
	 * 
	 * @var Integer
	 */
	private int id = 0;
	
	/**
	 * Lower limit of the config
	 * 
	 * @var Integer
	 */
	private int lowerLimit;
	
	/**
	 * Upper limit of the config
	 * 
	 * @var Integer
	 */
	private int upperLimit;
	
	/**
	 * Max count of acceptance
	 * 
	 * @var Integer
	 */
	private int maxCount;
	
	/**
	 * Constructs an empty object
	 */
	public AmountConfig() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the bookmark to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public AmountConfig(int id) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE ID = " + id);
		rs.next();
		
		this.id = id;
		this.lowerLimit = rs.getInt("LOWER_LIMIT");
		this.upperLimit = rs.getInt("UPPER_LIMIT");
		this.maxCount = rs.getInt("MAXCOUNT");
		
		db.disconnect();
	}
	
	/**
	 * Gets the id of the config
	 * 
	 * @return Integer
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * Gets the lower limit
	 * 
	 * @return Integer
	 */
	public int getLowerLimit() {
		return this.lowerLimit;
	}
	
	/**
	 * Sets the lower limit
	 * 
	 * @param Integer
	 */
	public void setLowerLimit(int ll) {
		this.lowerLimit = ll;
	}
	
	/**
	 * Gets the upper limit
	 * 
	 * @return Integer
	 */
	public int getUpperLimit() {
		return this.upperLimit;
	}
	
	/**
	 * Sets the upper limit
	 * 
	 * @param Integer
	 */
	public void setUpperLimit(int ul) {
		this.upperLimit = ul;
	}
	
	/**
	 * Gets the max count
	 * 
	 * @return Integer
	 */
	public int getMaxCount() {
		return this.maxCount;
	}
	
	/**
	 * Sets the max count
	 * 
	 * @param Integer
	 */
	public void setMaxCount(int mcount) {
		this.maxCount = mcount;
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
			String values[] = {Integer.toString(this.lowerLimit),Integer.toString(this.upperLimit),Integer.toString(this.maxCount)};
			this.id = Integer.parseInt(db.insert(t_name, values, true,true).toString());
			n=1;
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("LOWER_LIMIT",Integer.toString(this.lowerLimit));
			map.put("UPPER_LIMIT",Integer.toString(this.upperLimit));
			map.put("MAXCOUNT",Integer.toString(this.maxCount));
			
			n = db.update(t_name,map,"ID",Integer.toString(this.id));
		}
		
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}
	
	/**
	 * Returns a list of config objects
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[voucher.AmountConfiguration]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static AmountConfig[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String cnt_query = "";
		String query = "";
		if(column.equals("")){
			query = "SELECT * FROM " + t_name + " ORDER BY LOWER_LIMIT";
			cnt_query = "SELECT COUNT(*) FROM " + t_name;
			
		}
		else {
			query = "SELECT * FROM " + t_name + " WHERE " + column + " = '" + value + "' ORDER BY LOWER_LIMIT";
			cnt_query = "SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'";
		}
		
		ResultSet rs = db.executeQuery(cnt_query);
		rs.next();
		
		AmountConfig[] list = new AmountConfig[rs.getInt(1)];
		
		rs = db.executeQuery(query);
		
		int i = 0;
		while(rs.next()) {
			list[i++] = new AmountConfig(rs.getInt("ID"));
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
	 * Converts the object to json object
	 * 
	 * @return org.json.JSONObject
	 * 
	 * @throws JSONException 
	 */
	public JSONObject toJSON() throws JSONException {
		JSONObject obj = new JSONObject();
		
		obj.put("id",this.id);
		obj.put("lowerlimit", this.lowerLimit);
		obj.put("upperlimit",this.upperLimit);
		obj.put("maxcount", this.maxCount);
		
		return obj;
	}
	
	/**
	 * Deletes the amount configuration
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		db.delete(t_name,"ID",Integer.toString(this.id));
		db.disconnect();
	}
}
