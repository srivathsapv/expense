package backupandrestore;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import db.Db;

/**
 * 
 * @author Sasi Praveen
 * @email sasipraveen39@gmail.com
 * @date 10/08/2013
 * 
 * BackupAndRestore is class that is used to backup and restore the database.
 */

public class BackupAndRestore{
	
	
	private String dbUsername;
	
	private String dbName;
	
	private String dbPwd;
	
	private String FILEPATH = "/home/sasipraveen/backup/";
	
	private String LOBPATH = "/home/sasipraveen/backup";
	
	private String zipDir = "/home/sasipraveen/Desktop/";
	
	
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
		String path = this.getClass().getProtectionDomain().getCodeSource().getLocation().getPath();
		if(path.indexOf("BackupAndRestore.class") >= 0) {
			path = path.replace("BackupAndRestore.class","");
			path += "/../../../temp/";
		}
		else {
			path += "/temp/";
		}
		BufferedReader br = new BufferedReader(new FileReader(path + "dbconfig.cfg"));
		String str = "";

		while((str = br.readLine() ) != null) {
			String[] dat = str.split(":");
			if(dat[0].equals("database")) {
				this.dbName = dat[1];
			}
			else if(dat[0].equals("username")){
				this.dbUsername = dat[1];
			}
			else if(dat[0].equals("password")){
				this.dbPwd = dat[1];
			}
		}
		
