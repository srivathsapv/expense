<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="utility.Utility,java.io.File" %>

<html>
<head>
	<title>Vowcher - A web based solution for expense management</title>
	<link rel="shortcut icon" type = "image/ico" href = "../img/favico.ico">
	<link rel="stylesheet/less" href="../less/bootstrap.less">
	<script src = "../js/jquery-1.8.3.min.js"></script>
	<script src="../js/less.js" type="text/javascript"></script>
</head>
<body>
	<%
		String path = config.getServletContext().getRealPath("/")+"temp/";
		File f = new File(path + "dbconfig.cfg");
		if(!f.exists()){
			response.sendRedirect("dbinit.jsp");
		}
		
		if(session.getAttribute("sessionUser") != null){
			response.sendRedirect("dashboard.jsp");
			return;
		}
	
		String redirect = "";
		if(request.getParameter("redirect_to") == null) {
			redirect = "dashboard";
		}
		else {
			redirect = request.getParameter("redirect_to");
		}
		
	%>
	
	<script>
		function setCookie() {
			if($("#remember").is(":checked")){
				localStorage.vowcher_username = $("#username").val();
			}
		}
		if(localStorage.vowcher_username != undefined) {
			var username = localStorage.vowcher_username;
			window.location = "dashboard.jsp?username="+username+"&redirect_to=<%=redirect%>";
		}
	</script>
	<style>
		.login_page_container > p {
			font-size:17px!important;
		}
	</style>
	<div class="navbar">
		<div class="navbar-inner">
			<div class="row-fluid">
				<div class="span12">
					<br /> <br />
					<div class="row-fluid">
						<div class="span6">
							<div class="logo">
								<img src = "../img/logo_original.png" class="offset2">
							</div>
						</div>
						<div class="span3 offset2 standout">
							<form class="white" action = "../server/login.jsp" method = "POST" onsubmit="setCookie()">
								<div class="control-group">
								</div>
									<br/>
										<div class="control-group">
											<div class="controls">
												<input type="text" class="span10" name="username" id = "username" placeholder="Username...">
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
												<input type="password" class="span10" name="password" placeholder="Password...">
											</div>
										</div>
										<input type = "hidden" name = "redirect" value = "<%= redirect %>">
										<input type="submit" class="btn btn-info" value = "Login"></button>
										<div class="control-group span10">
											<div class="controls">
												<label class="checkbox"> <input type="checkbox" id="remember" name = "remember" value = "remember">
													Keep me logged in
												</label>
											</div>
										</div>
										
								</form>
								<%
									if(request.getParameter("status") != null) {
										String hashedstatus = Utility.MD5("{failed}" + session.getAttribute("timestamp").toString());
										if(hashedstatus.equals(request.getParameter("status"))) {
											%> 
											<center>
												<p class = "text-error">
													Invalid username or password!
												</p>
											</center>
											<%
										}
									}
								%>
							</div>
						</div>	
						<br /> <br />
					</div>
				</div>
			</div>
		</div>
		<br/>
		<br/>
		<div class="row-fluid">
		<div class = "span10 offset1">
		<div class="span4">
			<div class="login_img">
				<img src="../img/reports_logo.png" alt="" border="0"/>
			<p>Data reports with graphical representation exportable in PDF format</p> 
		</div>
		</div>
		<div class="span4">	
			<div class="login_img">
				<img src="../img/search_logo.png" alt="" border="0"/>
			<p>Quick access to user and voucher information using the search feature</p> 
		</div>
		</div>
		<div class="span4" >
			<div class="login_img">
				<img src="../img/notification_logo.png" alt="" border="0"/>
			<p>Get dashboard as well as mail notifications about voucher status</p> 
		</div>
		</div>
		</div>
		</div>
		<br/>
		<br/>
		<div class="row-fluid">
		<div class = "span10 offset1">
		<div class="span4">
			<div class="login_img">
				<img src="../img/mobileapp_logo.png" alt="" border="0"/>
			<p>Mobile application to check notifications on the go</p> 
		</div>
		</div>
		<div class="span4">
			<div class="login_img">
				<img src="../img/localization_logo.png" alt="" border="0"/>
			<p>GUI provided both in English and Hindi for greater reach</p> 
		</div>
		</div>	
		<div class="span4">
			<div class="login_img">
				<img src="../img/userfriendlygui_logo.png" alt="" border="0"/>
			<p>Intuitive menu driven and easy to understand GUI for greater user experience</p> 
		</div>
		</div>
	</div>
	</div>
</body>
</html>