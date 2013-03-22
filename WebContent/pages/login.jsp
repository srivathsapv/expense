<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="utility.Utility" %>

<html>
<head>
	<title>Vowcher - Login</title>
	<link rel="shortcut icon" type = "image/ico" href = "../img/favico.ico">
	<link rel="stylesheet/less" href="../less/bootstrap.less">
	<script src = "../js/jquery-1.8.3.min.js"></script>
	<script src="../js/less.js" type="text/javascript"></script>
	
</head>
<body>
	<%
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
		<div class="center_content">
		<div class="login_page_container">
			<div class="login_page_title">Mobile App</div>
			<div class="login_img">
				<img src="../img/mobileapp_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here Some text goes here Some text goes here</p> 
		</div>
		<div class="login_page_container">
			<div class="login_page_title">Localization</div>
			<div class="login_img">
				<img src="../img/localization_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here Some text goes here Some text goes here</p> 
		</div>
		<div class="login_page_container">
			<div class="login_page_title">Reports</div>
			<div class="login_img">
				<img src="../img/reports_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here Some text goes here Some text goes here</p> 
		</div>
		<div class="login_page_container" style="margin-top: 25px;">
			<div class="login_page_title">Notification</div>
			<div class="login_img">
				<img src="../img/notification_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here Some text goes here Some text goes here</p> 
		</div>
		<div class="login_page_container" style="margin-top: 25px;">
			<div class="login_page_title">Search</div>	
			<div class="login_img">
				<img src="../img/search_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here Some text goes here Some text goes here</p> 
		</div>
		<div class="login_page_container" style="margin-top: 25px;">
			<div class="login_page_title">User Friendly GUI</div>
			<div class="login_img">
				<img src="../img/userfriendlygui_logo.png" alt="" border="0"/>
			</div>
			<p>Some text goes here Some text goes here  Some text goes here Some text goes here</p> 
		</div>
	</div>
</body>
</html>