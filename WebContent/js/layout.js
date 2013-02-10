$(document).ready(function(){
	$("#body-content").css("display","none");
	$(".span9").html($("#body-content").html());
	$("#body-content").remove();
	
	//required fields	
	var element=$(".required");
	/*if($(element).parent().attr('class').indexOf('input-append') >= 0)
	{
		alert($(element).parent().attr('class').indexOf('input-append'));
	}
	else{*/
	$(element).wrap("<span class = 'required_marker' />");
	$(".required_marker").append("*");
	//}
});
