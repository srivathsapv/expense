<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "utility.Utility"%>
<%@ include file = "../include/layout.jsp" %>
<script>
	$(document).ready(function(){
		$(".refresh").click(function(){
			$("img[src='../captchaImg']").attr("src","../captchaImg");
		});
	});
</script>
<title>Vowcher - Change Password</title>
<div id = "body-content">
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button>Password changed successfully</div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("error"))) {
				%> <div class = "alert alert-error">Error while changing password</div> <%	
			}	
		}
	%>
	<form method = "POST" class="validate" action = "../server/change_password.jsp">
  		<fieldset>
    		<legend>
    			Password Change
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Change your current password by providing the following details</p>
    		</legend><br>
			<input class = "span4 required" valtype="required check_old" id = "old" type="password" placeholder="Enter the current password..."> <br>
			<input class = "span4 required" valtype="required pass_length" id = "curr" type="password" name = "password" valmsg = "Password should contain at least 6 characters" placeholder="Enter the new password..."><br>
			<input class = "span4 required" valtype="required pass_length" id = "confirm" type="password" valmsg = "Password should contain at least 6 characters" placeholder="Confirm password..."><br>
			
			<img src = "../captchaImg" class = "img-polaroid"><i class = "refresh icon-refresh poi"></i><br><br>
    		<input type = "text" class = "span4 required" valtype = "required" placeholder = "Enter the code shown above..." valmsg = "Code entered is incorrect" name = "captcha"><br><br>
			<input type="submit" class="btn btn-info" value = "Change Password">
		</fieldset>
	</form>
</div>