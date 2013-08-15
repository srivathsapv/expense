package backupandrestore;

import java.sql.ResultSet;
import java.sql.SQLException;

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
	 * takes offline backup of the database
	 * 
	 * @return boolean 
	 * true - database backed up successfully
	 * false - error while taking backup of database
	 */
	
	public boolean backup(){
		
		return true;
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
		db.connect();
		ResultSet rs = db.executeQuery("CALL SYSPROC.ADMIN_CMD('backup database employee ONLINE to /home/db2inst1/backup/OnlineBackups COMPRESS INCLUDE LOGS')");
		db.disconnect();
		return true;
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
	 */
	public boolean restore(String timestamp){
		
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
		
		ResultSet rs = db.executeQuery("select SQLM_ELM_LAST_BACKUP from table(SNAPSHOT_DATABASE('employee', -1)) as ref");
		rs.next();
		
		String timestamp = rs.getString("SQLM_ELM_LAST_BACKUP");
		db.disconnect();
		return timestamp;
	}
}