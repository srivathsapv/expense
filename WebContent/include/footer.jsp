		<div class = "footer">
			<small>
				<span id = "copyright">Copyrights Protected &copy; 2013</span>

				<%
					String lang = "&#2361;&#2367;&#2306;&#2342;&#2368;";
					if(session.getAttribute("lang").equals("hin")){
						lang = "English";	
					}
					
					String redirect = request.getRequestURL().toString();
					if(request.getQueryString() != null){
						redirect += "?" + request.getQueryString();
					}
					session.setAttribute("redirectAfterLangChange",redirect);
				%>			
				<span id = "links"><span style = 'font-size:18px'><a href="../server/switch_language.jsp" id = "language" value="<%=lang %>"> <%=lang %> </a></span> | About | Contact</span>
			</small>
		</div>
	</body>  
</html>