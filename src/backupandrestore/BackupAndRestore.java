package backupandrestore;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import utility.LocalValues;

import db.Db;

/**
 * 
 * @author Sasi Praveen
 * @email sasipraveen39@mail.com
 * @date 10/08/2013
 * 
 * BackupAndRestore is class that is used to backup and restore the database.
 */

public class BackupAndRestore{
	/**
	 * Intializes db2 database for backup and recovery
	 * 
	 * @throws IOException 
	 * @throws InterruptedException 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 * 
	 */
	
	public void init() throws IOException, InterruptedException, ClassNotFoundException, SQLException{
		Runtime rt = Runtime.getRuntime();
		Process child1  = rt.exec("mkdir /home/"+LocalValues.dbUsername+"/backup");
		child1.waitFor();
		Process child2  = rt.exec("mkdir /home/"+LocalValues.dbUsername+"/backup/OnlineBackups");
		child2.waitFor();
		Process child3  = rt.exec("mkdir /home/"+LocalValues.dbUsername+"/backup/logs");
		child3.waitFor();
		Process child4  = rt.exec("mkdir /home/"+LocalValues.dbUsername+"/backup/ArchiveDest");
		child4.waitFor();
		Process child5  = rt.exec("chown "+LocalValues.dbUsername+":db2iadm1 /home/"+LocalValues.dbUsername+"/backup/OnlineBackups");
		child5.waitFor();
		Process child6  = rt.exec("chown "+LocalValues.dbUsername+":db2iadm1 /home/"+LocalValues.dbUsername+"/backup/ArchiveDest");
		child6.waitFor();
		Process child7  = rt.exec("chown "+LocalValues.dbUsername+":db2iadm1 /home/"+LocalValues.dbUsername+"/backup/logs");
		child7.waitFor();
		
		this.updateCFG();
		this.backup();
		
	}
	/**
	 * To intialize the database to archive logging
	 * 
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private void updateCFG() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		Connection con = db.getConnection();
		String sql = "CALL SYSPROC.ADMIN_CMD(?)";
		CallableStatement callStmt = con.prepareCall(sql);	
		String param = "UPDATE DATABASE CONFIGURATION USING LOGARCHMETH1 DISK:/home/"+LocalValues.dbUsername+"/backup/ArchiveDest";
		callStmt.setString(1, param);
		callStmt.execute();	
		db.disconnect();
	}
	
	/**
	 * To Take offline backup
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private void backup() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		db.executeQuery("CALL SYSPROC.ADMIN_CMD('backup database "+LocalValues.dbName+" to /home/"+LocalValues.dbUsername+"/backup/OnlineBackups')");
		db.disconnect();
	}
	/**
	 * takes online backup of the database
	 * 
	 * @return boolean 
	 * true - database backed up successfully
	 * false - error while taking backup of database
	 * 
	 */
	
