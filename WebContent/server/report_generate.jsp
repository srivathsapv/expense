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
	
	String message="";
	if(reportType.equals("MIS_Report")){
		HashMap MISParameter = new HashMap();
		MISParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport MISReport = JasperCompileManager.compileReport(directory_path+"mis_chart_report.jrxml");
		JasperPrint MISPrint = JasperFillManager.fillReport(MISReport,MISParameter,con);
		JasperExportManager.exportReportToPdfFile(MISPrint,target_path + "MIS_Report_"+date+".pdf");
		message="MIS Report";
	}
	else if(reportType.equals("Exception_Report")){
		HashMap ExceptionParameter = new HashMap();
		ExceptionParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport ExceptionReport = JasperCompileManager.compileReport(directory_path+"ExceptionReport.jrxml");
		JasperPrint ExceptionPrint = JasperFillManager.fillReport(ExceptionReport,ExceptionParameter, con);
		JasperExportManager.exportReportToPdfFile(ExceptionPrint,target_path + "Exception_Report_"+date+".pdf");
		message="Exception Report";
	}
	else if(reportType.equals("Rejected_Voucher_Report")){
		HashMap RejectedParameter = new HashMap();
		RejectedParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport RejectedReport = JasperCompileManager.compileReport(directory_path+"rejected_voucher_report.jrxml");
		JasperPrint RejectedPrint = JasperFillManager.fillReport(RejectedReport,RejectedParameter, con);
		JasperExportManager.exportReportToPdfFile(RejectedPrint,target_path + "Rejected_Voucher_Report_"+date+".pdf");
		message="Rejected Voucher Report";
	}
	else if(reportType.equals("Voucher_Type_Report")){
		HashMap VoucherParameter = new HashMap();
		VoucherParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport VoucherReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		JasperPrint VoucherPrint = JasperFillManager.fillReport(VoucherReport,VoucherParameter, con);
		JasperExportManager.exportReportToPdfFile(VoucherPrint,target_path + "Voucher_Type_Report_"+date+".pdf");
		message="Voucher Type Report";
	}
	else if(reportType.equals("Ledger")){
		
		String frm = request.getParameter("fromDate");
		String to = request.getParameter("toDate");
		SimpleDateFormat dateformat = new SimpleDateFormat("dd-mm-yyyy");
		SimpleDateFormat dateformat1 = new SimpleDateFormat("yyyy-mm-dd");
		java.util.Date fromDate = dateformat.parse(frm);
		java.util.Date toDate = dateformat.parse(to);
		
		HashMap LedgerParameter = new HashMap();
		LedgerParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport LedgerReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		JasperPrint LedgerPrint = JasperFillManager.fillReport(LedgerReport,LedgerParameter, con);
		JasperExportManager.exportReportToPdfFile(LedgerPrint,target_path + "Ledger"+date+".pdf");
		message="Ledger";
	}
	else if(reportType.equals("Master_Data_Management_Reports")){	
		
		String subType = request.getParameter("subType");
		
		HashMap MasterParameter = new HashMap();
		MasterParameter.put("IMG_DIR",img_path+"logo.png");
		JasperReport MasterReport=null;
		
		if(subType.equals("AMOUNT_CONFIG")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("BOOKMARK")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("DEPARTMENT")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("LOGIN")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("NOTIFICATION")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("POLICY")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("REPORT")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("ROLECONFIG")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("USER")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("VOUCHER")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("VOUCHERTYPE_DEPT")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("VOUCHERTYPE_POLICY")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("VOUCHER_STATUS")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}else if(subType.equals("VOUCHER_TYPE")){
			MasterReport = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
		}
		
		JasperPrint MasterPrint = JasperFillManager.fillReport(MasterReport,MasterParameter, con);
		JasperExportManager.exportReportToPdfFile(MasterPrint,target_path + "Master_Data_Management_Reports_"+subType+date+".pdf");
		
		message="Master Data Management Reports <br/>Subtype:"+subType+"<br/>";
	}
	
	db.disconnect();
	response.sendRedirect("../pages/report_generate.jsp?status=" + Utility.MD5("success")+"&message=" + message + " generated successfully");
 %>
