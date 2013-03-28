<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="utility.Utility" %>
<%@ include file = "../include/layout.jsp" %>

<title>Vowcher - Feeback</title>
<div id="body-content">
<%if(request.getParameter("status") != null) {
	if(request.getParameter("status").equals(Utility.MD5("success"))){
		%> <div class = "alert alert-success">
			<button class="close" data-dismiss="alert" type="button">×</button>
			Thank you for your feedback
		</div> <%
	}
}
%> 
	<form method = "POST" action = "../server/feedback.jsp" class = "validate">
		<fieldset>
			<legend>
				Feedback 
				<p class="legend-desc">
					<i class="icon-question-sign"></i>
					Please send us your feeback, to serve you better. 
				</p>
			</legend>
			<br /> <input type="text" class="span4 required" valtype = "required alphawithspace" valmsg="Name should contain only alphabets" id="name"
				placeholder="Your Name ..." name = "name"><br />
				<input class = "span4 required" type="text" id = "email" name = "email" valtype = "email required" valmsg="Invalid e-mail id" placeholder="You Email ..."><br>
			<textarea rows="5" cols="50"  placeholder="Feedback ..." name = "feedback"></textarea>
			<br /></fieldset>
			<button type = "submit" class = "btn btn-success"><i class = "icon-white icon-envelope"></i>Send Feedback</button>
	</form>
</div>