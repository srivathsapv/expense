<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,report.Report"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Generate Reports</title>
<script type = "text/javascript" src = "../js/bootstrap-collapse.js"></script>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<style>
	legend {
		font-size:14px!important;
	}
</style>
<script type = "text/javascript">
$(document).ready(function(){
	$("#Fromdate").datepicker({format: 'dd-mm-yyyy'});
	$("#Todate").datepicker({format: 'dd-mm-yyyy'});
	$(".generate").click(function(){
		window.location = $(this).attr("alt") + "&title=" + $("#report-title").val() + "&description=" + $("#description").val();
	});
	
	$(".generate-ledger").click(function(){
		window.location = $(this).attr("alt")+"&title=" + $("#report-title").val() + "&year="+$("#year").val()+"&month="+$("#month").val() + "&description=" + $("#description").val();
	});
	
	$(".generate-MDM").click(function(){
		window.location = $(this).attr("alt")+"&title=" + $("#report-title").val() + "&subType="+$("#MDMsubType").val() + "&description=" + $("#description").val();
	});
	
});
</script>
<div id = "body-content">
	<h1>Reports</h1>
	<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("success"))){
				%> <div class = "alert alert-success">
					<button class="close" data-dismiss="alert" type="button">×</button>
					<%= request.getParameter("message") %><br>
					View the generated file 
					<a target = "_blank" href = "../server/report_view.jsp?id=<%=request.getParameter("reportid") %>">here</a>
				</div> <%
			}
		}
	%>
	<input type = "text" id = "report-title" placeholder = "Enter title..."><br>
	<textarea id = "description" placeholder = "Enter a short description..."></textarea>
	<h4>Report Type</h4>
	<div class="accordion" id="accordion2">
	  <%
	  	String role = session.getAttribute("sessionUserRole").toString();
	  	if(role.equals("admin") || role.equals("md") || role.equals("ceo")) {
	  %>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse1">
	         MIS Report 
	      </a>
	    </div>
	    <div id="collapse1" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Management Information System report that gives graphical information of vouchers in various statuses.
	       	</legend>
	       	<button class = "btn btn-success generate" alt = "../server/report_generate.jsp?reportType=MIS_Report"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse2">
	         Exception Report 
	      </a>
	    </div>
	    <div id="collapse2" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Graphical representation of the number of vouchers awaiting approval in each month.
	       	</legend>
	       	<button class = "btn btn-success generate" alt = "../server/report_generate.jsp?reportType=Exception_Report"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse3">
	         Rejected Voucher Report 
	      </a>
	    </div>
	    <div id="collapse3" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Detailed information about the rejected vouchers
	       		and the reason for rejection.
	       	</legend>
	       	<button class = "btn btn-success generate" alt = "../server/report_generate.jsp?reportType=Rejected_Voucher_Report"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse4">
	        Voucher Type Report
	      </a>
	    </div>
	    <div id="collapse4" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Detailed information about the amount claimed under each voucher type.
	       	</legend>
	       	<button class = "btn btn-success generate" alt = "../server/report_generate.jsp?reportType=Voucher_Type_Report"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse7">
	        Company Policy
	      </a>
	    </div>
	    <div id="collapse7" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Graphical information about the claims made under each policy.
	       	</legend>
	       	<button class = "btn btn-success generate" alt = "../server/report_generate.jsp?reportType=Company_Policy_Report"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse6">
	         Master Data Management Reports
	      </a>
	    </div>
	    <div id="collapse6" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		A detailed master report which is categorized under the following types.
	       	</legend>
	       	<div> 
	       	<select id="MDMsubType" class="span4">
		       	<option value = "AMOUNT_CONFIG">Amount Configuration Master</option>
		       	<option value = "DEPARTMENT">Departments Master</option>
		       	<option value = "POLICY">Policies Master</option>
		       	<option value = "ROLECONFIG">Role Configuration Master</option>
		       	<option value = "USER">Users Master</option>
		       	<option value = "VOUCHER">Vouchers Master</option>
		       	<option value = "VOUCHER_TYPE">Voucher Types Master</option>
	       	</select>
	       	</div>
	       	<button class = "btn btn-success generate-MDM" alt = "../server/report_generate.jsp?reportType=Master_Data_Management_Reports"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>
	  <% } %>
	  <% if(role.equals("finance"))  { %>
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse5">
	         Ledger
	      </a>
	    </div>
	    <div id="collapse5" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Financial ledger for the specified time period. Give the From and To dates as input
	       		to the report.
	       	</legend>
	       	<div>
	       		<select id = "month" class = "span4">
	       			<option value = "01">January</option>
	       			<option value = "02">February</option>
	       			<option value = "03">March</option>
	       			<option value = "04">April</option>
	       			<option value = "05">May</option>
	       			<option value = "06">June</option>
	       			<option value = "07">July</option>
	       			<option value = "08">August</option>
	       			<option value = "09">September</option>
	       			<option value = "10">October</option>
	       			<option value = "11">November</option>
	       			<option value = "12">December</option>
	       		</select>&nbsp;&nbsp;&nbsp;&nbsp;
	       		<select id = "year" class = "span4">
	       			<%
	       				for(int y=2013;y>=2000;y--){
	       					%> <option value = "<%=y%>"><%=y%></option><% 
	       				}
	       			%>
	       		</select>
	       	</div>
	       	<br/>
	       	<button class = "btn btn-success generate-ledger" alt = "../server/report_generate.jsp?reportType=Ledger"><i class = "icon-white icon-cog"></i>Generate</button>
	      </div>
	    </div>
	  </div>
	  <% } %>
	</div>
	