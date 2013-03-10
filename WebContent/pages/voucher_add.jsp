<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.Type,
    							   javax.xml.parsers.DocumentBuilderFactory,
    							   javax.xml.parsers.DocumentBuilder,
    							   org.w3c.dom.Document,
    							   org.w3c.dom.NodeList,
    							   org.w3c.dom.Node,
    							   org.w3c.dom.Element,
    							   java.io.File"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Add New Voucher</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script src = "../js/tiny_mce/tiny_mce.js"></script>
<script src = "../js/bootstrap-alert.js"></script>
<%
	String hello = "hey";
%>
<script type = "text/javascript">
	$(document).ready(function(){
		$("#date").datepicker({format: 'dd-mm-yyyy'});
		
		$("#description").blur(function(){
			alert($(this).val());
		})
		
		$("#draft").click(function(){
			
			var concText = $("#title").val() + $("#amount").val() + $("#type").val()
						   + $("#date").val();
			
			if(concText != '' || $("#description").val().length > 30){
				$.ajax({
					type:"POST",
					data : "title="+$("#title").val()+"&amount="+$("#amount").val() 
							+ "&type="+$("#type").val() + "&date="+$("#date").val()
							+ "&description="+tinyMCE.activeEditor.getContent(),
					url: "../server/create_draft.jsp",
					success:function(msg){
						if($("#draft-save-alert").html() == undefined && msg.indexOf("saved") >= 0){
							$("form").prepend('<div id = "draft-save-alert" class = "alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button>Draft saved successfully</div>');	
						}
						
					}
				});
			}
		});
		
		$("#discard-draft").click(function(){
			$.ajax({
				type:"POST",
				data : "filename=<%=request.getParameter("filename")%>",
				url: "../server/delete_draft.jsp",
				success:function(msg){
					window.location = "dashboard.jsp";
				}
			});
		});
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
	<%
		String mode = "";
		String title="";String amount="";String type="";String date="";String description="";
		if(request.getParameter("mode") != null){
			mode = request.getParameter("mode");
		}
		if(mode.equals("drafts")){
			String filename = request.getParameter("filename");
			String path = config.getServletContext().getRealPath("/")+"drafts/"+filename;
			File fXmlFile = new File(path);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
		 	
			title = doc.getElementsByTagName("title").item(0).getTextContent();
			amount = doc.getElementsByTagName("amount").item(0).getTextContent();
			type = doc.getElementsByTagName("type").item(0).getTextContent();
			date = doc.getElementsByTagName("date").item(0).getTextContent();
			description = doc.getElementsByTagName("description").item(0).getTextContent();
			description = description.replace("<","&lt;");
			description = description.replace(">","&gt;");
			description = description.replace("/","&#47");
		}
	%>
	<form method = "POST" class="validate" action = "../server/voucher_add.jsp" enctype="multipart/form-data">
  		<fieldset>
    		<legend>
    			Add new voucher
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter details about your voucher and submit to claim your expenses</p>
    		</legend><br>
    		
    		<input class = "span4 required" valtype = "required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" type="text" id = "title" name = "title" placeholder="Enter a title..." value = "<%=title%>">
    		
    		<div class="input-prepend">
				<span class="add-on rupee">`</span>
			  	<input class="span4 prepend-input required prependedInput" valtype="decimal required" valmsg="Decimal value with precision of 2 is expected" id = "amount" name = "amount" type="text" placeholder="Enter the amount..." value = "<%=amount%>">
			</div>
   			<select class = "span4" id = "type" name = "type">
   				<option value = "">Choose Voucher Type</option>
   				<%
   					Type[] types = Type.list("","");
   					for(Type t : types) {
   						if(mode.equals("drafts")) {
   							if(t.getVtypeid() == Integer.parseInt(type)){
   								%> <option value = "<%= t.getVtypeid() %>" selected = "true"><%= t.getTitle() %></option> <%
   							}
   							else {
   								%> <option value = "<%= t.getVtypeid() %>"><%= t.getTitle() %></option> <%
   							}
   						}
   					}
   				%>
   			</select><br>
   			<div class = "input-append">
   				<input type="text" class="span4 append-input" placeholder="Select the date..." id="date" name = "date" value = "<%=date%>">
   				<span class = "add-on"><i class="icon-calendar"></i></span>
   			</div>
   			<label>Enter Description</label>
   			<textarea rows="10" cols = "50" id = "description" name = "description"><%=description %></textarea><br>
			<label>Upload Attachment</label><input class = "span4" type="file" id = "attachment" name = "attachment">			
    		<br><input type="submit" class="btn btn-info" value = "Add Voucher">
    		<input type = "button" id="draft" class = "btn btn-warning" value = "Save Draft">
    		<%
    			if(mode.equals("drafts")) {
    				%> <input type = "button" id="discard-draft" class = "btn btn-danger" value = "Discard Draft"> <%
    			}
    		%>
  		</fieldset>
	</form>
	
</div>
