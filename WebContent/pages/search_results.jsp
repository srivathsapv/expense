<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.util.LinkedHashSet,voucher.Voucher,user.User,user.Department,db.Db,java.sql.ResultSet"%>
<%@ include file = "../include/layout.jsp" %>

<title>Vowcher - Search Results</title>
<style>
		.search-result{
			margin-bottom:12px;
		}
		
		.user-item {
			margin-bottom:15px;
		}
		
		.user-list {
			list-style:none;
		}
		
		.profile-picture {
			margin-right: 7px;
		}
	</style>
<div id = "body-content">
	<legend>
		<h1>Search Results</h1>
	</legend>
	<legend>
		<h3>Vouchers containing the keyword  <span class = "font-italic">'<%=request.getParameter("query") %>'</span></h3>
		<ul>
			<%
				String param = request.getParameter("query");
				Db db = new Db();
				db.connect();
				String[] words = param.split(" ");
				LinkedHashSet<Integer> vids = new LinkedHashSet<Integer>();
				
				for(String w:words){
					String query = "SELECT * FROM VOUCHER " +
							   "WHERE LCASE(TITLE) LIKE '%" + w + "%' OR " +
							   "LCASE(DESCRIPTION) LIKE '%" + w + "%' OR " +
							   "LCASE(REJECTREASON) LIKE '%" + w + "%' OR " + 
							   "USERID IN " +
							   "(SELECT USERID FROM USER WHERE LCASE(FIRSTNAME) LIKE '%" + w + "%' OR "
							   +" LCASE(LASTNAME) LIKE '%" + w + "%')";
				
					ResultSet rs = db.executeQuery(query);
					
					while(rs.next()){
						vids.add(rs.getInt("VOUCHERID"));		
					}	
				}
				
				for(int vid:vids){
					Voucher vouch = new Voucher(vid);
					User user = new User(vouch.getUserid());
					%>	
					<li class = "search-result">
						<a href = "voucher_view.jsp?id=<%=vouch.getVoucherid() %>">
							<%=vouch.getTitle() %>
						</a> submitted by 
						<a href = "user_view.jsp?userid=<%=user.getUserid() %>">
							<%= user.getFirstName() + " " + user.getlastName() %>
						</a>
					</li>
					<%
				}
			%>
		</ul>
	</legend>
	<legend>
		<h3>Users containing the keyword &nbsp;&nbsp;<span class = "font-italic">'<%=request.getParameter("query") %>'</span></h3>
	</legend>
	<ul class = "user-list">
		<%
			LinkedHashSet<String> userids = new LinkedHashSet<String>();
			for(String w:words){
				String query = "SELECT * FROM USER " +
						"WHERE LCASE(FIRSTNAME) LIKE '%" + w + "%' OR " +
						"LCASE(MIDDLENAME) LIKE '%" + w + "%' OR " +
						"LCASE(LASTNAME) LIKE '%" + w + "%' OR " +
						"LCASE(DESIGNATION) LIKE '%" + w + "%' OR " +
						"LCASE(ADDRESS) LIKE '%" + w + "%' OR " +
						"LCASE(EMAIL) LIKE '%" + w + "%' OR " +
						"DEPTID IN " +
						"(SELECT DEPTID FROM DEPARTMENT WHERE LCASE(DEPTNAME) LIKE '%" + w + "%' OR " +
						" LCASE(DESCRIPTION) LIKE '%" + w + "%')";
				
				ResultSet rs = db.executeQuery(query);
				while(rs.next()){
					userids.add(rs.getString("USERID"));
				}
			}
			
			for(String uid:userids){
				User user = new User(uid);
				String imgsrc = "../img/profile_default.png";
				if(user.getPhoto() != null){
					if(!user.getPhoto().equals("")) {
						imgsrc = "../server/display_image.jsp?mode=profile_picture&userid=" + user.getUserid();	
					}
				}
				%> 
				<li class = "user-item">
					<img src = "<%=imgsrc %>" style = "width:32px" class = "img-rounded profile-picture" >
					<a href = "user_view.jsp?userid=<%=uid %>"><%= user.getFirstName() + " " + user.getlastName() %></a>
				</li>
			<%
			}
		%>
	</ul>
</div>