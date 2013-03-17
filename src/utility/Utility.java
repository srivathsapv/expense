package utility;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.jsoup.*;

public class Utility {
	
	/**
	 * Hashes a given string MD5 and returns the hashed value
	 * 
	 * @param String
	 * 
	 * @return String
	 * 
	 * @throws NoSuchAlgorithmException
	 */
	public static String MD5(String input) throws NoSuchAlgorithmException {
		MessageDigest MD5 = MessageDigest.getInstance("MD5");
        MD5.update(input.getBytes());
        BigInteger output = new BigInteger(1, MD5.digest());
        
        String hashedinput = output.toString(16);
        String outp = hashedinput;
        
        while(outp.length() < 32) {
        	outp = "0" + outp;
        }
        
        return outp;
	}
	
	/**
	 * Filters the given input string by removing tags and slashes
	 * 
	 * @param String
	 * 
	 * @return String
	 */
	public static String filter(String input) {

		// Use jsoup to remove all html tags
		input = Jsoup.parse(input).text();
		
		//remove slashes
		input = input.replaceAll("\\/","");
		
		return input;
		
	}
	
	public static String stringJoin(String values[],String connector) {
		String str = "";
		
		for(int i=0;i<values.length;i++){
			str = str + values[i] + connector;
		}
		str = str.substring(0,str.length()-connector.length());
		
		return str;
	}
}
