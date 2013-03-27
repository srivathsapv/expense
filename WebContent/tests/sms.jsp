<%@ page import="java.io.*,java.util.*" %>
<% 

String adb_path = config.getServletContext().getRealPath("/")+"adb/";
Runtime shell = Runtime.getRuntime();
Process p = shell.exec(adb_path+"./adb shell dumpsys power");
p.waitFor();

BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
String line = "";
String temp = "";
while ((line = reader.readLine()) != null) {
	temp = temp + line;
}
int powerstate = 0;
if(temp.equals("")){
	System.out.println("error");
}else{
	int pos = temp.indexOf("mPowerState")+12;
	powerstate = Integer.parseInt(temp.substring(pos,pos+1));

System.out.println(powerstate);
if(powerstate == 0){
p = shell.exec(adb_path+"./adb shell input keyevent 3");
p.waitFor();	
} 

p = shell.exec(adb_path+"./adb shell am start -a android.intent.action.SENDTO -d sms:919677284964 --es sms_body \"Hello mate\" --ez exit_on_sent true");
p.waitFor();


reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
line = "";
temp = "";
while ((line = reader.readLine()) != null) {
	temp = temp + line;
}
if(temp.indexOf("error")>0){
	System.out.println("error");
}else{
	System.out.println(temp);
}

p = shell.exec(adb_path+"./adb shell input keyevent 22");
p.waitFor();

p = shell.exec(adb_path+"./adb shell input keyevent 66");
p.waitFor();

Thread.sleep(10000);

p = shell.exec(adb_path+"./adb shell input keyevent 66");
p.waitFor();

p = shell.exec(adb_path+"./adb shell input keyevent 3");
p.waitFor();
			
p = shell.exec(adb_path+"./adb shell input keyevent 6");
p.waitFor();
}
%>
