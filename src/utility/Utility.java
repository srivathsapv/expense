package utility;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

import org.jsoup.*;

public class Utility {
	
	/**
	 * @var Boolean
	 * 
	 * Indicates whether the restore operation is going on or not
	 */
	public static boolean restoreInProgress=false;
	
	
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
	
	/**
	 * Generates a random string of given length
	 * 
	 * @param Integer
	 * 
	 * @return String
	 */
	public static String randomstr(int length){
		Random rand = new Random();
        String password = "";
        int count = 0;
        ArrayList temp = new ArrayList();
        while (count < length) {
            temp.add((char) (rand.nextInt(90 - 65 + 1) + 65));
            count++;
            temp.add((char) (rand.nextInt(122 - 97 + 1) + 97));
            count++;
            temp.add((char) (rand.nextInt(57 - 48 + 1) + 48));
            count++;
        }
        Collections.shuffle(temp, rand);
        int i = 0;
        while (i < length) {
            password += temp.get(i++);
        }
        return password;
	}
	
	/**
	 * Gets a random money management tip
	 * 
	 * @return String
	 */
	public static String getRandomTip(){
		String[] tips = new String[40];
		
		tips[0] = "Remember: Net worth is not the same as self-worth.";
		tips[1] = "Learn about your options for saving and investing money, including bank savings accounts, money market accounts, mutual funds, stocks, and bonds.";
		tips[2] = "Pay yourself first: Whenever you get a paycheck, deposit part of your earnings into a savings account.";
		tips[3] = "Learn the power of compounding interest.";
		tips[4] = "Get into the savings habit and put your money to work for you earning interest.";
		tips[5] = "Seek help from a financial aid officer or debt counselor if you get into debt trouble.";
		tips[6] = "Take control of your credit card and avoid running up balances.";
		tips[7] = "Limit the number of credit cards in your name. Avoid credit-card pushers, who may offer free gifts or other enticements to sign up for new cards.";
		tips[8] = "Build good credit by paying bills on time and loans as promised.";
		tips[9] = "Create a budget and stick to it.";
		tips[10] = "Plug everyday spending leaks to help stretch your money.";
		tips[11] = "Keep track of your student account.";
		tips[12] = "Don’t let car expenses drive you crazy. Shop around for auto insurance and see if you qualify for a good-grades discount for students. Extend the life of your car by getting routine maintenance done on time. Save on gas by combining errands.";
		tips[13] = "Take advantage of student discounts.";
		tips[14] = "Separate needs from wants and limit spending on non-essentials.";
		tips[15] = "Resist peer pressure to spend money you don’t have.";
		tips[16] = " Set ground rules with roommates about groceries, utilities, and household supplies, and about moving out before a lease expires. Put your agreement in writing and have each roommate sign the agreement.";
		tips[17] = "Pay the rent on time.";
		tips[18] = "Compare the cost of an apartment with the cost of a dorm room before making a housing move.";
		tips[19] = "Talk to your roommates about splitting expenses and handling shared bills.";
		tips[20] = "Use the dorm or campus printers instead of buying your own.";
		tips[21] = "Save on snacks by avoiding vending machines and instead buying snacks at the grocery store.";
		tips[22] = "Choose the meal plan that works best for you.";
		tips[23] = "Prepare for your career by getting your résumé ready and attending career fairs.";
		tips[24] = "Be your own boss. Turn a hobby or skill into a money-making venture.";
		tips[25] = "Look for an on-campus job.";
		tips[26] = "Make school your first job, and manage your time carefully.";
		tips[27] = "Talk to a financial aid officer if your situation changes.";
		tips[28] = "Submit a new Free Application for Federal Student Aid (FAFSA) every year. To apply for federal financial aid, you must complete this form.";
		tips[29] = "Understand what your student loan payments will be and when your monthly payments will begin. ";
		tips[30] = "Use loans as a last resort, and try to graduate with as little debt as possible.";
		tips[31] = "Watch out for scholarship scams.";
		tips[32] = "Keep looking for financial aid all through college. Scholarships, grants, and work-study jobs aren’t just for freshmen.";
		tips[33] = "Understand your financial aid by examining the terms of each scholarship, grant, and loan and reviewing requirements of work-study jobs.";
		tips[34] = "Don’t bounce checks.";
		tips[35] = "Find the best deal for your checking account by researching minimum-balance requirements and fees, including overdraft fees.";
		tips[36] = "Protect your personal information by safeguarding your Social Security number and shredding financial documents before discarding them.";
		tips[37] = "Get organized by creating a filing system for financial paperwork.";
		tips[38] = "Know the ground rules by talking to your parents or guardians about money. ";
		tips[39] = "Take charge of your life and your money by defining goals, making plans, and taking action.";
		
		Random rand = new Random();
		return tips[rand.nextInt(40)];
	}
}
