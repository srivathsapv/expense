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
 * Bookmarks are easy to access links that appear on the user's dashboard
 */

public class Bookmark {
	
	/**
	 * Name of the table to which the class is mapped to
	 * 
	 * @var String
	 */
	private static String t_name = "BOOKMARK";
	
	/**
	 * Unique identity of the bookmark
	 * 
	 * @var Integer
	 */
	private int id = 0;
	
	/**
	 * Id of the user who has saved the bookmark
	 * 
	 * @var String
	 */
	private String userid;
	
	/**
	 * Title of the bookmark
	 * 
	 * @var String
	 */
	private String title;
	
	/**
	 * Hyperlink of the bookmark
	 * 
	 * @var String
	 */
	private String link;
	
	/**
	 * Constructs an empty object
	 */
	public Bookmark() {}
	
	/**
	 * Fetches necessary data and initializes the variables
	 * 
	 * @param Integer
	 * Id of the bookmark to be fetched (Optional)
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public Bookmark(int id) throws ClassNotFoundException, SQLException {
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE ID = " + id);
		rs.next();
		
		this.id = id;
		this.userid = rs.getString("USERID");
		this.title = rs.getString("TITLE");
		this.link = rs.getString("LINK");
		
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
	 * Gets the id of the user who has created this bookmark
	 * 
	 * @return Integer
	 */
	public String getUserid() {
		return this.userid;
	}
	
	/**
	 * Sets the id of the user who has created this bookmark
	 * 
	 * @param Integer
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	/**
	 * Gets the title of the bookmark
	 * 
	 * @return String
	 */
	public String getTitle() {
		return this.title;
	}
	
	/**
	 * Sets the title of the bookmark
	 * 
	 * @param String
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * Gets the link of the bookmark
	 * 
	 * @return String
	 */
	public String getLink() {
		return this.link;
	}
	
	/**
	 * Sets the link of the bookmark
	 * 
	 * @param String
	 */
	public void setLink(String link) {
		this.link = link;
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
			String values[] = {this.userid,this.title,this.link};
			this.id = Integer.parseInt(db.insert(t_name, values, true,true).toString());
			n=1;
		}
		else {
			HashMap<String,String> map = new HashMap<String,String>();
			
			map.put("USERID",this.userid);
			map.put("TITLE",this.title);
			map.put("LINK",this.link);
			
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
	public static Bookmark[] list(String column,String value) throws ClassNotFoundException, SQLException {
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
		
		Bookmark[] list = new Bookmark[rs.getInt(1)];
		
		rs = db.executeQuery(query);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Bookmark(rs.getInt("ID"));
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
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM " + t_name + " WHERE " + column + " = '" + value + "'");
		rs.next();
		
		return rs.getInt(1);
	}
	
	/**
	 * Deletes the voucher
	 * 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public void delete() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		
		db.delete("BOOKMARK", "ID", Integer.toString(this.id));
				
		db.disconnect();
	}
}
