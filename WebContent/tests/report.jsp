<%@ page 
import="net.sf.jasperreports.engine.*"
import="net.sf.jasperreports.engine.export.*"
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

JasperReport jasperReport1;
JasperPrint jasperPrint1;
JasperReport jasperReport2;
JasperPrint jasperPrint2;

HashMap jasperParameter = new HashMap();

String directory_path = config.getServletContext().getRealPath("/")+"reportTemplate/";
String target_path = config.getServletContext().getRealPath("/")+"temp/";

jasperReport1 = JasperCompileManager.compileReport(directory_path+"test_report.jrxml");
jasperPrint1 = JasperFillManager.fillReport(jasperReport1,jasperParameter, con);
JasperExportManager.exportReportToPdfFile(jasperPrint1, target_path + "test.pdf");

out.println("DONE DATA");

jasperReport2 = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
jasperPrint2 = JasperFillManager.fillReport(jasperReport2,jasperParameter, con);
JasperExportManager.exportReportToPdfFile(jasperPrint2,target_path + "test2.pdf");


out.println("DONE CHART");

%>