	public boolean onlineBackup(){
		/*Db db = new Db();
		String timestamp1 = this.lastBackupDate();
		db.connect();
		db.executeQuery("CALL SYSPROC.ADMIN_CMD('backup database "+LocalValues.dbName+" ONLINE to /home/"+LocalValues.dbUsername+"/backup/OnlineBackups COMPRESS INCLUDE LOGS')");
		db.disconnect();
		String timestamp2 = this.lastBackupDate();
		if(!timestamp1.equals(timestamp2)){
			return true;
		}else{
			return false;
		}*/
		try{
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
    	Calendar cal = Calendar.getInstance();
    	String timestamp = dateFormat.format(cal.getTime()).toString();
    	PrintWriter logwriter = new PrintWriter("/home/sasipraveen/Desktop/backup_log", "UTF-8");
    	logwriter.println(timestamp);
    	logwriter.close();
    	
		PrintWriter writer = new PrintWriter("/home/sasipraveen/Desktop/backup-"+timestamp+".sql", "UTF-8");
		Db db = new Db();
		db.connect();
		ResultSet rs1 = db.executeQuery("SELECT * FROM AMOUNT_CONFIG");
		while(rs1.next()){
			writer.println("INSERT INTO AMOUNT_CONFIG(ID,LOWER_LIMIT,UPPER_LIMIT,MAXCOUNT) VALUES("+rs1.getString("ID")+","+rs1.getString("LOWER_LIMIT")+","+rs1.getString("UPPER_LIMIT")+","+rs1.getString("MAXCOUNT")+");");
		}
		
		ResultSet rs2 = db.executeQuery("SELECT * FROM BOOKMARK");
		while(rs2.next()){
			writer.println("INSERT INTO BOOKMARK(ID,USERID,TITLE,LINK) VALUES("+rs2.getString("ID")+",'"+rs2.getString("USERID")+"','"+rs2.getString("TITLE")+"','"+rs2.getString("LINK")+"');");
		}
		
		ResultSet rs3 = db.executeQuery("SELECT * FROM DEPARTMENT");
		while(rs3.next()){
			writer.println("INSERT INTO DEPARTMENT(DEPTID,DEPTNAME,SHORTNAME,DESCRIPTION,USERID) VALUES("+rs3.getString("DEPTID")+",'"+rs3.getString("DEPTNAME")+"','"+rs3.getString("SHORTNAME")+"','"+rs3.getString("DESCRIPTION")+"','"+rs3.getString("USERID")+"');");
		}
		
		ResultSet rs4 = db.executeQuery("SELECT * FROM LOGIN");
		while(rs4.next()){
			writer.println("INSERT INTO LOGIN(USERID,PASSWORD,ROLE,LASTLOGIN,SECUREID) VALUES('"+rs4.getString("USERID")+"','"+rs4.getString("PASSWORD")+"','"+rs4.getString("ROLE")+"','"+rs4.getString("LASTLOGIN")+"','"+rs4.getString("SECUREID")+"');");
		}
		
		ResultSet rs5 = db.executeQuery("SELECT * FROM NOTIFICATION");
		while(rs5.next()){
			writer.println("INSERT INTO NOTIFICATION(ID,USERID,CATEGORY,CATEGORYID,TIMEUPDATE) VALUES("+rs5.getString("ID")+",'"+rs5.getString("USERID")+"','"+rs5.getString("CATEGORY")+"','"+rs5.getString("CATEGORYID")+"','"+rs5.getString("TIMEUPDATE")+"');");
		}
		
		ResultSet rs6 = db.executeQuery("SELECT * FROM POLICY");
		while(rs6.next()){
			writer.println("INSERT INTO POLICY(POLICYID,TITLE,DESCRIPTION,AMOUNTPERCENT,AVAILABLE) VALUES("+rs6.getString("POLICYID")+",'"+rs6.getString("TITLE")+"','"+rs6.getString("DESCRIPTION")+"','"+rs6.getString("AMOUNTPERCENT")+"','"+rs6.getString("AVAILABLE")+"');");
		}
		
		ResultSet rs7 = db.executeQuery("SELECT * FROM REPORT");
		while(rs7.next()){
			writer.println("INSERT INTO REPORT(REPORTID,TITLE,DESCRIPTION,TYPE,DATE,USERID,FILE) VALUES("+rs7.getString("REPORTID")+",'"+rs7.getString("TITLE")+"','"+rs7.getString("DESCRIPTION")+"','"+rs7.getString("TYPE")+"','"+rs7.getString("DATE")+"','"+rs7.getString("USERID")+"','"+rs7.getString("FILE")+"');");
		}
		
		ResultSet rs8 = db.executeQuery("SELECT * FROM ROLECONFIG");
		while(rs8.next()){
			writer.println("INSERT INTO ROLECONFIG(ID,ROLE,CLAIM_LIMIT,ACCEPT_LIMIT) VALUES("+rs8.getString("ID")+",'"+rs8.getString("ROLE")+"','"+rs8.getString("CLAIM_LIMIT")+"','"+rs8.getString("ACCEPT_LIMIT")+"');");
		}
		
		ResultSet rs = db.executeQuery("SELECT * FROM USER");
    	while(rs.next()){
    		writer.println("INSERT INTO USER(USERID,SOCIALSECURITY,FIRSTNAME,MIDDLENAME,LASTNAME,GENDER,DEPTID,MANAGER,DESIGNATION,ADDRESS,PHONE,MOBILE,EMAIL,PHOTO,DOB) " +
    				"VALUES('"+rs.getString("USERID")+"','"+rs.getString("SOCIALSECURITY")+"','"+rs.getString("FIRSTNAME")+"','"+rs.getString("MIDDLENAME")+"','"+rs.getString("LASTNAME")+"','"+rs.getString("GENDER")+"'," +
    						"'"+rs.getString("DEPTID")+"','"+rs.getString("MANAGER")+"','"+rs.getString("DESIGNATION")+"','"+rs.getString("ADDRESS")+"'," +
    								"'"+rs.getString("PHONE")+"','"+rs.getString("MOBILE")+"','"+rs.getString("EMAIL")+"','"+rs.getString("PHOTO")+"','"+rs.getString("DOB")+"');");
    	}
    	
    	ResultSet rs9 = db.executeQuery("SELECT * FROM VOUCHER");
    	while(rs9.next()){
    		writer.println("INSERT INTO VOUCHER(VOUCHERID,USERID,TITLE,AMOUNT,VTYPEID,DATE,DESCRIPTION,ATTACHMENT,EXTENSION,REJECTREASON,POLICYID)" +
    				" VALUES("+rs9.getString("VOUCHERID")+",'"+rs9.getString("USERID")+"','"+rs9.getString("TITLE")+"','"+rs9.getString("AMOUNT")+"','"+rs9.getString("VTYPEID")+"','"+rs9.getString("DATE")+"','"+rs9.getString("ATTACHMENT")+"','"+rs9.getString("DESCRIPTION")+"','"+rs9.getString("EXTENSION")+"','"+rs9.getString("REJECTREASON")+"','"+rs9.getString("POLICYID")+"');");
    	}
    	
		ResultSet rs10 = db.executeQuery("SELECT * FROM VOUCHER_STATUS");
		while(rs10.next()){
			writer.println("INSERT INTO VOUCHER_STATUS(STATUSID,VOUCHERID,STATUS,USERID,TIME) VALUES("+rs10.getString("STATUSID")+","+rs10.getString("VOUCHERID")+",'"+rs10.getString("STATUS")+"','"+rs10.getString("USERID")+"','"+rs10.getString("TIME")+"');");
		}
		
		ResultSet rs11 = db.executeQuery("SELECT * FROM VOUCHER_TYPE");
		while(rs11.next()){
			writer.println("INSERT INTO VOUCHER_TYPE(VTYPEID,TITLE,DESCRIPTION) VALUES("+rs11.getString("VTYPEID")+",'"+rs11.getString("TITLE")+"','"+rs11.getString("DESCRIPTION")+"');");
		}
		
		ResultSet rs12 = db.executeQuery("SELECT * FROM VOUCHERTYPE_DEPT");
		while(rs12.next()){
			writer.println("INSERT INTO VOUCHERTYPE_DEPT(ID,VTYPEID,DEPTID) VALUES("+rs12.getString("ID")+","+rs12.getString("VTYPEID")+","+rs12.getString("DEPTID")+");");
		}
		
		ResultSet rs13 = db.executeQuery("SELECT * FROM VOUCHERTYPE_POLICY");
		while(rs13.next()){
			writer.println("INSERT INTO VOUCHERTYPE_POLICY(ID,VTYPEID,POLICYID) VALUES("+rs13.getString("ID")+","+rs13.getString("VTYPEID")+","+rs13.getString("POLICYID")+");");
		}
		writer.close();

		return true;
		}catch(Exception e){
			return false;
		}
	}
	
