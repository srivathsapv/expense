<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Layout Sample</title>
		<!-- Bootstrap -->
		<script src = "../js/jquery-1.8.3.min.js"></script>
		<script src = "../js/bootstrap-dropdown.js"></script>
		<script src = "../js/bootstrap-tooltip.js"></script>
		<script src = "../js/layout.js"></script>
		<link rel="stylesheet/less" href="../less/bootstrap.less">
		<script src="../js/less.js"></script>
		<style>
			html,body,#wrapper { height:100%; }
			body > #wrapper { height:auto; min-height:100%; }
			#footer {
				clear: both;
				position: relative;
				z-index: 10;
				height: 2.75em;
				margin-top: -3em;
				background:#2a2a2a;
				border-top:solid 4px #447FB8;
				color:white;
			}
			
			#links {
				float:right;
				margin-right: 5px;
			}
			
			#copyright {
				margin-left: 5px;
			}
		</style>
		<script>
			$("#drop2").tooltip();
		</script>
	</head>
	<body>
		<div id = "wrapper">
			<div class="navbar">
			  <div class="navbar-inner">
			  	<a class = "logo" href="#">
			    	<img src = "../img/logo.png">
			    </a>
			    <ul class="nav">
			    	<li>
			    		<a href = "#"><i class = "icon-home icon-white"></i>Home</a>
			    	</li>
	      			<li class="dropdown">
	                	<a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-file icon-white"></i>Voucher <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
	                  		<li><a tabindex="-1" href="#"><i class = "icon-plus-sign"></i>New Voucher</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list-alt"></i>My Vouchers</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list"></i>Voucher Types</a></li>
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
	                  		<li><a tabindex="-1" href="#"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list-alt"></i>List</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop4" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-flag icon-white"></i>Policy<b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop4">
	                  		<li><a tabindex="-1" href="#"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list-alt"></i>View</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop5" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-briefcase icon-white"></i>Departments <b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop5">
	                  		<li><a tabindex="-1" href="#"><i class = "icon-plus-sign"></i>Add New</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-list-alt"></i>View</a></li>
	                	</ul>
	              	</li>
	              	<li class="dropdown">
	                	<a id="drop6" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"><i class = "icon-wrench icon-white"></i>My Account<b class="caret"></b></a>
	                	<ul class="dropdown-menu" role="menu" aria-labelledby="drop6">
	                  		<li><a tabindex="-1" href="#"><i class = "icon-user"></i>Personal Details</a></li>
	                  		<li><a tabindex="-1" href="#"><i class = "icon-pencil"></i>Change Password</a></li>
	                  		<li><a href = "#"><i class = "icon-off"></i>Signout</a></li>
	                	</ul>
	              	</li>
			    </ul>
		        <div class="btn-group">
				    <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
				    	<img class = "currency-white" src = "../img/rupees-white.png">Rupees <span class="caret"></span>
				    </a>
				    <ul class="dropdown-menu">
				    	<li><a><img class = "currency" src = "../img/dollar.png">American Dollars</a></li>
				    	<li><a><img class = "currency" src = "../img/pound.png">Pounds</a></li>
				    	<li><a><img class = "currency" src = "../img/yen.png">Yen</a></li>
				    </ul>
			    </div>
			  </div>
			</div>
			<div class = "container-fluid">
				<div class = "row-fluid">
					<div class = "span2">
						<!-- Sidebar -->
						<div class = "sidebar recent-vouchers">
							<h5 class = "sidebar-title"><i class = "icon-file icon-white"></i>Recent Vouchers</h5>
							<ul>
								<li>First voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
							</ul>
						</div>
						
						<div class = "sidebar bookmarks">
							<h5 class = "sidebar-title"><i class = "icon-bookmark icon-white"></i>Bookmarks</h5>
							<ul>
								<li>First voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
							</ul>
						</div>
						
						<div class = "sidebar drafts">
							<h5 class = "sidebar-title"><i class = "icon-envelope icon-white"></i>Drafts</h5>
							<ul>
								<li>First voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
								<li>Second voucher</li>
							</ul>
						</div>
					</div>
					<div class = "span9">
						
					</div>
				</div>
			</div>  
		</div>	
		<jsp:include page = "footer.jsp"/>