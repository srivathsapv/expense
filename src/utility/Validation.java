/**
 * Package that contains general utility classes
 */
package utility;
import org.apache.commons.validator.routines.EmailValidator;
/**
 * @author	Srivathsa PV
 * @email	pv.srivathsa@gmail.com
 * @date	16/01/2013
 * 
 * Validation class provides functions to check the validity of the data entered by the user
 */
public class Validation {

	/**
	 * Checks if the string is all numeric or not
	 * 
	 * @return Boolean
	 */
	public static boolean isNumeric(String input) {
		return input.matches("[0-9]+");
	}
	
	/**
	 * Checks if the string is all decimal or not
	 * 
	 * @return Boolean
	 */
	public static boolean isDecimal(String input) {
		return input.matches("[0-9]+(.[0-9][0-9]?)?");
	}
	
	/**
	 * Checks if the string contains only alphabets
	 * 
	 * @param String
	 * @param Integer - With/Without space
	 * 
	 * @return Boolean
	 */
	public static boolean isAlpha(String input,int space) {
		if(space == 0)
			return input.matches("([a-zA-Z])+");
		else 
			return input.matches("(([a-zA-Z])+(\\s)?)+");
	}
	
	/**
	 * Checks if the string is alphanumeric
	 * 
	 * @param String
	 * @param Integer - With/Without space
	 * 
	 * @return Boolean
	 */
	public static boolean isAlphaNumeric(String input,int space) {
		if(space == 0) 
			return input.matches("([a-zA-Z0-9])+");
		else
			return input.matches("(([a-zA-Z0-9])+(\\s)?)+");
	}
	
	/**
	 * Checks if the string is a valid email id
	 * 
	 * @param String
	 * 
	 * @return Boolean
	 */
	public static boolean isEmail(String input) {
        return EmailValidator.getInstance().isValid(input);
    }
	
	/**
	 * Checks if the string contains any of the special character like & $ * # @
	 * 
	 * @param String
	 * 
	 * @return Boolean
	 */
	public static boolean isSpecialCharacters(String input) {
        return input.matches("(.*[&$*>#@%^;</].*)+");
    }
	
	/**
	 * Checks if the given string is a date
	 * 
	 * @param Integer - Day of the date
	 * @param Integer - Month of the date
	 * @param Integer - Year of the date
	 * 
	 * @return Boolean
	 */
	public static boolean isDate(int day,int month,int year) {
        switch(month){
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                if(day > 31) return false;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                if(day > 30) return false;
                break;
            case 2:
                if(year % 4 == 0 && day > 29) return false;
                else if(day > 28) return false;
                break;
        }
        return true;
    }
}
