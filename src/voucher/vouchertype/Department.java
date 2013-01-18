* Package that contains classes related to voucher type
 **/
 package  vouchertype;




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

public class Department {
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "VOUCHERTYPE_DEPT";
	/**
	 * Unique identity of the vouchertype_Department.
	 * 
	 * @var Integer
	 */
	private int id;
	
	/**
	 * Unique identity  of the department.
	 * 
	 * @var Integer
	 */
	private int deptid;
	/**
	 * Unique identity  of the voucher type.
	 * 
	 * @var Integer
	 */
	
	private int vtypeid;

	
	/**
	 * Creates an empty object
	 */
	public Department(){}

	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the policy to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
public Department(int id)throws ClassNotFoundException,SQLException{
	Db db = new Db();
	db.connect();
	
	ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE id = " + id);
	rs.next();
	
	this.id = id;
	this.deptid = rs.getInt("deptid");
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
 * Gets the id of the department
 * 
 * @return Integer
 */
public int getDeptid() {
	return this.deptid;
}


}
