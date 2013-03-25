<%@ page import="user.Notification,utility.Utility,voucher.Voucher,voucher.Status,voucher.Type,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File,user.Notification" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.*,db.Db,java.sql.*,java.io.*" %>
<%
	String values[] = new String[7];
	
	int i =0;
	String path = "";
	String itemName = "";
	String ext = "";
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
		            itemName = item.getName();
		            if(!itemName.equals("")){
		            	path = config.getServletContext().getRealPath("/")+"uploads/"+itemName;
			            ext = itemName.substring(itemName.lastIndexOf(".")+1,itemName.length());
			            File savedFile = new File(path);
			            item.write(savedFile);	
		            }
	                          
	            } catch (Exception e) {
	            	e.printStackTrace();
	            }
	       	}
		}
	}
	User user = (User)session.getAttribute("sessionUser");
	
	Authentication auth = new Authentication(session.getAttribute("sessionUsername").toString());
	//check claim limit before proceeding
	Calendar cal = Calendar.getInstance();
	int month = cal.get(Calendar.MONTH)+1;
	String year = Integer.toString(cal.get(Calendar.YEAR));
	String mstr = "";
	
	if(month < 10) 
		mstr = "0" + Integer.toString(month);
	else
		mstr = Integer.toString(month);
	
	Db db = new Db();
	db.connect();
	
	ResultSet rs = db.executeQuery("SELECT SUM(AMOUNT) FROM VOUCHER WHERE USERID = '" + user.getUserid() + "' AND DATE LIKE '" + year + "-" + mstr + "-__'");
	rs.next();
	
	ResultSet rs2 = db.executeQuery("SELECT CLAIM_LIMIT FROM ROLECONFIG WHERE ROLE = '" + auth.getRole() + "'");
	rs2.next();
	
	if(rs.getInt(1) + Double.parseDouble(values[1]) > rs2.getInt(1) && values[6].equals("0")){
		response.sendRedirect("../pages/voucher_add.jsp?message=overlimit");
		return;
	}
	//claim limit check ends
	
	Voucher voucher = null;
	String modestr = "added";
	if(values[6].equals("0")){
		voucher = new Voucher();
	}
	else {
		voucher = new Voucher(Integer.parseInt(values[6]));
		modestr = "edited";
	}
	
	voucher.setTitle(values[0]);
	
	
	voucher.setUserid(user.getUserid());
	
	
	double amount = Double.parseDouble(values[1]);
	
	if(!session.getAttribute("currencyISO").toString().equals("INR")){
		currency.CurrencyConverter conv = new currency.CurrencyConverter();
		conv.setFrom(session.getAttribute("currencyISO").toString());
		conv.setTo("INR");	
		conv.fetchExchangeRateFromServer();
		amount = conv.getConvertedAmount(amount);
	}
	voucher.setAmount(amount);
	voucher.setVtypeid(Integer.parseInt(values[2]));
	
	SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
	java.util.Date d1 = fmt.parse(values[3]);
	
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String d2 = fmt2.format(d1);
	
	voucher.setDate(d2);
	
	voucher.setDescription(values[4]);
	
	if(path.equals("")){
		db.connect();
		String vid = values[6];	
		rs = db.executeQuery("SELECT ATTACHMENT,EXTENSION,TITLE FROM VOUCHER WHERE VOUCHERID = '" + vid + "'");
		if(rs.next()) {
			if(rs.getString(1) != null) {
				Blob image = rs.getBlob(1);
				
				String app_type = "";
				if(rs.getString(2).equals("pdf")){
					app_type = "pdf";
				}
				else if(rs.getString(2).equals("doc") || rs.getString(2).equals("docx")){
					app_type = "msword";
				}
				
				byte[] imgdata = image.getBytes(1,(int)image.length());
				
				String filename = rs.getString(3) + "." +rs.getString(2);
				path = config.getServletContext().getRealPath("/")+"uploads/"+filename;
				ext = rs.getString(2);
				FileOutputStream fout = new FileOutputStream(new File(path));
				fout.write(imgdata);
				fout.flush();
				fout.close();
				db.disconnect();
			}
		}	
	}
	
	voucher.setAttachment(path);
	voucher.setExtension(ext);
	
	boolean voucher_success = voucher.save();
	if(modestr.equals("edited")){
		Status[] stats = Status.list("VOUCHERID",values[6]);
		if(stats.length > 0) {
			Status latest_stat = stats[0];
			if(latest_stat.getStatus().equals("rejected")) {
				Status edited_stat = new Status();
				edited_stat.setStatus("edited");
				edited_stat.setTime();
				edited_stat.setUserid(user.getUserid());
				edited_stat.setVoucherid(Integer.parseInt(values[6]));
				edited_stat.save();
				
				Notification edited_notif = new Notification();
				edited_notif.setCategory("voucher edited");
				edited_notif.setCategoryid(values[6]);
				edited_notif.setTimeupdate();
				edited_notif.setUserid(user.getManager());
				edited_notif.save();
			}
		}
		
	}
	
	//set status of voucher to pending
	if(modestr.equals("added")){
		voucher.Status status = new voucher.Status();
		status.setStatus("pending");
		status.setVoucherid(voucher.getVoucherid());
		status.setUserid(user.getManager());
		status.setTime();
		status.save();
		
		Notification notif = new Notification();
		notif.setCategory("voucher");
		notif.setCategoryid(Integer.toString(voucher.getVoucherid()));
		notif.setUserid(user.getManager());
		notif.setTimeupdate();
		notif.save();
	}
	
	if(voucher_success)
	{
		//delete the draft
		if(!values[5].equals("")){
			File draft_file = new File(config.getServletContext().getRealPath("/")+"drafts/"+values[5]);
			draft_file.delete();
		}
		response.sendRedirect("../pages/voucher_view.jsp?status=" + Utility.MD5("success")+"&id="+voucher.getVoucherid() + "&message=Voucher " + modestr + " successfully");
		return;
	}
%>