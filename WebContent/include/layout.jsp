<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "auth.Authentication,user.User,java.util.Map,java.io.File,voucher.Voucher" %>
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
   		%>
		<div class = "wrapper">
			<div class="navbar">
			  <div class="navbar-inner">
			  	<a class = "logo" href="../pages/dashboard.jsp">
			    	<img src = "../img/logo.png">
			    </a>
			    <ul class="nav">
			    	<li>
			    		<a href = "dashboard.jsp"><i class = "icon-home icon-white"></i>Home</a>
			    	</li>
	      			<li class="dropdown">
	                	<a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-file icon-white"></i>Voucher <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
	                  		<li><a tabindex="-1" href="voucher_add.jsp"><i class = "icon-plus-sign"></i>New Voucher</a></li>
	                  		<li><a tabindex="-1" href="../pages/voucher_list.jsp?userid=<%=l_username%>"><i class = "icon-list-alt"></i>My Vouchers</a></li>
	                  		<li><a tabindex="-1" href="vouchertype_list.jsp"><i class = "icon-list"></i>Voucher Types</a></li>
	                  		<li><a tabindex="-1" href = "amount_config.jsp"><i class = "icon-cog"></i>Amount Configuration</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop2" title = "Employee's Exclusive Expense Statistical Reports" data-placement = "bottom" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-book icon-white"></i><img class = "excess" src = "../img/excess.png">Reports <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop2">
	                  		<li><a tabindex="-1" href="#"><i class = "icon-file"></i>Generate New</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list-alt"></i>My Reports</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop3" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-user icon-white"></i>Users <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
	                  		<li><a tabindex="-1" href="user_add.jsp"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="user_list.jsp"><i class = "icon-list-alt"></i>List</a></li>
	                  		<li><a tabindex="-1" href="role_config.jsp"><i class = "icon-pencil"></i>Role Configuration</a>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop4" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-flag icon-white"></i>Policy<b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop4">
	                  		<li><a tabindex="-1" href="policy_add.jsp"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="policy_list.jsp"><i class = "icon-list-alt"></i>View</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop5" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-briefcase icon-white"></i>Departments <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop5">
	                  		<li><a tabindex="-1" href="dept_add.jsp"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="dept_list.jsp"><i class = "icon-list-alt"></i>View</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop6" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-wrench icon-white"></i>My Account<b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop6">
	                		
	                  		<li><a tabindex="-1" href="../pages/user_view.jsp?userid=<%=l_username%>"><i class = "icon-user"></i>Personal Details</a></li>
	                  		<li><a tabindex="-1" href="change_password.jsp"><i class = "icon-pencil"></i>Change Password</a></li>
	                  		<li><a onclick="logout()" class = "poi"><i class = "icon-off"></i>Signout</a></li>
	                	</ul>
	              	</li>
			    </ul>		        
			  </div>
			</div>
			<div class = "container-fluid">
				<div class = "row-fluid">
					<div class = "span2">
						<!-- Sidebar -->
						<div class="btn-group">
						    <a class="btn btn-info dropdown-toggle currency-change" data-toggle="dropdown" href="#">
						    	<img class = "currency-white" src = "../img/rupees-white.png">Rupees <span class = "custom-caret">&#9660;</span>
						    </a>
						    <ul class="dropdown-menu currency-change-menu">
						    	<li><a><img class = "currency" src = "../img/dollar.png">American Dollars</a></li>
						    	<li><a><img class = "currency" src = "../img/pound.png">Pounds</a></li>
						    	<li><a><img class = "currency" src = "../img/yen.png">Yen</a></li>
						    </ul>
					    </div>
						<div class = "sidebar recent-vouchers">
							<h5 class = "sidebar-title"><i class = "icon-file icon-white"></i>Recent Vouchers</h5>
							<div class = "sidebar-content">
								<ul>
									<%
										Voucher[] vouchers = Voucher.list("userid",l_username,5);
										int i=0;
										
										for(Voucher v:vouchers){
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
							<h5 class = "sidebar-title"><i class = "icon-bookmark icon-white"></i>Bookmarks</h5>
							<div class = "sidebar-content">
								<ul>
									<li>First voucher</li>
									<li>Second voucher</li>
									<li>Second voucher</li>
									<li>Second voucher</li>
									<li>Second voucher</li>
								</ul>
							</div>
						</div>
						
						<div class = "sidebar drafts">
							<h5 class = "sidebar-title"><i class = "icon-envelope icon-white"></i>Drafts</h5>
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