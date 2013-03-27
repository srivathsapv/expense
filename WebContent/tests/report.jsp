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

//method 1 to cuctomize query
/* to custom query, do not change result feilds in the select clause
Eg; if report contains query "select name from DB2INST1.USER"
You can change it "select name from DB2INST1.USER where id=1 orderby someting"
But you cannot change it to "select id from DB2INST1.USER" */

JasperDesign jd = JRXmlLoader.load(directory_path+"test_report.jrxml");
//static query in report "select * from user"
String sql = "select * from user where  FIRSTNAME = 'Sasi' order by LASTNAME";
JRDesignQuery query = new JRDesignQuery();
query.setText(sql);
jd.setQuery(query);
JasperReport jasperReport1 = JasperCompileManager.compileReport(jd);
JasperPrint jasperPrint1 = JasperFillManager.fillReport(jasperReport1,jasperParameter, con);
JasperExportManager.exportReportToPdfFile(jasperPrint1, /*target_path +*/ "test.pdf");

out.println("DONE DATA \n");



//method 2 to run with static query
JasperReport jasperReport2 = JasperCompileManager.compileReport(directory_path+"VoucherTypes.jrxml");
JasperPrint jasperPrint2 = JasperFillManager.fillReport(jasperReport2,null, con);
JasperExportManager.exportReportToPdfFile(jasperPrint2,/*target_path +*/ "test2.pdf");


out.println("DONE CHART \n");

//using subreports and modifying queries of subreport

JasperDesign SubReportDesign = JRXmlLoader.load(directory_path+"mainreport_subreport1.jrxml");
//original "select * from voucher"
String SubReportsql = "select * from voucher where VOUCHERID > 10";
JRDesignQuery SubReportquery = new JRDesignQuery();
SubReportquery.setText(SubReportsql);
SubReportDesign.setQuery(SubReportquery);

JasperReport SubReport = JasperCompileManager.compileReport(SubReportDesign);

HashMap MainReportParameter = new HashMap();
MainReportParameter.put("SUBREPORT", SubReport);

JasperReport MainReport = JasperCompileManager.compileReport(directory_path+"mainreport.jrxml");
JasperPrint MainReportPrint = JasperFillManager.fillReport(MainReport,MainReportParameter, con);
JasperExportManager.exportReportToPdfFile(MainReportPrint,"mainreport.pdf");


out.println("DONE subreports \n");

//using subreports

JasperReport SubReport_Dept_Users = JasperCompileManager.compileReport(directory_path+"Departments_Users.jrxml");
JasperReport SubReport_Dept_VoucherTypes = JasperCompileManager.compileReport(directory_path+"Departments_VoucherTypes.jrxml");

HashMap MainReport_Dept_Parameter = new HashMap();
MainReport_Dept_Parameter.put("subReport_Departments_Users", SubReport_Dept_Users);
MainReport_Dept_Parameter.put("subReport_Departments_VoucherTypes", SubReport_Dept_VoucherTypes);

JasperReport MainReport_Dept = JasperCompileManager.compileReport(directory_path+"Departments.jrxml");
JasperPrint MainReport_Dept_Print = JasperFillManager.fillReport(MainReport_Dept,MainReport_Dept_Parameter, con);
JasperExportManager.exportReportToPdfFile(MainReport_Dept_Print,"mainreport_dept.pdf");


out.println("DONE");

%>

