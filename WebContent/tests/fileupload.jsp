<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (!isMultipart) {
} else {
          FileItemFactory factory = new DiskFileItemFactory();
          ServletFileUpload upload = new ServletFileUpload(factory);
          List items = null;
          try {
                  items = upload.parseRequest(request);
          } catch (FileUploadException e) {
                  e.printStackTrace();
          }
          Iterator itr = items.iterator();
          while (itr.hasNext()) {
          FileItem item = (FileItem) itr.next();
          if (item.isFormField()) {
          } else {
                  try {
                          String itemName = item.getName();
                          String path = config.getServletContext().getRealPath("/")+"uploads/"+itemName;
                          File savedFile = new File(path);
                          item.write(savedFile);  
                          
                          
                          
                  } catch (Exception e) {
                          e.printStackTrace();
                  }
          }
          }
  }
%>