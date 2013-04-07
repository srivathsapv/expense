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
				<span id = "links"><span style = 'font-size:18px;text-decoration:none'><a href="../server/switch_language.jsp" id = "language" value="<%=lang %>"> <%=lang %> </a> </span>| <a href = "about_us.jsp">About Us</a> | <a href = "contact_us.jsp">Contact Us</a> | <a href = "feedback.jsp"> Feedback</a> | <a target = "_blank" href = '../help.pdf'>Help</a></span>
			</small>
		</div>
	</body>
	<style>
		#links > a {
			color: white;
			text-decoration:none;
			cursor:pointer;
		}
	</style>  
</html>