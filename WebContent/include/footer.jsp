		<div class = "footer">
			<small>
				<span id = "copyright">Copyrights Protected &copy; 2013</span>
				<%
					String lang = "&#2361;&#2367;&#2306;&#2342;&#2368;";
					String qstr = "";
					if(request.getQueryString() != null) {
						qstr = "?" + request.getQueryString();
					}
					String langmode = "hin&redirect=" + request.getRequestURL() + qstr;
					if(session.getAttribute("lang").equals("hin")){
						lang = "English";	
						langmode = "eng&redirect=" + request.getRequestURL() + qstr;
					}
				%>			
				<span id = "links"><span style = 'font-size:18px'><a href = "../server/switch_language.jsp?lang=<%=langmode%>"> <%=lang %> </a></span> | About | Contact</span>
			</small>
		</div>
	</body>  
</html>