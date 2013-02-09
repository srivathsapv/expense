/**
 * Package that contains classes related to database functions
 */
package db;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JOptionPane;
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
	 * Executes the given query and returns the result set
	 * 
	 * @param String
	 * The query string
	 * 
	 * @return java.sql.ResultSet
	 * The result set containing the required data
	 * 
	 * @throws SQLException 
	 */
	public ResultSet executeQuery(String query) throws SQLException{
		PreparedStatement Stmt=con.prepareStatement(query); 
		Stmt.executeQuery(); 
		ResultSet rs=Stmt.getResultSet();
		return rs;
	}
	
	/**
	 * Execute the given DML statement and returns the number of rows affected
	 * 
	 * @param String
	 * The query string
	 * 
	 * @return Integer
	 * The number of rows affected
	 * 
	 * @throws SQLException 
	 */
	public int executeUpdate(String query) throws SQLException {
		PreparedStatement Stmt=con.prepareStatement(query); 
		int n = Stmt.executeUpdate();
		return n;
	}
}


