		<div class = "footer">
			<small>
				<span id = "copyright">Copyrights Protected &copy; 2013</span>
				<script>

				function changelanguage(){
						$.ajax({
							url:"../server/switch_language.jsp",
							success:function(msg){
								if(msg.indexOf("hin") >= 0){
									$(".to-hindi").each(function(){
										var e = $(this);
										$.ajax({
											url:"../server/convert_language.jsp",
											data:"word="+e.html(),
											type:"GET",
											success:function(msg){
												e.attr("title",e.html());
												e.html(msg);
												e.css("font-size","17px");
												$("#welcome-text").css("font-size","24px");
												e.css("font-spacing","1px");
											}
										});
									});	
									$("#language").html("English");
								}
								else if(msg.indexOf("eng") >= 0){
									$(".to-hindi").each(function(){
										$(this).html($(this).attr("title"));
										$(this).css("font-size","14px");
										$("#welcome-text").css("font-size","21px");
									});
									$("#language").html("&#2361;&#2367;&#2306;&#2342;&#2368;");
								}
							}
						});
				}
				
				</script>
				<%
					String lang = "&#2361;&#2367;&#2306;&#2342;&#2368;";
					if(session.getAttribute("lang").equals("hin")){
						lang = "English";	
					}
				%>			
				<span id = "links"><span style = 'font-size:18px'><a href="#" onClick= "changelanguage()"id = "language" value="<%=lang %>"> <%=lang %> </a></span> | About | Contact</span>
			</small>
		</div>
	</body>  
</html>