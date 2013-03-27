<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import = "policy.Policy,utility.Utility,user.Department,voucher.Type" %>
<%@ include file = "../include/layout.jsp" %>

<script src = "../js/bootstrap-multiselect.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
      $('.multicheck').click(function(e) {     
         $(this).toggleClass("checked"); 
         $(this).find("span").toggleClass("icon-ok"); 
         return false;
      });
      
      $("#policy").multiselect();
      $("#dept").multiselect();
    });
    </script>
<%
	int vtypeid = 0;
	String title = "Vowcher - Add Voucher Type";
	if(request.getParameter("mode") != null){
		vtypeid = Integer.parseInt(request.getParameter("vtypeid"));
		title = "Vowcher - Edit Voucher Type";
		Type type = new Type(vtypeid);
		%>
		<script>
			$.ajax({
				type:"POST",
				dataType:"json",
				url:"../server/json_api.jsp",
				data:"type=vtype&vtypeid=<%=vtypeid%>",
				success:function(msg){
					$("input[name='title']").val(msg.title);
					$("textarea").val(msg.description);
					$("#policy").val(msg.policyids);
					$("#policy").multiselect("refresh");
					$("#dept").val(msg.deptids);
					$("#dept").multiselect("refresh");
				}
			});
		</script> 
		<%
	}
%>
<title><%= title %></title>
<div id="body-content">
	<form method = "POST" action = "../server/vouchertype_add.jsp" class = "validate">
		<fieldset>
			<legend>
				Create New Voucher Type
				<p class="legend-desc">
					<i class="icon-question-sign"></i>Enter details about the new
					voucher type
				</p>
			</legend>
			<br /> <input type="text" class="span4 required" valtype = "required SpecialCharacters" valmsg="Title should contain only alphanumeric values" id="voucher_name"
				placeholder="Enter the Title ..." name = "title"><br />
			<textarea rows="5" cols="50" placeholder="Enter a description..." name = "description"></textarea>
			<br />
			<label><h4>Policies under which this voucher type can be submitted</h4></label>
			<select id = "policy" name = "policy" multiple="multiple">
				<%
					Policy[] policies = Policy.list("AVAILABLE","1");
					for(Policy p : policies) {
						%> <option value = "<%= p.getPolicyid() %>"><%= p.getTitle() %></option> <%
					}
				%>
			</select>
			<label><h4>Departments which can use this voucher type</h4></label>
			<select id = "dept" name = "dept" multiple = "multiple">
				<%
					Department[] depts = Department.list("","");
					for(Department d:depts){
						%> <option value = "<%= d.getDeptid() %>"><%= d.getDeptname() %></option><%
					}
				%>
			</select>
			<input type = "hidden" name = "mode" value = "<%=vtypeid%>">
			<br><br>
			<%
				if(vtypeid == 0) {
					%> <button type = "submit" class = "btn btn-success"><i class = "icon-white icon-plus"></i>Add Voucher Type</button> <%	
				}
				else {
					%> <button type = "submit" class = "btn btn-info"><i class = "icon-white icon-edit"></i>Save</button> <%
				}
			%>
		</fieldset>
	</form>
</div>