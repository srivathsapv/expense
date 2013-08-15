<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utility.Utility,backupandrestore.BackupAndRestore"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Backup and Restore</title>
<script type = "text/javascript" src = "../js/bootstrap-collapse.js"></script>
<style>
	.accordion legend {
		font-size:14px!important;
	}
</style>
<script type = "text/javascript">
$(document).ready(function(){
	$(".btn").click(function(){
		window.location = $(this).attr("alt");
	});
});
</script>

<div id= "body-content">
<%
		if(request.getParameter("status") != null) {
			if(request.getParameter("status").equals(Utility.MD5("backup-success"))){
				%> <div class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button>Backup taken successfully</div> <%
			}
			else if(request.getParameter("status").equals(Utility.MD5("backup-error"))) {
				%> <div class = "alert alert-error">Error while taking backup</div> <%	
			}else if(request.getParameter("status").equals(Utility.MD5("restore-success"))){
				%> <div class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button>Restored successfully</div> <%
			}else if(request.getParameter("status").equals(Utility.MD5("restore-error"))) {
				%> <div class = "alert alert-error">Error while restoring</div>
				 <%	}
		}

	%>
    <legend>
    	Backup and Restore
    </legend><br>
    <div class="accordion" id="accordion2">
	<div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse1">
	         Backup 
	      </a>
	    </div>
	    <div id="collapse1" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Backup data to prevent information loss.
	       	</legend>
	       <% BackupAndRestore bk = new BackupAndRestore();
	       String date = bk.lastBackupDate();
	       if(!date.isEmpty()){
	       %><p>Last Backup taken: <%= date %></p>
	       <%}else{%>
	       <p>No Backup taken yet.</p>
	       <%}%>
	       	</br>
	       	<button class = "btn btn-success" alt = "../server/backupandrestore.jsp?action=backup"><i class = "icon-white icon-cog"></i>Take Backup</button>
	      </div>
	    </div>
	  </div>  
	  <div class="accordion-group">
	    <div class="accordion-heading">
	      <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse2">
	         Restore
	      </a>
	    </div>
	    <div id="collapse2" class="accordion-body collapse">
	      <div class="accordion-inner">
	       	<legend>
	       		<i class = "icon-question-sign"></i>
	       		Restore data from previous backup.
	       	</legend>
	       	<button class = "btn btn-warning" alt = "../server/backupandrestore.jsp?action=restore"><i class = "icon-white icon-wrench"></i>Restore</button>
	      </div>
	    </div>
	  </div>  
	  </div>
	</div>
