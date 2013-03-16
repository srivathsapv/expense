/**
 * Package that contains classes related to voucher
 */
package voucher;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import user.Department;

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
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE VTYPEID = " + vtypeid);
		rs.next();
		
		this.vtypeid = vtypeid;
		this.setTitle(rs.getString("TITLE"));
		this.setDescription(rs.getString("DESCRIPTION"));
		
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
		
		Type[] list = new Type[rs.getInt(1)];
		
		rs = db.executeQuery(query);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Type(rs.getInt("VTYPEID"));
		}
		
		return list;
	}
	
	/**
	 * Deletes the voucher type
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		db.delete("VOUCHERTYPE_DEPT","VTYPEID",Integer.toString(this.vtypeid));
		db.delete("VOUCHERTYPE_POLICY","VTYPEID",Integer.toString(this.vtypeid));
		
		db.delete("VOUCHER_TYPE","VTYPEID",Integer.toString(this.vtypeid));
		db.disconnect();	
	}
	
	/**
	 * Converts the object to json object
	 * 
	 * @return org.json.JSONObject
	 * 
	 * @throws JSONException 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public JSONObject toJSON() throws JSONException, ClassNotFoundException, SQLException {
		JSONObject obj = new JSONObject();
		
		obj.put("vtypeid",this.vtypeid);
		obj.put("title", this.title);
		obj.put("description",this.description);
		
		voucher.vouchertype.Department[] vtypedepts = voucher.vouchertype.Department.list("VTYPEID", Integer.toString(this.vtypeid));
		int deptids[] = new int[vtypedepts.length];
		int i=0;
		for(voucher.vouchertype.Department d:vtypedepts){
			deptids[i++] = d.getDeptid();
		}
		
		voucher.vouchertype.Policy[] vtypepolicy = voucher.vouchertype.Policy.list("VTYPEID", Integer.toString(this.vtypeid));
		int policyids[] = new int[vtypepolicy.length];
		i=0;
		for(voucher.vouchertype.Policy p:vtypepolicy){
			policyids[i++] = p.getPolicyid();
		}
		
		obj.put("deptids", deptids);
		obj.put("policyids", policyids);
		
		return obj;
	}
}
