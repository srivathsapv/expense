package langConversion;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Scanner;

import org.json.JSONException;
import org.json.JSONObject;

public class Hindi {

	public String getConvertedText(String text) throws IOException,
			JSONException {
		String requestURL = "http://api.mymemory.translated.net/get?q=" + text
				+ "!&langpair=en|hi";
		URL wikiRequest = new URL(requestURL);
		Scanner scanner = new Scanner(wikiRequest.openStream());
		String response = "";
		while (scanner.hasNext()) {
			response = response + scanner.next();
		}
		scanner.close();
		JSONObject jo = new JSONObject(response);
		JSONObject jo1 = (JSONObject) jo.get("responseData");
		return getHexCode(jo1.get("translatedText").toString());
	}

	private String getHexCode(String text) {
		String dec, decString = "";
		char chr;
		int ascii, length = text.length();
		for (int i = 0; i < length; i++) {
			chr = text.charAt(i);
			ascii = chr;
			dec = Integer.toString(ascii);
			decString = decString + "&#" + dec + ";";
		}
		return decString;
	}
	
	public static String getHindiWord(String str){
		HashMap<String,String> hm = new HashMap<String,String>();
		hm.put("Notifications", "&#2309;&#2343;&#2367;&#2360;&#2370;&#2330;&#2344;&#2366;&#2319;&#2306;");
		hm.put("Bookmarks", "&#2346;&#2369;&#2360;&#2381;&#2340;&#2325;&#45;&#2330;&#2367;&#2361;&#2381;&#2344;");
		hm.put("Drafts", "&#2337;&#2381;&#2352;&#2366;&#2347;&#2381;&#2335;&#2381;&#2360;");
		hm.put("Home", "&#2328;&#2352;");
		hm.put("Voucher", "&#2357;&#2366;&#2313;&#2330;&#2352;");
		hm.put("Reports", "&#2352;&#2367;&#2346;&#2379;&#2352;&#2381;&#2335;");
		hm.put("Users", "&#2346;&#2381;&#2352;&#2351;&#2379;&#2325;&#2381;&#2340;&#2366;");
		hm.put("Policy", "&#2344;&#2368;&#2340;&#2367;");
		hm.put("Departments", "&#2357;&#2367;&#2349;&#2366;&#2327;&#2379;&#2306;");
		hm.put("My Account", "&#2350;&#2375;&#2352;&#2366; &#2326;&#2366;&#2340;&#2366;");
		hm.put("Recent Vouchers", "&#2361;&#2366;&#2354; &#2361;&#2368; &#2357;&#2366;&#2313;&#2330;&#2352;");
		hm.put("New Voucher", "&#2344;&#2312; &#2357;&#2366;&#2313;&#2330;&#2352;");
		hm.put("My Vouchers","&#2350;&#2375;&#2352;&#2375; &#2357;&#2366;&#2313;&#2330;&#2352;");
		hm.put("Voucher Types", "&#2357;&#2366;&#2313;&#2330;&#2352; &#2325;&#2375; &#2346;&#2381;&#2352;&#2325;&#2366;&#2352;");
		hm.put("Amount Configuration", "&#2352;&#2366;&#2358;&#2367; &#2357;&#2367;&#2344;&#2381;&#2351;&#2366;&#2360;");
		hm.put("Generate New", "&#2344;&#2312; &#2313;&#2340;&#2381;&#2346;&#2344;&#2381;&#2344;");
		hm.put("My Reports", "&#2350;&#2375;&#2352;&#2368; &#2352;&#2367;&#2346;&#2379;&#2352;&#2381;&#2335;");
		hm.put("Add New", "&#2344;&#2351;&#2366; &#2332;&#2379;&#2337;&#2364;&#2375;&#2306;");
		hm.put("List", "&#2360;&#2370;&#2330;&#2368;");
		hm.put("Role Configuration", "&#2352;&#2379;&#2354; &#2357;&#2367;&#2344;&#2381;&#2351;&#2366;&#2360;");
		hm.put("View", "&#2342;&#2375;&#2326;&#2344;&#2366;");
		hm.put("Personal Details", "&#2357;&#2381;&#2351;&#2325;&#2381;&#2340;&#2367;&#2327;&#2340; &#2357;&#2367;&#2357;&#2352;&#2339;");
		hm.put("Change Password", "&#2346;&#2366;&#2360;&#2357;&#2352;&#2381;&#2337; &#2348;&#2342;&#2354;&#2375;&#2306;");
		hm.put("Signout", "&#2360;&#2366;&#2311;&#2344; &#2310;&#2313;&#2335;");
		hm.put("View All", "&#2360;&#2349;&#2368; &#2342;&#2375;&#2326;&#2375;&#2306;");
		hm.put("Welcome","&#2348;&#2343;&#2366;&#2312;");
		
		return hm.get(str).toString();
		
	}

}
