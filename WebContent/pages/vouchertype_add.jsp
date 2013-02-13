<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - New Voucher Type</title>
<script src = "../js/bootstrap-multiselect.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
      $('.multicheck').click(function(e) {     
         $(this).toggleClass("checked"); 
         $(this).find("span").toggleClass("icon-ok"); 
         return false;
      });
      
      $("#policy").multiselect();
    });
    </script>

<div id="body-content">
	<form method = "POST">
		<fieldset>
			<legend>
				Create New Voucher Type
				<p class="legend-desc">
					<i class="icon-question-sign"></i>Enter details about the new
					voucher type
				</p>
			</legend>
			<br /> <input type="text" class="span4 required" valtype = "required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" id="voucher_name"
				placeholder="Enter voucher name..."><br />
			<textarea rows="5" cols="50" placeholder="Enter a description..."></textarea>
			<br />
			<select id = "policy" multiple="multiple">
				<option value = "policy1">Policy 1</option>
				<option value = "policy2">Policy 2</option>
				<option value = "policy3">Policy 3</option>
				<option value = "policy4">Policy 4</option>
				<option value = "policy5">Policy 5</option>
			</select>
			<br /> <br />
			<input type = "submit" class = "btn btn-info" value = "Add Voucher Type">
		</fieldset>
	</form>
</div>