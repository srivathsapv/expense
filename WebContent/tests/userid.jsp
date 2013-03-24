<%@ page import="db.Db" 
import="utility.Utility"
import="java.sql.*"
import="java.util.*"%>
<% Db db = new Db();
	db.connect();
	
	//ResultSet rs = db.executeQuery("SELECT * FROM LOGIN");
	//while(rs.next()){
		HashMap map = new HashMap();
		map.put("PASSWORD",Utility.MD5("asdf{" + Utility.MD5("sasipraveen") + "}"));
		db.update("LOGIN", map, "USERID","sasipraveen");
	//}
	%>