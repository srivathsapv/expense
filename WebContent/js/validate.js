var validated = false;

$(document).ready(function() {	
	/** Required field error check **/
	
	$(".validate").submit(function(){		
		$(".alert-error").remove();
		
		$("[valtype~='required']").each(function(index,element){
			if($(this).val() == '') {
				$("form").prepend("<div class = 'alert alert-error'>One or more required fields left empty.</div>");
				return false;
			}
		});
		if($(".alert-error").html() == undefined && $(".text-error").html() == undefined){
			return true;
		}
		else {
			return false;
		}
	});
	
	/** Required field error check ends **/
	
	/** Captcha field **/
	$("input[name='captcha']").blur(function(){
		if($(this).val() == '') { return; }
		ajaxcheck(this,'captcha');
	});
	/** Captcha field **/
	
	
	/** Number fields **/
	
	$("[valtype~='number']").blur(function(){
		if($(this).val() == '') { return; }
		ajaxcheck(this,'number');
		
	});
	/** Number fields **/
	
	/** Decimal Fields **/
	
	$("[valtype~='decimal']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'decimal');
		
	});
	
	/** Decimal fields **/
	
	
	/** Alphabet fields**/
	$("[valtype~='alpha']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'alpha');
		
	});
	/** Alphabet fields**/
	
	/** Alphabet with space fields**/
	$("[valtype~='alphawithspace']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'alphawithspace');
		
	});
	/** Alphabet with space fields**/
	
	/** Special Characters  **/
	$("[valtype~='SpecialCharacters']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'SpecialCharacters');
		
	});
	/** Special Characters **/
	
	/**Alphanumeric fields**/
	$("[valtype~='alphanumeric']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'alphanumeric');
		
	});
	/**Alphanumeric fields**/
	
	/**Alphanumeric with space fields**/
	$("[valtype~='alphanumericwithspace']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'alphanumericwithspace');
		
	});
	/**Alphanumeric with space fields**/
	
	/**Email fields**/
	$("[valtype~='email']").blur(function(){
		if($(this).val() == '') { return ;}
		ajaxcheck(this,'email');
		
	});
	/**Email fields**/
	
	/**Unique Username**/
	$("[valtype~='unique_username']").blur(function(){
		if($(this).val() == '') { return; }
		ajaxcheck(this,'unique_username');
		
	});
	/**Unique Username**/
	
	/**Check old password**/
	$("[valtype~='check_old']").blur(function(){
		if($(this).val() == '') { return; }
		ajaxcheck(this,'check_old');
	});
	/**Check old password**/
	
	/**Check password confirmation**/
	$("#confirm").blur(function(){
		if($(this).val() == ''){ return; }
		ajaxcheck(this,'confirm_password');
	});
	/**Check password confirmation**/
	
	/**Check password length**/
	$("[valtype~='pass_length']").blur(function(){
		if($(this).val() == '') { return; }
		ajaxcheck(this,'pass_length');
	});
	/**Check password length**/
});


function ajaxcheck(currentElement,type){
	var element;
	var valmsg = $(currentElement).attr('valmsg');		
	if($(currentElement).attr('class').indexOf('prepend-input') >= 0 || $(currentElement).attr('class').indexOf('append-input') >= 0 || $(currentElement).attr('class').indexOf('required') >= 0)
	{		
		element = $(currentElement).parent();
		try{
		if($(currentElement).parent().parent().attr('class').indexOf('input-prepend') >= 0)
			element = $(currentElement).parent().parent();
		if($(currentElement).parent().parent().parent().attr('class').indexOf('input-append') >= 0)
			element = $(currentElement).parent().parent().parent();
		}catch(err){
			//do nothing
		}
	}else
		element = $(currentElement);
	
	if(type == 'unique_username')
		valmsg = "Username already exists";
	else if(type == 'check_old')
		valmsg = "Old password is incorrect";
	else if(type == 'confirm_password') {
		valmsg = "Passwords do not match";
		element = $("#confirm");
	}
	
	$.ajax({
		type:"POST",
		data: "valtype="+type+"&value=" + $(currentElement).val(),
		url: "../server/validation.jsp",
		success:function(msg){
			if(type == 'confirm_password'){
				if($("#curr").val() != $("#confirm").val())
					msg = "false";
				else
					msg = "true";
			}
			if(msg.indexOf("false") >= 0){
				if(element.parent().find("> .text-error").html() == undefined) {
					element.wrap("<span class = 'control-group error'></span>");
					element.after("<div class = 'text-error'>" + valmsg + "</div>");
				}
				currentElement.focus();
			}
			else {
				try{
				if(element.parent().attr('class').indexOf('control-group') >= 0) {
					element.parent().find("> .text-error").remove();
					element.unwrap();
				}
				}catch(err){
					//do nothing
				}
			}
		}
	});
}