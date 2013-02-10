<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<title>Vowcher - Add New Policy</title>
<%@ include file = "../include/layout.jsp" %>
<div id = "body-content">
	<form method = "POST" class="validate">
  		<fieldset>
    		<legend>
    			Add new policy
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to create a new policy</p>
    		</legend><br> 
			<input class = "span4 required" type="text" valtype="required alphanumericwithspace" valmsg="Invalid title" placeholder="Enter the title..."> <br>
			<textarea class="span4" rows="5" cols = "50" placeholder="Enter description..."></textarea><br>
			<div class = "input-append">
   				<span class="required"><input type="text" class="span4 append-input" valtype="required number" valmsg="Numeric value expected" placeholder="Amount Percentage" id="dp1" ><span class = "add-on" style="color:black;">%</span></span>	
   			</div>	
   			<br>
	Available:
	<label class="radio"><input type="radio" name="available?" value="yes" checked>Yes</label>
	<label class="radio"><input type="radio" name="available?" value="No" >No</label>
	<br/><input type="submit" class="btn btn-info" value = "Add Policy">	
	</fieldset>
	</form>
</div>