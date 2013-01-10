/**
 * Package that contains classes related to user
 */
package user;

import java.sql.ResultSet;
import java.sql.SQLException;

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
	private int id;
	
	/**
	 * Id of the user who has saved the bookmark
	 * 
	 * @var Integer
	 */
	private int userid;
	
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
	 * Creates an empty object
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
		
		ResultSet rs = db.executeQuery("SELECT * FROM " + t_name + " WHERE id = " + id);
		rs.next();
		
		this.id = id;
		this.userid = rs.getInt("userid");
		this.title = rs.getString("title");
		this.link = rs.getString("link");
		
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
	public int getUserid() {
		return this.userid;
	}
	
	/**
	 * Sets the id of the user who has created this bookmark
	 * 
	 * @param Integer
	 */
	public void setUserid(int userid) {
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
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM BOOKMARK WHERE " + column + " = '" + value);
		rs.next();
		
		Bookmark[] list = new Bookmark[rs.getInt(1)];
		
		rs = db.executeQuery("SELECT * FROM BOOKMARK WHERE " + column + " = '" + value);
		
		int i=0;
		while(rs.next()) {
			list[i++] = new Bookmark(rs.getInt("id"));
		}
		
		return list;
	}
	
	/**
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
		
		ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM BOOKMARK WHERE " + column + " = '" + value);
		rs.next();
		
		return rs.getInt(1);
	}
}
