package backupandrestore;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	
	public boolean onlineBackup() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		String timestamp1 = this.lastBackupDate();
		db.connect();
		db.executeQuery("CALL SYSPROC.ADMIN_CMD('backup database "+LocalValues.dbName+" ONLINE to /home/"+LocalValues.dbUsername+"/backup/OnlineBackups COMPRESS INCLUDE LOGS')");
		db.disconnect();
		String timestamp2 = this.lastBackupDate();
		if(!timestamp1.equals(timestamp2)){
			return true;
		}else{
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
		Db db = new Db();
		db.connect();
		Connection con = db.getConnection();
		String sql = "CALL SYSPROC.ADMIN_CMD(?)";
		CallableStatement callStmt = con.prepareCall(sql);	
		String param = "restore database from /home/db2inst1/backup/OnlineBackups TAKEN AT 20130816133748 logtarget /home/db2inst1/backup/logs WITHOUT PROMPTING";
		callStmt.setString(1, param);
		callStmt.execute();	
		db.disconnect();
		return true;
	}
	
	/**
	 * Returns the Date, when the last backup was taken.
	 * 
	 * @return String 
	 * @throws SQLException 		
	 * @throws ClassNotFoundException 
	 */
	public String lastBackupDate() throws ClassNotFoundException, SQLException{
		Db db = new Db();
		db.connect();
		
		ResultSet rs = db.executeQuery("select SQLM_ELM_LAST_BACKUP from table(SNAPSHOT_DATABASE('"+LocalValues.dbName+"', -1)) as ref");
		rs.next();
		
		String timestamp = rs.getString("SQLM_ELM_LAST_BACKUP");
		db.disconnect();
		return timestamp.substring(0, 19);
	}
}