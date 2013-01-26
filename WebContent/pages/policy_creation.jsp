<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>new policy </title>

<jsp:include page = "../include/layout.jsp"/>

<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			Add new policy
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details given below to create a new policy</p>
    		</legend><br>


<div id = "body-content"> 
<input class = "span4" type="text" placeholder="Enter the title...">
	<div class = "input-append">
	<textarea rows="5" cols = "50" placeholder="Enter the description..."></textarea><br>
	
			  	<input class="span4 prepend-input" id="prependedInput" type="text" placeholder="Enter the amount percent...">
			</div>
	<label>Available</label> 
	<input class="span4" type="checkbox" > <label>Yes</label> <br>
	<input class="span4" type="checkbox" > <label>No</label>
	<br><button type="Save" class="btn btn-info">Save</button>
<button type="Cancel" class="btn btn-info">Cancel</button>
	
	</fieldset>
	</form>
</div>