/**
 * Package that contains classes related to policy
 */
package policy;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import user.User;


import db.Db;


/**
 * @author	Saranya C
 * @email	saranyachidambaram11@gmail.com
 * @date	13/01/2013
 * 
 * Policy details of the voucher assigned by the company
 */

public class Policy {
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "POLICY";
	/**
	 * Unique identity of the Policy.
	 * 
	 * @var Integer
	 */
	private int policyid;
	
	/**
	 * Title of the policy.
	 * 
	 * @var String
	 */
	private String title;
	/**
	 * Description about the policy
	 * 
	 * @var String
	 */
	private String description;
	/**
	 * Percentage of amount that can be sanctioned for the policy
	 * 
	 * @var Integer
	 */
	private double amountPercent;
	
	
	/**
	 * States whether the policy is currently available
	 * 
	 * @var Integer
	 */
	private int available;
	
	/**
	 * Creates an empty object
	 */
	public Policy(){}

	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the policy to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Policy(int policyid)throws ClassNotFoundException,SQLException{
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE policyid = " + policyid);
		rs.next();
		
		this.policyid = policyid;
		this.title = rs.getString("TITLE");
		this.description=rs.getString("DESCRIPTION");
		this.amountPercent=rs.getInt("AMOUNTPERCENT");
		this.available=rs.getInt("AVAILABLE");
		
		db.disconnect();
	}
	
	/**
	 * Gets the id of the policy
	 * 
	 * @return Integer
	 */
	public int getPolicyid() {
		return this.policyid;
	}
	
	/**
	 * Gets the title of the policy
	 * 
	 * @return String
	 */
	public String getTitle() {
		return this.title;
	}
	
	/**
	 * Sets the title of the policy
	 * 
	 * @param String
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * Gets the description of the policy
	 *   
	 * @return String
	 */
	public String getDescription() {
		return this.description;
	}
	
	/**
	 * Sets the description of the policy
	 * 
	 * @param String
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * Gets the amount in percentage allowed for the policy
	 * 
	 * @return Integer
	 */
	public double getAmountPercent() {
		return this.amountPercent;
	}
	
	/**
	 * Sets the amount of the voucher
	 * 
	 * @param Integer
	 */
	public void setAmountPercent(double amountPercent) {
		this.amountPercent = amountPercent;
	}
	/**
	 * Gets the availability of the policy
	 * 
	 * @return Integer
	 */
	
	public int getAvailable() {
		return this.available;
	}
	
	/**
	 * Sets the availability of the policy
	 * 
	 * @param Integer
	 */
	public void setAvailable(int available) {
		this.available = available;
	}
	
	/**
	 * Returns a list of policies
	 * 
	 * @param String - Column name as the filter parameter
	 * @param String - Value
	 * 
	 * @return Array[policy.Policy]
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static Policy[] list(String column,String value) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		String cnt_query = "";
		String query = "";
		if(column.equals("")){
			query = "SELECT * FROM " + t_name;
			cnt_query = "SELECT COUNT(*) FROM " + t_name;
			
		}
		else {
			query = "SELECT * FROM " + t_name + " WHERE " + column + " = '" + value + "'";
			cnt_query = "SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'";
		}
		
		ResultSet rs = db.executeQuery(cnt_query);
		rs.next();
		
		Policy[] list = new Policy[rs.getInt(1)];
		
		rs = db.executeQuery(query);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Policy(rs.getInt("POLICYID"));
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
	public boolean save() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		int n = 0;
		if(this.policyid == 0) {
			String values[] = {this.title,this.description,Double.toString(this.amountPercent),Integer.toString(this.available)};
			this.policyid = Integer.parseInt(db.insert(t_name, values, true,true).toString());
			n=1;
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("TITLE",this.title);
			map.put("DESCRIPTION",this.description);
			map.put("AMOUNTPERCENT",Double.toString(this.amountPercent));
			map.put("AVAILABLE",Integer.toString(this.available));
			
			n = db.update(t_name, map, "POLICYID", Integer.toString(this.policyid));
		}
		db.disconnect();
		
		if(n > 0) return true;
		else return false;
	}
	
	/**
	 * Deletes the policy
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		db.delete("VOUCHERTYPE_POLICY", "POLICYID",Integer.toString(this.policyid));
		db.delete("POLICY", "POLICYID", Integer.toString(this.policyid));
		
		db.disconnect();
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
		
		obj.put("policyid",this.policyid);
		obj.put("title", this.title);
		obj.put("description",this.description);
		obj.put("amount", this.amountPercent);
		obj.put("available",this.available);
		
		return obj;
	}

}
