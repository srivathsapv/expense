<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import = "policy.Policy,utility.Utility" %>
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
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">Voucher type added successfully</div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("error"))) {
				%> <div class = "alert alert-error">Error while adding voucher type</div> <%	
			}	
		}
	%>
	<form method = "POST" action = "../server/vouchertype_add.jsp" class = "validate">
		<fieldset>
			<legend>
				Create New Voucher Type
				<p class="legend-desc">
					<i class="icon-question-sign"></i>Enter details about the new
					voucher type
				</p>
			</legend>
			<br /> <input type="text" class="span4 required" valtype = "required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" id="voucher_name"
				placeholder="Enter the Title ..." name = "title"><br />
			<textarea rows="5" cols="50" placeholder="Enter a description..." name = "description"></textarea>
			<br />
			<label>Policy</label>
			<select id = "policy" name = "policy" multiple="multiple">
				<%
					Policy[] policies = Policy.list("","");
					for(Policy p : policies) {
						%> <option value = "<%= p.getPolicyid() %>"><%= p.getTitle() %></option> <%
					}
				%>
			</select>
			<br /> <br />
			<input type = "submit" class = "btn btn-info" value = "Add Voucher Type">
		</fieldset>
	</form>
</div>