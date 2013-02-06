$(document).ready(function(){
	/** Required field error check **/
	
	$(".validate").submit(function(){
		
		$(".alert-error").remove();
		
		$("[valtype~='required']").each(function(index,element){
			if($(this).val() == '') {
				$("form").prepend("<div class = 'alert alert-error'>One or more required fields left empty.</div>");
				return false;
			}
		});
		
		if($(".alert-error").html() == undefined){
			return true;
		}
		else {
			return false;
		}
	});
	
	/** Required field error check ends **/
	
	
	/** Number fields **/
	
	$("[valtype~='number']").blur(function(){
		if($(this).val() == '') { return ;}
		
		var element;
		var valmsg = $(this).attr('valmsg');		
		if($(this).attr('class').indexOf('prepend-input') >= 0 || $(this).attr('class').indexOf('append-input') >= 0)
			element = $(this).parent();
		else
			element = $(this);
		
		$.ajax({
			type:"POST",
			data: "valtype=number&value=" + $(this).val(),
			url: "../server/validation.jsp",
			success:function(msg){
				if(msg.indexOf("false") >= 0){
					if(element.parent().find("> .text-error").html() == undefined) {
						element.wrap("<div class = 'control-group error'></div>");
						element.after("<span class = 'text-error'>" + valmsg + "</span>");
					}
				}
				else {					
					if(element.parent().attr('class').indexOf('control-group') >= 0) {
						element.parent().find("> .text-error").remove();
						element.unwrap();
					}
				}
			}
		});
	});
	
	/** Number fields **/
});