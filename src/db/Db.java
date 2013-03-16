/**
 * Package that contains classes related to database functions
 */
package db;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import utility.LocalValues;

/**
 * @author	Srivathsa PV
 * @email	pv.srivathsa@gmail.com
 * @date	10/01/2013
 * 
 * Db is a class that provides basic database functionalities
 */

public class Db {

	/**
	 * Username of the database
	 * 
	 * @var String
	 */
	private String username;
	
	/**
	 * Password to access the database
	 * 
	 * @var String
	 */
	private String password;
	
	/**
	 * Name of the database to connect
	 * 
	 * @var String
	 */
	private String database;
	
	/**
	 * Connection using which the database is connected
	 * 
	 * @var java.sql.Connection
	 */
	private Connection con;
	
	/**
	 * Accesses the dbconfig.cfg file ,reads the values and initialized it to the respective variables
	 */
	public Db() {
		this.username = LocalValues.dbUsername;
		this.password = LocalValues.dbPwd;
		this.database = LocalValues.dbName;
	}
	
	/**
	 * Establishes a connection to the database
	 * 
	 * @throws ClassNotFoundException 
	 * @throws SQLException 
	 */
	public void connect() throws ClassNotFoundException, SQLException {
		Class.forName("com.ibm.db2.jcc.DB2Driver");
		con=DriverManager.getConnection("jdbc:db2://localhost:50000/"+this.database,this.username,this.password);
	}
	
	/**
	 * Disconnects the connection
	 * 
	 * @throws SQLException 
	 */
	public void disconnect() throws SQLException {
		con.close();
	}
	
	/**
	 * Selects and returns a result set based on the given conditions.
	 * To be used when the WHERE clause values contain values entered by the user.
	 * 
	 * @param String
	 * The table name
	 * 
	 * @param String[]
	 * The set of columns that needs to be selected
	 * 
	 * @param String[]
	 * The set of WHERE clause conditions
	 * 
	 * @param String[]
	 * The set of WHERE clause values
	 * 
	 * @param String[]
	 * The set of logical connectors like AND , OR etc
	 * 
	 * @return java.sql.ResultSet
	 * 
	 * @throws java.sql.SQLException
	 */
	public ResultSet select(String table,String selectcols,String[] whereCols,String[] whereVals,String logicalConnectors[]) throws SQLException {
		String query = "SELECT " + selectcols + " FROM " + table;
		
		PreparedStatement stmt;
		
		if(whereCols.length > 0) {
			query += " WHERE ";
			for(int i=0;i<whereCols.length;i++){
				if(i != 0)
					query += " " + logicalConnectors[i] + " ";
				
				query += whereCols[i] + " = ?"; 
			}
		}
		
		stmt = con.prepareStatement(query);
		
		
		if(whereVals.length > 0) {
			for(int i=0;i<whereVals.length;i++)
				stmt.setString(i+1, whereVals[i]);	
		}
			
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	
	
	/**
	 * Inserts a row in the database
	 * 
	 * @param String
	 * The table name
	 * 
	 * @param String[]
	 * Array of values
	 * 
	 * @param Boolean
	 * Whether default value to be inserted in primary key column
	 * 
	 * @param Boolean
	 * Whether the newly inserted row's generated key has to be returned or not
	 * 
	 * @return Integer
	 * Number of rows affected/generated key
	 * 
	 * @throws SQLException 
	 */
	public Object insert(String table,String values[],boolean default_value,boolean generate_keys) throws SQLException {
		String query = "";
		
		query = "INSERT INTO " + table + " VALUES(";
		
		if(default_value)
			query += "DEFAULT,";
		
		for(int i=0;i<values.length;i++){
			query += "?,";
		}
		
		query = query.substring(0,query.length()-1);
		query += ")";
		PreparedStatement stmt;
		if(generate_keys)
			stmt=con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
		else 
			stmt=con.prepareStatement(query);
		
		for(int i=0;i<values.length;i++){
			stmt.setString(i+1,values[i]);
		}
		int n = stmt.executeUpdate();
		
		if(generate_keys){
			ResultSet rs = stmt.getGeneratedKeys();
			rs.next();
			
			return rs.getString(1);
		}
		else {
			return n;
		}
		
	}
	
	/**
	 * Executes the given string and returns the resultset
	 * To be used when queries contain LIKE , BETWEEN and other clauses , and the values
	 * are either fetched from the database or internally calculated.
	 * 
	 * @param String
	 * The query string
	 * 
	 * @return java.sql.ResultSet
	 * The result set containing the queried data
	 * 
	 * @throws java.sql.SQLException
	 */
	public ResultSet executeQuery(String query) throws SQLException{
		PreparedStatement stmt = con.prepareStatement(query);
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	/**
	 * Updates the given values in the specified table with the where condition
	 * 
	 * @param String
	 * The Table Name
	 * 
	 * @param java.util.HashMap
	 * Map containing (key,value) pairs of (columnName,columnValue)
	 * 
	 * @param String
	 * The column name in the where condition
	 * 
	 * @param String
	 * The column value in the where condition
	 * 
	 * @return Integer
	 * The number of rows affected
	 * 
	 * @throws SQLException
	 */
	public int update(String table,HashMap colValues,String whereColumn,String whereValue) throws SQLException{
		String query = "UPDATE " + table + " SET ";
		
		Set set = colValues.entrySet();
		Iterator iter = set.iterator();
		
		while(iter.hasNext()) {
			Map.Entry cur = (Map.Entry)iter.next();
			
			query += cur.getKey() + " = ?,";
		}
		query = query.substring(0,query.length()-1);
		if(!whereColumn.equals(""))
			query += " WHERE " + whereColumn + " = ?";
		
		iter = set.iterator();
		PreparedStatement stmt = con.prepareStatement(query);
		
		int i=1;
		while(iter.hasNext()){
			Map.Entry cur = (Map.Entry)iter.next();
			stmt.setString(i++, cur.getValue().toString());
		}
		if(!whereValue.equals(""))
			stmt.setString(i++,whereValue);
		
		return stmt.executeUpdate();
		
	}
	
	/**
	 * Create blob data and updates it in the database
	 * 
	 * @param String
	 * The table name
	 * 
	 * @param String
	 * The WHERE clause column name
	 * 
	 * @param String
	 * The WHERE clause column's value
	 * 
	 * @param String
	 * The file path
	 * 
	 * @throws java.sql.SQLException
	 * @throws java.io.FileNotFoundException
	 */
	public int updateBlob(String tableName,String col,String whereCol,String whereVal,String path) throws SQLException{
		
		String query = "UPDATE " + tableName + " SET " + col + "  = ? WHERE " + whereCol + " = '" + whereVal + "'";
		PreparedStatement stmt = con.prepareStatement(query);
		System.out.println(path);
		File file = new File(path);
		int success=0;
		try {
			FileInputStream fis = new FileInputStream(file);
			stmt.setBinaryStream(1,(InputStream)fis,(int)(file.length()));
			success = stmt.executeUpdate();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	public int delete(String tableName,String whereCol,String whereVal) throws SQLException{
		String query = "DELETE FROM " + tableName + " WHERE " + whereCol + " = ?";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1,whereVal);
		
		return stmt.executeUpdate();
		
	}
}