		/*Runtime rt = Runtime.getRuntime();
		Process child1  = rt.exec("mkdir /home/"+this.dbUsername+"/backup");
		child1.waitFor();
		Process child2  = rt.exec("mkdir /home/"+this.dbUsername+"/backup/OnlineBackups");
		child2.waitFor();
		Process child3  = rt.exec("mkdir /home/"+this.dbUsername+"/backup/logs");
		child3.waitFor();
		Process child4  = rt.exec("mkdir /home/"+this.dbUsername+"/backup/ArchiveDest");
		child4.waitFor();
		Process child5  = rt.exec("chown "+this.dbUsername+":db2iadm1 /home/"+this.dbUsername+"/backup/OnlineBackups");
		child5.waitFor();
		Process child6  = rt.exec("chown "+this.dbUsername+":db2iadm1 /home/"+this.dbUsername+"/backup/ArchiveDest");
		child6.waitFor();
		Process child7  = rt.exec("chown "+this.dbUsername+":db2iadm1 /home/"+this.dbUsername+"/backup/logs");
		child7.waitFor();*/
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
		try{
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
    	Calendar cal = Calendar.getInstance();
    	String timestamp = dateFormat.format(cal.getTime()).toString();
    	PrintWriter logwriter = new PrintWriter(FILEPATH+"backup_log", "UTF-8");
    	logwriter.println(timestamp);
    	logwriter.close();
    	
		Db db = new Db();
		db.connect();
		Connection con = db.getConnection();
		String sql = "CALL SYSPROC.ADMIN_CMD(?)";
		CallableStatement callStmt = con.prepareCall(sql);
		
		String param = "export to "+FILEPATH+"AMOUNT_CONFIG.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select LOWER_LIMIT,UPPER_LIMIT,MAXCOUNT from AMOUNT_CONFIG";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"BOOKMARK.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select USERID,TITLE,LINK from BOOKMARK";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"DEPARTMENT.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select DEPTNAME,SHORTNAME,DESCRIPTION,USERID from DEPARTMENT";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"LOGIN.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select USERID,PASSWORD,ROLE,LASTLOGIN,SECUREID from LOGIN";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"NOTIFICATION.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select USERID,CATEGORY,CATEGORYID,TIMEUPDATE from NOTIFICATION";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"POLICY.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select TITLE,DESCRIPTION,AMOUNTPERCENT,AVAILABLE from POLICY";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"REPORT.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select TITLE,DESCRIPTION,TYPE,DATE,USERID,FILE from REPORT";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"ROLECONFIG.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select ROLE,CLAIM_LIMIT,ACCEPT_LIMIT from ROLECONFIG";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"USER.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select USERID,SOCIALSECURITY,FIRSTNAME,MIDDLENAME,LASTNAME,GENDER,DEPTID,MANAGER," +
				"DESIGNATION,ADDRESS,PHONE,MOBILE,EMAIL,PHOTO,DOB from USER";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"VOUCHER.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select USERID,TITLE,AMOUNT,VTYPEID,DATE,DESCRIPTION,ATTACHMENT,EXTENSION,REJECTREASON,POLICYID from VOUCHER";
		callStmt.setString(1, param);
		callStmt.execute();
        
		param = "export to "+FILEPATH+"VOUCHER_STATUS.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select VOUCHERID,STATUS,USERID,TIME from VOUCHER_STATUS";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"VOUCHER_TYPE.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select TITLE,DESCRIPTION from VOUCHER_TYPE";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"VOUCHERTYPE_DEPT.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select VTYPEID,DEPTID from VOUCHERTYPE_DEPT";
		callStmt.setString(1, param);
		callStmt.execute();
		
		param = "export to "+FILEPATH+"VOUCHERTYPE_POLICY.ixf of ixf" +
				" lobs to "+LOBPATH+" modified by lobsinfile messages on server " +
				"select VTYPEID,POLICYID from VOUCHERTYPE_POLICY";
		callStmt.setString(1, param);
		callStmt.execute();
		
		this.compressFiles(zipDir+"backup-"+timestamp+".zip" , LOBPATH);

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
	 * 
	 */
	public boolean restore(String timestamp){
		try {
			/*
			String t = this.lastBackupDate();
			final String NEW_FORMAT = "yyyyMMddHHmmss";
	    	final String OLD_FORMAT = "dd/MM/yyyy HH:mm:ss";
	    	SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
			Date d = sdf.parse(t);
			sdf.applyPattern(NEW_FORMAT);
			String time = sdf.format(d); 
			*/
			
			if(!this.decompressFiles(zipDir+"backup-20130818202252.zip", LOBPATH)){
				return false;
			}
			
            Db db = new Db();
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
			stmt = con.prepareStatement("DELETE FROM VOUCHER");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHER_STATUS");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHER_TYPE");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHERTYPE_DEPT");
			stmt.executeUpdate();
			stmt = con.prepareStatement("DELETE FROM VOUCHERTYPE_POLICY");
			stmt.executeUpdate();
			stmt = con.prepareStatement("ALTER TABLE DEPARTMENT ALTER COLUMN DEPTID RESTART WITH 1");
			stmt.executeUpdate();
			stmt = con.prepareStatement("ALTER TABLE POLICY ALTER COLUMN POLICYID RESTART WITH 1");
			stmt.executeUpdate();
			stmt = con.prepareStatement("ALTER TABLE VOUCHER ALTER COLUMN VOUCHERID RESTART WITH 1");
			stmt.executeUpdate();
			stmt = con.prepareStatement("ALTER TABLE VOUCHER_TYPE ALTER COLUMN VTYPEID RESTART WITH 1");
			stmt.executeUpdate();
			
			String sql = "CALL SYSPROC.ADMIN_CMD(?)";
			CallableStatement callStmt = con.prepareCall(sql);
			
			String param = "import from "+FILEPATH+"AMOUNT_CONFIG.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into AMOUNT_CONFIG (LOWER_LIMIT,UPPER_LIMIT,MAXCOUNT)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"BOOKMARK.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into BOOKMARK (USERID,TITLE,LINK)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"DEPARTMENT.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into DEPARTMENT (DEPTNAME,SHORTNAME,DESCRIPTION,USERID)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"LOGIN.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into LOGIN (USERID,PASSWORD,ROLE,LASTLOGIN,SECUREID)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"NOTIFICATION.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into NOTIFICATION (USERID,CATEGORY,CATEGORYID,TIMEUPDATE)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"POLICY.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into POLICY (TITLE,DESCRIPTION,AMOUNTPERCENT,AVAILABLE)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"REPORT.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into REPORT (TITLE,DESCRIPTION,TYPE,DATE,USERID,FILE)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"ROLECONFIG.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into ROLECONFIG (ROLE,CLAIM_LIMIT,ACCEPT_LIMIT)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"USER.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into USER (USERID,SOCIALSECURITY,FIRSTNAME,MIDDLENAME" +
					",LASTNAME,GENDER,DEPTID,MANAGER,DESIGNATION,ADDRESS,PHONE,MOBILE,EMAIL,PHOTO,DOB)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"VOUCHER.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into VOUCHER (USERID,TITLE,AMOUNT,VTYPEID,DATE,DESCRIPTION,ATTACHMENT,EXTENSION,REJECTREASON,POLICYID)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"VOUCHER_STATUS.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into VOUCHER_STATUS (VOUCHERID,STATUS,USERID,TIME)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"VOUCHER_TYPE.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into VOUCHER_TYPE (TITLE,DESCRIPTION)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"VOUCHERTYPE_DEPT.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into VOUCHERTYPE_DEPT (VTYPEID,DEPTID)";
			callStmt.setString(1, param);
			callStmt.execute();
			
			param = "import from "+FILEPATH+"VOUCHERTYPE_POLICY.ixf of ixf " +
					"lobs from "+LOBPATH+" messages on server	" +
					" insert into VOUCHERTYPE_POLICY (VTYPEID,POLICYID)";
			callStmt.setString(1, param);
			callStmt.execute();
			
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
		final String OLD_FORMAT = "yyyyMMddHHmmss";
    	final String NEW_FORMAT = "dd/MM/yyyy HH:mm:ss";
    	String oldDateString="";
    	String newDateString="";
    	File f = new File(FILEPATH+"backup_log");
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
	
	/**
	 * To compress the files within the sourceDirectory to a single zip file
	 * @param zipFile
	 * @param sourceDirectory
	 * @return boolean
	 */
	private boolean compressFiles(String zipFile, String sourceDirectory){
		try
        {
                byte[] buffer = new byte[1024];
                
                FileOutputStream fout = new FileOutputStream(zipFile);
                 
                 ZipOutputStream zout = new ZipOutputStream(fout);
                
                 File dir = new File(sourceDirectory);
                 
                 if(!dir.isDirectory())
                 {
                        return false;
                 }
                 else
                 {
                        File[] files = dir.listFiles();
                       
                        for(int i=0; i < files.length ; i++)
                        {
                            
                                FileInputStream fin = new FileInputStream(files[i]);
                                zout.putNextEntry(new ZipEntry(files[i].getName()));
                                int length;
                 
                                while((length = fin.read(buffer)) > 0)
                                {
                                   zout.write(buffer, 0, length);
                                }
                                 zout.closeEntry();
                
                                 fin.close();
                        }
                 }
        
                  zout.close();
                  return true;
        }
        catch(IOException ioe)
        {
                return false;
        }
	}
	
	/**
	 * To decompress zip file 
	 * @param zipFile
	 * @param outputFolder
	 * @return	boolean
	 */
	private boolean decompressFiles(String zipFile, String outputFolder){
		 
	     byte[] buffer = new byte[1024];
	 
	     try{
	 
	    	File folder = new File(outputFolder);
	    	if(!folder.exists()){
	    		folder.mkdir();
	    	}
	 
	    	ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile));
	    	
	    	ZipEntry ze = zis.getNextEntry();
	 
	    	while(ze!=null){
	 
	    	   String fileName = ze.getName();
	           File newFile = new File(outputFolder + File.separator + fileName);
	 
	            new File(newFile.getParent()).mkdirs();
	 
	            FileOutputStream fos = new FileOutputStream(newFile);             
	 
	            int len;
	            while ((len = zis.read(buffer)) > 0) {
	       		fos.write(buffer, 0, len);
	            }
	 
	            fos.close();   
	            ze = zis.getNextEntry();
	    	}
	 
	        zis.closeEntry();
	    	zis.close();
	 
	    	return true;
	 
	    }catch(IOException ex){
	       ex.printStackTrace();
	       return false;
	    }
	   }
}