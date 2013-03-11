<%@ page import="utility.Utility,voucher.Voucher,voucher.Type,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ include file = "server_authenticate.jsp" %>
<%
	String values[] = new String[6];
	
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
	        		values[i] = item.getString();
	        		i++;
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
	
	Voucher voucher = new Voucher();
	voucher.setTitle(values[0]);
	
	User user = (User)session.getAttribute("sessionUser");
	voucher.setUserid(user.getUserid());
	
	voucher.setAmount(Float.parseFloat(values[1]));
	voucher.setVtypeid(Integer.parseInt(values[2]));
	
	SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
	Date d1 = fmt.parse(values[3]);
	
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String d2 = fmt2.format(d1);
	
	voucher.setDate(d2);
	
	voucher.setDescription(values[4]);
	voucher.setAttachment(path);
	
	boolean voucher_success = voucher.save();
	
	if(voucher_success)
	{
		//delete the draft
		if(!values[5].equals("")){
			File draft_file = new File(config.getServletContext().getRealPath("/")+"drafts/"+values[5]);
			draft_file.delete();
		}
		response.sendRedirect("../pages/voucher_add.jsp?status=" + Utility.MD5("success"));
		return;
	}
	else {
		response.sendRedirect("../pages/voucher_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>