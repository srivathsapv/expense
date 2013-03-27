<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.Arrays,java.util.Vector,db.Db,auth.Authentication,user.User,java.util.Map,java.io.File,voucher.Voucher" %>
<html>
	<head>
		<link rel="shortcut icon" type = "image/ico" href = "../img/favico.ico">
		<!-- Bootstrap -->
		<script src = "../js/jquery-1.8.3.min.js"></script>
		<script src = "../js/bootstrap-dropdown.js"></script>
		<script src = "../js/bootstrap-tooltip.js"></script>
		<script src = "../js/layout.js"></script>
		<script src = "../js/validate.js"></script>
		<link rel="stylesheet/less" href="../less/bootstrap.less">
		
		<script src="../js/less.js"></script>
		<style>
			html,body { height:100%; }
			.wrapper { height:auto!important; min-height:100%; height:100%;margin:0 auto -2.75em; }
			
			.footer {				
				position: relative;
				z-index: 10;
				margin-top: -2.75em;
				background:#2a2a2a;
				border-top:solid 4px #447FB8;
				color:white;
				height: 2.75em;
			}
			
			.footer,.push {
				clear:both;
				
			}
			
			.push {
				height:3.25em;
			}
			
			#links {
				float:right;
				margin-right: 5px;
			}
			
			#copyright {
				margin-left:5px;
			}
						
			.currency-change-menu {
				width:180px!important;
			}
			
			.bm-img {
				top:2.5%;
				position:absolute;
				left:86%;
				
			}
		</style>
		<script type = "text/javascript">
			function logout() {
				localStorage.removeItem("vowcher_username");
				window.location = "../server/logout.jsp";
			}
			
			$(document).ready(function(){
				$("#drop1").tooltip();
				var width = parseInt($(".sidebar").css("width"));
				$(".sidebar-title").css("width",width+"px");
				width = width - 26;
				$(".currency-change").css("width",width+"px");
				$(".currency-change-menu").css("width",width+"px");
				
				$("button[type='button']").click(function(){
					$(this).parent().attr("style","display:none");
				});
				<%
					String currency = "";
					String currencyText = "";
					String currencyISO = "";
					if(session.getAttribute("currency") != null) {
						currency = session.getAttribute("currency").toString();
						currencyText = session.getAttribute("currencyText").toString();
						currencyISO = session.getAttribute("currencyISO").toString();	
					}
				%>
				$("#main-button").html('<img class = "currency-white" src = "../img/<%=currency%>-white.png"><%=currencyText%> <span class = "custom-caret">&#9660;</span>');
				$(".currency-change-img").attr("src","../img/<%=currency%>.png");
				<%
					if(!currency.equals("rupees")) {
				%>
						$(".currency-change-amount").each(function(){
							var e = $(this);
							$.ajax({
								url:"../server/change_currency.jsp",
								data:"mode=convert&amount="+e.html()+"&from=INR&to=<%=currencyISO%>",
								type:"POST",
								success:function(msg){
									e.html(msg);
								}
							});
						});
				<%
					}
				%>
				
				$("#add-bookmark").click(function(){
					var title = window.prompt("Give a title to your bookmark","untitled");
					var link = $(this).attr("alt");
					if(title != null) {
						$.ajax({
							url:"../server/bookmark_add.jsp",
							type: "POST",
							data:"title="+title+"&link="+link,
							success:function(msg){
								$("#add-bookmark").css("display","none");
								$("#remove-bookmark").css("display","block");
								$("#bm-list").append("<li><a href = '../pages/" + link + "'>" + title + "</a></li>");
								$("#no-bms").remove();
							}
						});	
					}
				});
				
				$("#remove-bookmark").click(function(){
					var link = $(this).attr("alt");
					$.ajax({
						url:"../server/delete.jsp",
						type:"POST",
						data:"type=bookmark&link="+link,
						success:function(msg){
							$("#add-bookmark").css("display","block");
							$("#remove-bookmark").css("display","none");
						}
					});
				});
				
				$("#inr").click(function(){
					$("#main-button").html('<img class = "currency-white" src = "../img/rupees-white.png">Indian Rupees <span class = "custom-caret">&#9660;</span>');
					var fromISO = "";
					$.ajax({
						url:"../server/change_currency.jsp",
						type:"POST",
						data:"mode=session&currency=rupees",
						success:function(msg){
							fromISO = msg;
							changeCurrency(fromISO,"rupees");
						}
					});
					
				});
				
				$("#usd").click(function(){
					$("#main-button").html('<img class = "currency-white" src = "../img/dollar-white.png">US Dollars <span class = "custom-caret">&#9660;</span>');
					var fromISO = "";
					$.ajax({
						url:"../server/change_currency.jsp",
						type:"POST",
						data:"mode=session&currency=dollar",
						success:function(msg){
							fromISO = msg;
							changeCurrency(fromISO,"dollar");
						}
					});
					
				});
				
				$("#gbp").click(function(){
					$("#main-button").html('<img class = "currency-white" src = "../img/pound-white.png">British Pound <span class = "custom-caret">&#9660;</span>');
					var fromISO = "";
					$.ajax({
						url:"../server/change_currency.jsp",
						type:"POST",
						data:"mode=session&currency=pound",
						success:function(msg){
							fromISO = msg;
							changeCurrency(fromISO,"pound");
						}
					});
					
				});
				
				$("#jpy").click(function(){
					$("#main-button").html('<img class = "currency-white" src = "../img/yen-white.png">Yen <span class = "custom-caret">&#9660;</span>');
					var fromISO = "";
					$.ajax({
						url:"../server/change_currency.jsp",
						type:"POST",
						data:"mode=session&currency=yen",
						success:function(msg){
							fromISO = msg;
							changeCurrency(fromISO,"yen");
						}
					});
					
				});
				
				
				function changeCurrency(fromISO,currency) {
					$(".currency-change-img").attr("src","../img/"+currency+".png");
					var curISO = "";
					if(currency == "rupees") curISO = "INR";
					else if(currency == "dollar") curISO = "USD";
					else if(currency == "yen") curISO = "JPY";
					else if(currency == "pound") curISO = "GBP";
					$(".currency-change-img").attr("src","../img/" + currency + ".png");
					$(".currency-change-amount").each(function(){
						var e = $(this);
						$.ajax({
							url:"../server/change_currency.jsp",
							data:"mode=convert&amount="+e.html()+"&from=" +fromISO + "&to=" + curISO,
							type:"POST",
							success:function(msg2){
								e.html(msg2);
							}
						});
					});
				}
				<%
					if(session.getAttribute("lang") != null) {
						if(session.getAttribute("lang").equals("hin")) {
							%>
							$(".to-hindi").each(function(){
								var e = $(this);
								$.ajax({
									url:"../server/convert_language.jsp",
									data:"word="+e.html(),
									type:"GET",
									success:function(msg){
										e.html(msg);
										e.css("font-size","17px");
										$("#welcome-text").css("font-size","24px");
										e.css("font-spacing","1px");
										
									}
								});
							});
							<%
						}	
					}
				%>
				
				$("#search-box").keypress(function(event){
					if(event.which == 13){
						if($(this).val() != '') {
							window.location = "search_results.jsp?query="+$(this).val();	
						}
					}
				});
				
			});
			
			if(localStorage.vowcher_username != undefined) {
				<%
					if(request.getParameter("username") != null) {
						User sessionUser = new User(request.getParameter("username"));
						session.setAttribute("sessionUser",sessionUser);
						
						Authentication auth = new Authentication(request.getParameter("username"));
						session.setAttribute("lastlogin",auth.getLastlogin());
					}
				%>
			}
		</script>
	</head>
	<body>
		<%
			//Session Check
			if(session.getAttribute("sessionUser") == null) {
				String paramStr = "";
				Map<String, String[]> parameters = request.getParameterMap();
				for(String parameter : parameters.keySet()) {	
			        String[] values = parameters.get(parameter);
			        paramStr += parameter + "=" + values[0] + "&";
				}
				String redirectStr = request.getRequestURL().toString();
				if(!redirectStr.equals("")){
					if(!paramStr.equals("")) {
						paramStr = paramStr.substring(0,paramStr.length()-1);
						redirectStr += "?" + paramStr;
					}
					response.sendRedirect("login.jsp?redirect_to="+redirectStr);
					return;	
				}
				else {
					response.sendRedirect("login.jsp");
					return;
				}
				
			}
		%>
		<%
   			User l_user = (User)session.getAttribute("sessionUser");
   			String l_username = l_user.getUserid();
   			String l_role = session.getAttribute("sessionUserRole").toString();
   			
   			
   		%>
		<div class = "wrapper">
			<div class="navbar">
			  <div class="navbar-inner">
			  	<a class = "logo" href="../pages/dashboard.jsp">
			    	<img src = "../img/logo.png">
			    </a>
			    <ul class="nav">
			    	<li>
			    		<a href = "dashboard.jsp"><i class = "icon-home icon-white"></i><span class = "to-hindi">Home</span></a>
			    	</li>
	      			<li class="dropdown">
	                	<a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-file icon-white"></i><span class = "to-hindi">Voucher</span> <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
	                  		<li><a tabindex="-1" href="voucher_add.jsp"><i class = "icon-plus-sign"></i><span class = "to-hindi">New Voucher</span></a></li>
	                  		<li><a tabindex="-1" href="../pages/voucher_list.jsp"><i class = "icon-list-alt"></i><span class = "to-hindi">My Vouchers</span></a></li>
	                  		<%
	              			if(l_role.equals("admin") || l_role.equals("md")) {
	              			%>
	                  		<li><a tabindex="-1" href="vouchertype_list.jsp"><i class = "icon-list"></i><span class = "to-hindi">Voucher Types</span></a></li>
	                  		<li><a tabindex="-1" href = "amount_config.jsp"><i class = "icon-cog"></i><span class = "to-hindi">Amount Configuration</span></a></li>
	                  		<% } %>
	                	</ul>
	              	</li>
	              	<%
	              	if(l_role.equals("admin") || l_role.equals("md")) {
	              	%>
	              	<li class="dropdown">
	                	<a id="drop2" title = "Employee's Exclusive Expense Statistical Reports" data-placement = "bottom" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-book icon-white"></i><img class = "excess" src = "../img/excess.png"><span class = "to-hindi">Reports</span> <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop2">
	                  		<li><a tabindex="-1" href="report_generate.jsp"><i class = "icon-file"></i><span class = "to-hindi">Generate New</span></a></li>
	                  		<li><a tabindex="-1" href="../pages/report_list.jsp"><i class = "icon-list-alt"></i><span class = "to-hindi">My Reports</span></a></li>
	                	</ul>
	              	</li>
	              	<%
	              	}
	              	%>
	              	<%
	              	if(l_role.equals("admin") || l_role.equals("md")) {
	              	%>
	              	<li class="dropdown">
	                	<a id="drop3" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-user icon-white"></i><span class = "to-hindi">Users</span> <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
	                  		<li><a tabindex="-1" href="user_add.jsp"><i class = "icon-plus-sign"></i><span class = "to-hindi">Add New</span></a></li>
	                  		<li><a tabindex="-1" href="user_list.jsp"><i class = "icon-list-alt"></i><span class = "to-hindi">List</span></a></li>
	                  		<li><a tabindex="-1" href="role_config.jsp"><i class = "icon-pencil"></i><span class = "to-hindi">Role Configuration</span></a>
	                	</ul>
	              	</li>
	              	<% } %>
	              	<%
	              	if(l_role.equals("admin") || l_role.equals("md")) {
	              	%>
	              	<li class="dropdown">
	                	<a id="drop4" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-flag icon-white"></i><span class = "to-hindi">Policy</span><b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop4">
	                  		<li><a tabindex="-1" href="policy_add.jsp"><i class = "icon-plus-sign"></i><span class = "to-hindi">Add New</span></a></li>
	                  		<li><a tabindex="-1" href="policy_list.jsp"><i class = "icon-list-alt"></i><span class = "to-hindi">View</span></a></li>
	                	</ul>
	              	</li>
	              	<% } %>
	              	<%
	              	if(l_role.equals("admin") || l_role.equals("md")) {
	              	%>
	              	<li class="dropdown">
	                	<a id="drop5" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-briefcase icon-white"></i><span class = "to-hindi">Departments</span> <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop5">
	                  		<li><a tabindex="-1" href="dept_add.jsp"><i class = "icon-plus-sign"></i><span class = "to-hindi">Add New</span></a></li>
	                  		<li><a tabindex="-1" href="dept_list.jsp"><i class = "icon-list-alt"></i><span class = "to-hindi">View</span></a></li>
	                	</ul>
	              	</li>
	              	<% } %>
	              	<li class="dropdown">
	                	<a id="drop6" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-wrench icon-white"></i><span class = "to-hindi">My Account</span><b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop6">
	                		
	                  		<li><a tabindex="-1" href="../pages/user_view.jsp?userid=<%=l_username%>"><i class = "icon-user"></i><span class = "to-hindi">Personal Details</span></a></li>
	                  		<li><a tabindex="-1" href="change_password.jsp"><i class = "icon-pencil"></i><span class = "to-hindi">Change Password</span></a></li>
	                  		<li><a onclick="logout()" class = "poi"><i class = "icon-off"></i><span class = "to-hindi">Signout</span></a></li>
	                	</ul>
	              	</li>
			    </ul>	
			    <%
					String url = request.getRequestURL().toString();
			    	
			    	
			    	
			    
					String pagename = url.substring(url.lastIndexOf("/")+1,url.length());
			    	
					//check role
					if(l_role.equals("employee") || l_role.equals("ceo")){
			    		String[] restricted_pages = {"aconfig_add.jsp","amount_config.jsp",
			    			"dept_add.jsp","dept_list.jsp","policy_add.jsp","policy_list.jsp",
			    			"rconfig_add.jsp","report_generate.jsp","report_list.jsp","role_config.jsp",
			    			"user_add.jsp","user_list.jsp","vouchertype_add.jsp","vouchertype_list.jsp"
			    		};
			    		
			    		for(String p:restricted_pages){
			    			if(p.equals(pagename)){
			    				response.sendRedirect("../pages/dashboard.jsp");
			    				return;
			    			}
			    		}
			    	}
			    	
					String querystr = request.getQueryString() + "&";
					
					String[] paramarry = querystr.split("&");
					Vector<String> params = new Vector<String>(Arrays.asList(paramarry));
					String paramstr = "";
					for(int i=0;i<params.size();i++){
						
						if(params.get(i).toString().indexOf("message") >= 0 || params.get(i).toString().indexOf("status") >= 0){
							continue;	
						}
						else {
							paramstr += params.get(i) + "&";
						}
					}
					if(paramstr.length() > 0) {
						paramstr = paramstr.substring(0,paramstr.length()-1);
						paramstr = "?" + paramstr;
					}
					
					pagename += paramstr;
					
					if(pagename.indexOf("dashboard.jsp") == -1){
						Db db = new Db();
						db.connect();
						String username = session.getAttribute("sessionUsername").toString();
						java.sql.ResultSet rs = db.executeQuery("SELECT COUNT(*) FROM BOOKMARK WHERE USERID = '" + username + "' AND LINK = '" + pagename + "'");
						rs.next();
						if(rs.getInt(1) > 0) {
							%> <img id = "remove-bookmark" alt = "<%=pagename %>" class = "bm-img poi" src = "../img/bookmark-active.png" style = "width:2%;" title = "Remove bookmark"> 
								<img id = "add-bookmark" alt = "<%=pagename %>" class = "bm-img poi" src = "../img/bookmark-inactive.png" style = "display:none;width:2%;" title = "Bookmark this page">	
						<%									
						}
						else {
							%> <img id = "add-bookmark" alt = "<%=pagename %>" class = "bm-img poi" src = "../img/bookmark-inactive.png" style = "width:2%;" title = "Bookmark this page">
							<img id = "remove-bookmark" alt = "<%=pagename %>" class = "bm-img poi" src = "../img/bookmark-active.png" style = "display:none;width:2%;" title = "Remove bookmark">
				<%	
						}
					}
			  	%>	        
			  </div>
			</div>
			<div class = "container-fluid">
				<div class = "row-fluid">
					<div class = "span2">
						<!-- Sidebar -->
						
						<div class="btn-group">
						    <a id = "main-button" class="btn btn-info dropdown-toggle currency-change" data-toggle="dropdown" href="#">
						    	<img class = "currency-white" src = "../img/rupees-white.png">Indian Rupees <span class = "custom-caret">&#9660;</span>
						    </a>
						    <ul class="dropdown-menu currency-change-menu">
						    	<li id = "inr"><a><img class = "currency" src = "../img/rupees.png">Indian Rupees</a></li>
						    	<li id = "usd"><a><img class = "currency" src = "../img/dollar.png">US Dollars</a></li>
						    	<li id = "gbp"><a><img class = "currency" src = "../img/pound.png">British Pounds</a></li>
						    	<li id = "jpy"><a><img class = "currency" src = "../img/yen.png">Yen</a></li>
						    </ul>
					    </div><br><br>
					    <div class = "search input-prepend">
					    	<span class = "add-on"><i class = "icon-search"></i></span>
					    	<input type = "text" class = "span10" placeholder = "Search ..." id = "search-box">
					    </div>
					    
						<div class = "sidebar recent-vouchers">
							<h5 class = "sidebar-title"><i class = "icon-file icon-white"></i><span class = "to-hindi">Recent Vouchers</span></h5>
							<div class = "sidebar-content">
								<ul>
									<%
										Voucher[] vouchers = Voucher.list("userid",l_username,5);
										int i=0;
										
										for(Voucher v:vouchers){
											if(v==null) continue;
											String title = v.getTitle();
											if(title.length() > 15){
												title = title.substring(0,15) + "...";
											}
											%> <li><a href = "../pages/voucher_view.jsp?id=<%=v.getVoucherid() %>"><%= title %></a></li> <%
											i++;
										}
									%>
								</ul>
								<%
									if(i==0){
										%> <center>No recent vouchers</center> <%
									}
									else{
										%> <center><i class = "icon-th-list icon-white"></i><a href = "../pages/voucher_list.jsp?userid=<%=l_username %>">View all</a></center>
									<% }%>
							</div>
						</div>
						
						<div class = "sidebar bookmarks">
							<h5 class = "sidebar-title"><i class = "icon-bookmark icon-white"></i><span class = "to-hindi">Bookmarks</span></h5>
							<div class = "sidebar-content">
								<ul id="bm-list">
									<%
										user.Bookmark[] bms = user.Bookmark.list("USERID",session.getAttribute("sessionUsername").toString());
										for(user.Bookmark b:bms){
											%><li><a href = "<%=b.getLink() %>"><%=b.getTitle() %></a></li> <%
										}
										
									%>
								</ul>
								<%
									if(bms.length == 0){
										%> <center id = "no-bms">No bookmarks added</center> <%
									}
									else {
										%> <center><i class = "icon-th-list icon-white"></i><a href = "../pages/bookmark_list.jsp?userid=<%=l_username %>">View all</a></center> <%
									}
								%>
							</div>
						</div>
						
						<div class = "sidebar drafts">
							<h5 class = "sidebar-title"><i class = "icon-envelope icon-white"></i><span class = "to-hindi">Drafts</span></h5>
							<div class = "sidebar-content">
								<ul>
									<%
									String directory_path = config.getServletContext().getRealPath("/")+"drafts/";
									String files;
									File folder = new File(directory_path);
									File[] listOfFiles = folder.listFiles();
									
									User layout_user = (User)session.getAttribute("sessionUser");
									String layout_username = layout_user.getUserid();
									i =0;
									if(listOfFiles != null) {
										for (i = 0; i < listOfFiles.length; i++) 
										{
											if (listOfFiles[i].isFile()) 
									 		{
									 			files = listOfFiles[i].getName();
									 			String[] parts = files.split("-");
									 			if(parts[0].equals(layout_username)){
									 				String shortened_filename = parts[1];
									 				if(parts[1].length() > 15){
									 					shortened_filename = parts[1].substring(0,15) + "...";
									 				}
									 				%> <li><a href = '../pages/voucher_add.jsp?mode=drafts&filename=<%=files%>'><%= shortened_filename %></a></li> <%
									 			}
									    	}
											if(i == 4) {
												break;
											}
										}	
									}
									%>
								</ul>
									<%
									if(i == 0){
										%> <center>No drafts saved</center> <%
									}
									else {
										%><center><i class = "icon-th-list icon-white"></i><a href = "../pages/draft_list.jsp?userid=<%=l_username %>">View all</a></center> <%
									}
									%>
							</div>
						</div>
					</div>
					<div class = "span9">
						
					</div>
				</div>
			</div> 
			<div class = "push"></div>
		</div>
		<jsp:include page = "../include/footer.jsp"/>