$(document).ready(function(){
	$("#body-content").css("display","none");
	$(".span9").html($("#body-content").html());
	$("#body-content").remove();
	
	//required fields	
	var element=$(".required");
	$(element).wrap("<span class = 'required_marker' />");
	$(".required_marker").append("*");
	
});
