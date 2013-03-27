package sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * 
 * @author Sasi Praveen
 * @email sasipraveen39@mail.com
 * @date 27/03/2013
 * 
 * Email is class that is used to send SMS through android mobile
 */


public class SMS {
	
	/**
	 * Number of the recipient
	 * 
	 * @var String 
	 */
	private String number="";
	
	/**
	 * Message to be sent
	 * 
	 * @var String 
	 */
	private String message="";
	
	/**
	 * Path to adb file
	 * 
	 * @var String 
	 */
	private String adb_path="";
	
	/**
	 * get the path to adb file
	 * 
	 * @return String
	 */
	public String getAdb_path() {
		return adb_path;
	}
		
	/**
	 * set the path to adb file
	 * 
	 * @param String
	 */
	public void setAdb_path(String adb_path) {
		this.adb_path = adb_path;
	}

	/**
	 * get the number of the recipient
	 * 
	 * @return String
	 */
	public String getNumber() {
		return number;
	}
	
	/**
	 * set the number of the recipient
	 * 
	 * @param String
	 */
	public void setNumber(String number) {
		this.number = number;
	}
	
	
	/**
	 *get the message to be sent
	 * 
	 * @return String
	 */
	public String getMessage() {
		return message;
	}
	
	/**
	 * set the message to be sent
	 * 
	 * @param String
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * sends the message
	 * 
	 * @return int
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public int send() throws IOException, InterruptedException{
		Runtime shell = Runtime.getRuntime();
		Process p = shell.exec(adb_path+"./adb shell dumpsys power");
		p.waitFor();

		BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line = "";
		String temp = "";
		while ((line = reader.readLine()) != null) {
			temp = temp + line;
		}
		int powerstate = 0;
		if(temp.equals("")){
			return -1;
		}else{
			int pos = temp.indexOf("mPowerState")+12;
			powerstate = Integer.parseInt(temp.substring(pos,pos+1));

		System.out.println(powerstate);
		if(powerstate == 0){
		p = shell.exec(adb_path+"./adb shell input keyevent 3");
		p.waitFor();	
		} 

		p = shell.exec(adb_path+"./adb shell am start -a android.intent.action.SENDTO -d sms:"+number+" --es sms_body \""+message+"\" --ez exit_on_sent true");
		p.waitFor();


		reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		line = "";
		temp = "";
		while ((line = reader.readLine()) != null) {
			temp = temp + line;
		}
		if(temp.indexOf("error")>0){
			System.out.println("error");
		}else{
			System.out.println(temp);
		}

		p = shell.exec(adb_path+"./adb shell input keyevent 22");
		p.waitFor();

		p = shell.exec(adb_path+"./adb shell input keyevent 66");
		p.waitFor();

		Thread.sleep(10000);

		p = shell.exec(adb_path+"./adb shell input keyevent 66");
		p.waitFor();

		p = shell.exec(adb_path+"./adb shell input keyevent 3");
		p.waitFor();
					
		p = shell.exec(adb_path+"./adb shell input keyevent 6");
		p.waitFor();
		return 1;
		}
	}
}
