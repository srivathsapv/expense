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
JasperExportManager.exportReportToPdfFile(jasperPrint1, target_path + "test.pdf");

out.println("DONE DATA");



//method 2 to run with static query
JasperReport jasperReport2 = JasperCompileManager.compileReport(directory_path+"report2.jrxml");
JasperPrint jasperPrint2 = JasperFillManager.fillReport(jasperReport2,jasperParameter, con);
JasperExportManager.exportReportToPdfFile(jasperPrint2,target_path + "test2.pdf");


out.println("DONE CHART");

%>