	/**
	 * Restores the database
	 * 
	 * @param String 
	 * timestamp of the backup using which to restore
	 * 
	 * @return boolean 
	 * true - database restored successfully
	 * false - error while restoring database
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	public boolean restore(String timestamp) throws ClassNotFoundException, SQLException, IOException, InterruptedException{
		BufferedReader in = null;
		Db db = null;
		try {
			String t = this.lastBackupDate();
			final String NEW_FORMAT = "yyyyMMddHHmmss";
	    	final String OLD_FORMAT = "dd/MM/yyyy HH:mm:ss";
	    	SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
			Date d = sdf.parse(t);
			sdf.applyPattern(NEW_FORMAT);
			String time = sdf.format(d); 
			
            db = new Db();
			db.connect();
			Connection con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement("DELETE FROM AMOUNT_CONFIG");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM BOOKMARK");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM DEPARTMENT");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM LOGIN");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM NOTIFICATION");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM POLICY");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM REPORT");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM ROLECONFIG");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM USER");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHER_STATUS");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHER_TYPE");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHERTYPE_DEPT");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHERTYPE_POLICY");
			stmt.executeUpdate();
			System.out.println("1");
			
			in = new BufferedReader(new FileReader("/home/sasipraveen/Desktop/backup-"+time+".sql"));
            String str="";
            while ((str = in.readLine()) != null) {
               db.executeQuery(str.substring(0,str.length()-1));
            }
            System.out.println("3");
            in.close();
        	db.disconnect();
        	return true;
        } catch (Exception e) {
            return false;
        }
	}
	
	/**
	 * Returns the Date, when the last backup was taken.
	 * 
	 * @return String 
	 * @throws SQLException 		
	 * @throws ClassNotFoundException 
	 * @throws ParseException 
	 * @throws IOException 
	 */
	public String lastBackupDate() throws ClassNotFoundException, SQLException, ParseException, IOException{
		/*Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("select SQLM_ELM_LAST_BACKUP from table(SNAPSHOT_DATABASE('"+LocalValues.dbName+"', -1)) as ref");
		rs.next();
		
		String timestamp = rs.getString("SQLM_ELM_LAST_BACKUP");
		db.disconnect();*/
		final String OLD_FORMAT = "yyyyMMddHHmmss";
    	final String NEW_FORMAT = "dd/MM/yyyy HH:mm:ss";
    	String oldDateString="";
    	String newDateString="";
    	File f = new File("/home/sasipraveen/Desktop/backup_log");
    	if(f.exists()) {
    		BufferedReader reader = new BufferedReader(new FileReader(f));
    		String line = null;
    		if((line = reader.readLine()) != null) {
    				oldDateString = line;

    				SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
    				Date d = sdf.parse(oldDateString);
    				sdf.applyPattern(NEW_FORMAT);
    				newDateString = sdf.format(d);
    		}
    	}
		return newDateString;
	}
}