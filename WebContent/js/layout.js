$(document).ready(function(){
	$("#body-content").css("display","none");
	$(".span9").html($("#body-content").html());
	
	//required fields
	$(".required").wrap("<span class = 'required_marker' />");
	$(".required_marker").append("*");
	
});