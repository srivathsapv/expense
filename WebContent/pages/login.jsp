<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="utility.Utility" %>

<html>
<head>
	<title>Vowcher - Login</title>
	<link rel="shortcut icon" type = "image/ico" href = "../img/favico.ico">
	<link rel="stylesheet/less" href="../less/bootstrap.less">
	<script src = "../js/jquery-1.8.3.min.js"></script>
	<script src="../js/less.js" type="text/javascript"></script>
	<script>
		function setCookie() {
			if($("#remember").is(":checked")){
				localStorage.vowcher_username = $("#username").val();
			}
		}
		
		if(localStorage.vowcher_username != undefined) {
			var username = localStorage.vowcher_username;
			window.location = "dashboard.jsp?username="+username;
		}
	</script>
</head>
<body>
	<%
		if(session.getAttribute("sessionUser") != null){
			response.sendRedirect("dashboard.jsp");
			return;
		}
	%>
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
										<input type = "hidden" name = "redirect" value = "<%= request.getParameter("redirect_to") %>">
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
</body>
</html>