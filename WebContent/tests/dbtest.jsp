<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "db.Db,utility.Utility,java.sql.ResultSet,java.util.HashMap" %>
    
<%
	Db db = new Db();
	db.connect();
	
	ResultSet rs = db.executeQuery("SELECT * FROM LOGIN");
	while(rs.next()){
		HashMap map = new HashMap();
		map.put("PASSWORD",Utility.MD5("asdf{" + Utility.MD5(rs.getString("USERID")) + "}"));
		db.update("LOGIN", map, "USERID",rs.getString("USERID"));
	}
%>
