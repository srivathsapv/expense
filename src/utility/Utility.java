package utility;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

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
        
        return hashedinput;
	}
}
