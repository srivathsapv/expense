<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="net.sf.jasperreports.engine.*"
	import="net.sf.jasperreports.engine.export.*"
	import="net.sf.jasperreports.engine.design.*"
	import="net.sf.jasperreports.engine.xml.*"%>
<%@ page import="java.util.*,utility.Utility" import="db.Db" import="java.sql.*"%>

<%
Db db = new Db();
db.connect();
Connection con = db.getConnection();

String directory_path = config.getServletContext().getRealPath("/")+"reportTemplate/";
String target_path = config.getServletContext().getRealPath("/")+"temp/";
String img_path = config.getServletContext().getRealPath("/")+"img/";
java.util.Date d = new java.util.Date();
String date = new Timestamp(d.getTime()).toString();

	String reportType = request.getParameter("reportType");
	String exportPath = "";
	String message="";
	if(reportType.equals("MIS_Report")){
		HashMap MISParameter = new HashMap();
		MISParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport MISReport = JasperCompileManager.compileReport(directory_path+"mis_chart_report.jrxml");
		JasperPrint MISPrint = JasperFillManager.fillReport(MISReport,MISParameter,con);
		exportPath = target_path + "MIS_Report_"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(MISPrint,exportPath);
		message="MIS Report";
	}
	else if(reportType.equals("Exception_Report")){
		HashMap ExceptionParameter = new HashMap();
		ExceptionParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport ExceptionReport = JasperCompileManager.compileReport(directory_path+"ExceptionReport.jrxml");
		JasperPrint ExceptionPrint = JasperFillManager.fillReport(ExceptionReport,ExceptionParameter, con);
		exportPath = target_path + "Exception_Report_"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(ExceptionPrint,exportPath);
		message="Exception Report";
	}
	else if(reportType.equals("Rejected_Voucher_Report")){
		HashMap RejectedParameter = new HashMap();
		RejectedParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport RejectedReport = JasperCompileManager.compileReport(directory_path+"rejected_voucher_report.jrxml");
		JasperPrint RejectedPrint = JasperFillManager.fillReport(RejectedReport,RejectedParameter, con);
		exportPath = target_path + "Rejected_Voucher_Report_"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(RejectedPrint,exportPath);
		message="Rejected Voucher Report";
	}
	else if(reportType.equals("Voucher_Type_Report")){
		HashMap VoucherParameter = new HashMap();
		VoucherParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport VoucherReport = JasperCompileManager.compileReport(directory_path+"vouchertype_report.jrxml");
		JasperPrint VoucherPrint = JasperFillManager.fillReport(VoucherReport,VoucherParameter, con);
		exportPath = target_path + "Voucher_Type_Report_"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(VoucherPrint,exportPath);
		message="Voucher Type Report";
	}
	else if(reportType.equals("Company_Policy_Report")){
		HashMap VoucherParameter = new HashMap();
		VoucherParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport VoucherReport = JasperCompileManager.compileReport(directory_path+"company_policy_chart_report.jrxml");
		JasperPrint VoucherPrint = JasperFillManager.fillReport(VoucherReport,VoucherParameter, con);
		exportPath = target_path + "Company_Policy_Report_"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(VoucherPrint,exportPath);
		message="Company Policy Report";
	}
	else if(reportType.equals("Ledger")){
			
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		JasperDesign jd = JRXmlLoader.load(directory_path+"Ledger.jrxml");
		//static query in report "select * from user"
		String sql = "SELECT " +
			     	 "VOUCHER.VOUCHERID AS VOUCHER_VOUCHERID," +
			     	 "VOUCHER.TITLE AS VOUCHER_TITLE," +
			     	 "VOUCHER.AMOUNT AS VOUCHER_AMOUNT," +
			     	 "VARCHAR_FORMAT(VOUCHER.DATE,'DD-MM-YYYY') AS VOUCHER_DATE," +
			     	 "VOUCHER_STATUS.USERID AS VOUCHER_STATUS_USERID," +
			     	 "VARCHAR_FORMAT(VOUCHER_STATUS.TIME,'DD-MM-YYYY') AS VOUCHER_STATUS_TIME," +
			     	 "POLICY.AMOUNTPERCENT AS POLICY_AMOUNTPERCENT," +
			     	 "USER.FIRSTNAME AS USER_FIRSTNAME," +
			     	 "USER.MIDDLENAME AS USER_MIDDLENAME," +
			         "USER.LASTNAME AS USER_LASTNAME " +
					 " FROM " +
			     	 "VOUCHER VOUCHER INNER JOIN VOUCHER_STATUS VOUCHER_STATUS ON VOUCHER.VOUCHERID = VOUCHER_STATUS.VOUCHERID " +
			     	 "INNER JOIN POLICY POLICY ON VOUCHER.POLICYID = POLICY.POLICYID " +
			     	 "INNER JOIN USER USER ON VOUCHER_STATUS.USERID = USER.USERID " +
					 "WHERE " +
			     	 "VOUCHER_STATUS.STATUS = 'sanctioned' AND VOUCHER_STATUS.TIME LIKE '" + year + "-" + month + "-__%'";
		JRDesignQuery query = new JRDesignQuery();
		query.setText(sql);
		jd.setQuery(query);
		
		HashMap LedgerParameter = new HashMap();
		LedgerParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport LedgerReport = JasperCompileManager.compileReport(jd);
		JasperPrint LedgerPrint = JasperFillManager.fillReport(LedgerReport,LedgerParameter, con);
		exportPath = target_path + "Ledger"+date+".pdf";
		JasperExportManager.exportReportToPdfFile(LedgerPrint,exportPath);
		message="Ledger";
	}
	else if(reportType.equals("Master_Data_Management_Reports")){	
		
		String subType = request.getParameter("subType");
		
		HashMap MasterParameter = new HashMap();
		MasterParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport MasterReport=null;
		directory_path += "/masters/";
		if(subType.equals("AMOUNT_CONFIG")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"amount_config_report.jrxml");
		}else if(subType.equals("DEPARTMENT")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"Departments.jrxml");
		}else if(subType.equals("POLICY")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"policy_report.jrxml");
		}else if(subType.equals("ROLECONFIG")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"roleconfig_report.jrxml");
		}else if(subType.equals("USER")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"Users.jrxml");
		}else if(subType.equals("VOUCHER")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"Vouchers.jrxml");
		}else if(subType.equals("VOUCHER_TYPE")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"VoucherTypes.jrxml");
		}	
		JasperPrint MasterPrint = JasperFillManager.fillReport(MasterReport,MasterParameter, con);
		exportPath = target_path + "Master_Data_Management_Reports_"+subType+date+".pdf";
		JasperExportManager.exportReportToPdfFile(MasterPrint,exportPath);
		
		message="Master Data Management Reports";
	}
	
	
	report.Report report = new report.Report();
	
	Calendar cdate = Calendar.getInstance();
	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
	String dt = f.format(cdate.getTime());
	
	report.setDate(dt);
	report.setUserid(session.getAttribute("sessionUsername").toString());
	String title = reportType;
	if(!request.getParameter("title").equals("")){
		title = request.getParameter("title"); 
	}
	report.setTitle(title);
	report.setDescription(request.getParameter("description"));
	report.setFile(exportPath);
	report.setType(reportType.substring(0,reportType.indexOf("_")));
	report.save();
	
	db.disconnect();
	response.sendRedirect("../pages/report_generate.jsp?reportid=" + report.getReportid() + "&status=" + Utility.MD5("success")+"&message=" + message + " generated successfully");
 %>
