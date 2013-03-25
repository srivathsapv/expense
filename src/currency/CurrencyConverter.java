package currency;

import java.io.IOException;
import java.net.URL;
import java.util.Scanner;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * 
 * @author Sasi Praveen
 * @email sasipraveen39@gmail.com
 * @date 24/03/2013
 * 
 */

public class CurrencyConverter {

	/**
	 * amount to be coverted
	 * 
	 * @var double
	 */
	private double amount;
	
	/**
	 * Currency from which amount has to be converted
	 * 
	 * @var String
	 */
	private String from;
	
	/**
	 * Currency to which amount is to be converted
	 * 
	 * @var String
	 */
	private String to;
	
	/**
	 * Currency Exchange rate
	 * 
	 * @var double
	 */
	private double conversionRate;
	
	
	/**
	 * initializes all the variables
	 */
	public CurrencyConverter() {
		this.amount = 0;
		this.conversionRate = 0;
		this.from = "";
		this.to = "";
	}
	
	/**
	 * Returns Currency from which amount has to be converted
	 * 
	 * @return String
	 */
	public String getFrom() {
		return from;
	}
	
	/**
	 * sets Currency from which amount has to be converted
	 * 
	 * @param from
	 */
	public void setFrom(String from) {
		this.from = from;
	}
	
	/**
	 * Returns Currency to which amount is to be converted
	 * 
	 * @return String 
	 */
	public String getTo() {
		return to;
	}
	
	/**
	 * sets Currency to which amount is to be converted
	 * 
	 * @param to
	 */
	public void setTo(String to) {
		this.to = to;
	}
	
	/**
	 * Fetches exchange rate from server
	 *  
	 * @throws IOException
	 * @throws JSONException
	 */
	public void fetchExchangeRateFromServer() throws IOException, JSONException{
		this.from = this.from.substring(0,3);
		this.to = this.to.substring(0,3);
		String requestURL = "http://rate-exchange.appspot.com/currency?from="+from+"&to="+to;
		URL wikiRequest = new URL(requestURL);
		Scanner scanner = new Scanner(wikiRequest.openStream());
		String response ="";
		while(scanner.hasNext()){
			response = response + scanner.next();
		}
		scanner.close();
		JSONObject jo = new JSONObject(response);
		this.conversionRate = Double.parseDouble(jo.get("rate").toString());
	}
	
	/**
	 * Converts the given amount 
	 * 
	 * @param amount
	 * @return double
	 */
	public double getConvertedAmount(double amount){
		this.amount = amount;
		double finalAmount = 0;
		finalAmount = Math.round(this.amount * this.conversionRate *100.0)/100.0;
		return finalAmount;
	}
	
}
