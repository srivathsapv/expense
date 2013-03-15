<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "voucher.Type,
    							   voucher.Voucher,
    							   javax.xml.parsers.DocumentBuilderFactory,
    							   javax.xml.parsers.DocumentBuilder,
    							   org.w3c.dom.Document,
    							   org.w3c.dom.NodeList,
    							   org.w3c.dom.Node,
    							   org.w3c.dom.Element,
    							   java.io.File,
    							   java.text.SimpleDateFormat,
    							   java.util.Date,
    							   voucher.vouchertype.Department"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - Add New Voucher</title>
<link rel = "stylesheet" href = "../less/datepicker.css">
<script src = "../js/bootstrap-datepicker.js"></script>
<script src = "../js/tiny_mce/tiny_mce.js"></script>
<script src = "../js/bootstrap-alert.js"></script>
<script type = "text/javascript">
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
		
		$("#attachment").change(function(){
			var filename = $(this).val();
			var ext = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			ext = ext.toLowerCase();
			
			if(!(ext == "doc" || ext == "docx" || ext == "jpeg" || ext == "pdf" || ext == "jpg" || ext =="png")) {
				alert("." + ext + " files are not allowed");
				$(this).val("");
			}
		});
		
		$("#existing-voucher").click(function(){
			$(".existing-option").attr("style","display:block");
		});
		
		$("#start-existing").click(function(){
			window.location = "voucher_add.jsp?mode=from_existing&vid="+$("#voucher-list").val();
		});
		
		$("#new-voucher").click(function(){
			$("#button-options").attr("style","display:none");
			$("form").attr("style","display:block");
		});
		
	});
	
	
</script>
<div id = "body-content">
	<%
		String mode = "";
		String title="";String amount="";String type="";String date="";String description="";
		String filename="";
		if(request.getParameter("mode") != null){
			mode = request.getParameter("mode");
		}
		if(mode.equals("drafts")){
			filename = request.getParameter("filename");
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
		else if(mode.equals("from_existing")){
			int vid = Integer.parseInt(request.getParameter("vid"));
			Voucher exist_voucher = new Voucher(vid);
			title = exist_voucher.getTitle();
			amount = Double.toString(exist_voucher.getAmount());
			type = Integer.toString(exist_voucher.getVtypeid());
			date = exist_voucher.getDate();
			description = exist_voucher.getDescription();
			description = description.replace("<","&lt;");
			description = description.replace(">","&gt;");
			description = description.replace("/","&#47");
		}
		
		if(!date.equals("")){
			SimpleDateFormat f1 = new SimpleDateFormat("yyyy-mm-dd");
			Date d = f1.parse(date);
			
			SimpleDateFormat f2 = new SimpleDateFormat("dd-mm-yyyy");
			date = f2.format(d);
		}
		
		String form_style = "none";
		String option_style = "block";
		
		if(!mode.equals("")){
			form_style = "block";
			option_style = "none";
		}
	%>
   		<legend>
   			Add new voucher
   			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter details about your voucher and submit to claim your expenses</p>
   		</legend>
   		<div id = "button-options" style = "display:<%=option_style%>">
   		   	<button class = "btn btn-info" id = "new-voucher">Create a new voucher</button>
   			<h4>OR</h4>
   			<button class = "btn btn-info" id = "existing-voucher">Create from an existing voucher</button><br><br>
   			<div class = "existing-option" style = "display:none">
   				<select class = "span4" id = "voucher-list">
	   				<option value = "">Select a voucher</option>
	   				<%
	   					Voucher[] existing_vouchers = Voucher.list("userid","sriv",0);
	   					if(vouchers.length > 0){
	   						for(Voucher v:existing_vouchers){
	   							%><option value = "<%=v.getVoucherid()%>"><%=v.getTitle() %></option> <%
	   						}
	   					}
	   				%>
	   			</select>
	   			<button class = "btn btn-success" id = "start-existing">Go</button>
   			</div>
   		</div>
    	<form style = "display:<%=form_style %>" method = "POST" class="validate" action = "../server/voucher_add.jsp" enctype="multipart/form-data">
    		<fieldset>		
    		<input class = "span4 required" valtype = "required alphanumericwithspace" valmsg="Title should contain only alphanumeric values" type="text" id = "title" name = "title" placeholder="Enter a title..." value = "<%=title%>">
    		
    		<div class="input-prepend">
				<span class="add-on rupee">`</span>
			  	<input class="span4 prepend-input required prependedInput" valtype="decimal required" valmsg="Decimal value with precision of 2 is expected" id = "amount" name = "amount" type="text" placeholder="Enter the amount..." value = "<%=amount%>">
			</div>
   			<select class = "span4 required" id = "type" name = "type">
   				<option value = "">Choose Voucher Type</option>
   				<%
   					
   					User sUser = (User)session.getAttribute("sessionUser");
   					Department[] vtypedepts = Department.list("DEPTID",Integer.toString(sUser.getDeptid()));
   					
   					for(Department d:vtypedepts) {
   						Type t = new Type(d.getVtypeid());
   						if((mode.equals("drafts") || mode.equals("from_existing")) && !type.equals("")) {
   							if(t.getVtypeid() == Integer.parseInt(type)){
   								%> <option value = "<%= t.getVtypeid() %>" selected = "true"><%= t.getTitle() %></option> <%
   							}
   						}
						else {
 							%> <option value = "<%= t.getVtypeid() %>"><%= t.getTitle() %></option> <%
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
			<label>Upload Attachment (doc,docx,pdf,jpg,jpeg,png)</label><input class = "span4" type="file" id = "attachment" name = "attachment"><br>			
    		<br><input type="submit" class="btn btn-info" value = "Add Voucher">
    		<input type = "button" id="draft" class = "btn btn-warning" value = "Save Draft">
    		<%
    			if(mode.equals("drafts")) {
    				%> <input type = "button" id="discard-draft" class = "btn btn-danger" value = "Discard Draft"> <%
    			}
    		%>
    		<input type = "hidden" name = "draft_filename" id = "draft_filename" value = "<%= filename %>">
  		</fieldset>
	</form>
</div>
