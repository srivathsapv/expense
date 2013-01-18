/**
 * Package that contains classes related to voucher type
 **/
 package  voucher.vouchertype;




import java.sql.ResultSet;
import java.sql.SQLException;


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
	private static String t_name = "VOUCHERTYPE_POLICY";
	/**
	 * Unique identity of the vouchertype_Policy.
	 * 
	 * @var Integer
	 */
	private int id;
	
	/**
	 * Unique identity  of the policy.
	 * 
	 * @var Integer
	 */
	private int policyid;
	/**
	 * Unique identity  of the voucher type.
	 * 
	 * @var Integer
	 */
	
	private int vtypeid;

	
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
public Policy(int id)throws ClassNotFoundException,SQLException{
	Db db = new Db();
	db.connect();
	
	ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE id = " + id);
	rs.next();
	
	this.id = id;
	this.policyid = rs.getInt("policyid");
	this.vtypeid=rs.getInt("vtypeid");
	
	db.disconnect();
}

/**
 * Gets the id of the vouchertype_policy
 * 
 * @return Integer
 */
public int getId() {
	return this.id;
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
 * Gets the id of the policy
 * 
 * @return Integer
 */
public int getPolicyid() {
	return this.policyid;
}


}
