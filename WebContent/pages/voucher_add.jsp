<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Add New Voucher</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script src = "../js/tiny_mce/tiny_mce.js"></script>
<script type = "text/javascript">
	$(function(){
		$("#dp1").datepicker({format: 'dd-mm-yyyy'});	
	});
	
	tinyMCE.init({
        // General options
        mode : "textareas",
        theme : "advanced",
        plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

        // Theme options
        theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,|,bullist,numlist",
        theme_advanced_buttons2 : "link,unlink,image,|,forecolor,backcolor",
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        theme_advanced_resizing : true,

        // Skin options
        skin : "o2k7",
        skin_variant : "silver",

        // Drop lists for link/image/media/template dialogs
        template_external_list_url : "js/template_list.js",
        external_link_list_url : "js/link_list.js",
        external_image_list_url : "js/image_list.js",
        media_external_list_url : "js/media_list.js"
	});
</script>
<style>

</style>
<div id = "body-content">
	<form method = "POST" class="validate">
  		<fieldset>
    		<legend>
    			Add new voucher
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter details about your voucher and submit to claim your expenses</p>
    		</legend><br>
    		
    		<input class = "span4 required" valtype = "required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" type="text" placeholder="Enter a title...">
    		
    		<div class="input-prepend">
				<span class="add-on rupee">`</span>
			  	<input class="span4 prepend-input required" valtype="number required" valmsg="Numeric value expected" id="prependedInput" type="text" placeholder="Enter the amount...">
			</div>
   			<select class = "span4">
   				<option value = ''>Select Voucher Type</option>
   				<option value = 'type1'>Type1</option>
   				<option value = 'type2'>Type2</option>
   			</select><br>
   			<div class = "input-append">
   				<input type="text" class="span4 append-input" placeholder="Select the date..." id="dp1" >
   				<span class = "add-on"><i class="icon-calendar"></i></span>
   			</div>
   			<label>Enter Description</label>
   			<textarea rows="10" cols = "50"></textarea><br>
			<label>Upload Attachment</label><input class = "span4" type="file">			
    		<br><input type="submit" class="btn btn-info" value = "Add Voucher">
  		</fieldset>
	</form>
</div>