<%@ page 
import="net.sf.jasperreports.engine.*"
import="net.sf.jasperreports.engine.export.*"
import="net.sf.jasperreports.engine.design.*"
import="net.sf.jasperreports.engine.xml.*"
%>
<%@ page  
import="java.util.*" 
import="db.Db"
import="java.sql.*"
%>
<%

Db db = new Db();
db.connect();
Connection con = db.getConnection();

HashMap jasperParameter = new HashMap();

String directory_path = config.getServletContext().getRealPath("/")+"reportTemplate/";
String target_path = config.getServletContext().getRealPath("/")+"temp/";
JasperReport jasperReport2 = JasperCompileManager.compileReport(directory_path+"rejected_voucher_report.jrxml");
JasperPrint jasperPrint2 = JasperFillManager.fillReport(jasperReport2,jasperParameter, con);
JasperExportManager.exportReportToPdfFile(jasperPrint2,target_path + "test2.pdf");
%>