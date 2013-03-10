<%@ page import="utility.Utility,user.User,auth.Authentication,java.text.*,java.util.*,java.sql.Timestamp" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%
	String values[] = new String[14];
	int i =0;
	String path = "";
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
	} else {
    	FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
        	items = upload.parseRequest(request);
        } 
        catch (FileUploadException e) {
        	e.printStackTrace();
        }
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
	        FileItem item = (FileItem) itr.next();
	        if (item.isFormField()) {
	        		values[i++] = item.getString();
	        } 
	        else {
	        	try {	        		
		            String itemName = item.getName();
		            path = config.getServletContext().getRealPath("/")+"uploads/"+itemName;
		            File savedFile = new File(path);
		            item.write(savedFile);
		            
	                          
	            } catch (Exception e) {
	            	e.printStackTrace();
	            }
	       	}
    	}
  	}
	
	//create new login
	Authentication new_login = new Authentication();
	
	new_login.setUserid(values[0]);
	new_login.setPassword("asdf"); //later change it to random
	new_login.setRole("emp");
	new_login.setLastlogin();
	new_login.setSecureId(""); //OAuth ID is initially null
	
	boolean login_success = new_login.save();
	
	
	//create new user
	User user = new User();
	
	user.setUserid(values[0]);
	user.setFirstName(values[1]);
	user.setMiddleName(values[2]);
	user.setlastName(values[3]);
	user.setSocialSecurity(values[4]);
	
	SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
	Date d1 = fmt.parse(values[5]);
	
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String d2 = fmt2.format(d1);
	
	user.setDate(d2);
	
	user.setGender(values[6]);
	user.setDeptid(Integer.parseInt(values[7]));
	user.setDesignation(values[8]);
	user.setAddress(values[9]);
	user.setPhone(values[10]);
	user.setMobile(values[11]);
	user.setEmail(values[12]);
	user.setPhoto(path);
	
	boolean user_success = user.save();
	
	if(user_success && login_success){
		response.sendRedirect("../pages/user_view.jsp?status=" + Utility.MD5("success") + "&userid="+values[0]);
		return;
	}
	else {
		response.sendRedirect("../pages/user_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>