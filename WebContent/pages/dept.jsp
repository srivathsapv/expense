<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "../include/layout.jsp"/> 
<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			Add new department
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the new department in the company</p>
    		</legend><br>
    		<input class = "span4" type="text" placeholder="Enter the department name..."><br>
    		<input class = "span4" type="text" placeholder="Enter the shortform for the department..."><br>
    		<textarea rows="5" cols = "50" placeholder="Enter a description..."></textarea><br>
    		<br><br><button type="submit" class="btn btn-info">Submit</button>
    	</fieldset>
	</form>
</div>
