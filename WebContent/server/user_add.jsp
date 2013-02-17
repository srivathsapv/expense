<%@ page import="utility.Utility,user.User,auth.Authentication,java.text.*,java.util.*" %>
<%
	String userid = Utility.filter(request.getParameter("userid"));
	String firstName = Utility.filter(request.getParameter("firstName"));
	String middleName = Utility.filter(request.getParameter("middleName"));
	String lastName = Utility.filter(request.getParameter("lastName"));
	String socialSecurity = Utility.filter(request.getParameter("socialSecurity"));
	String dob = Utility.filter(request.getParameter("dob"));
	String gender = Utility.filter(request.getParameter("gender")).substring(0,1).toUpperCase();
	String deptid = Utility.filter(request.getParameter("deptid"));
	String designation = Utility.filter(request.getParameter("designation"));
	String address = Utility.filter(request.getParameter("address"));
	String phone = Utility.filter(request.getParameter("phone"));
	String mobile = Utility.filter(request.getParameter("mobile"));
	String email = Utility.filter(request.getParameter("email"));
	//photo!!
	
	//create new login
	Authentication new_login = new Authentication();
	
	new_login.setUserid(userid);
	new_login.setPassword("asdf"); //later change it to random
	new_login.setRole("emp");
	new_login.setLastlogin();
	
	boolean login_success = new_login.save();
	
	
	//create new user
	User user = new User();
	
	user.setUserid(userid);
	user.setFirstName(firstName);
	user.setMiddleName(middleName);
	user.setlastName(lastName);
	user.setSocialSecurity(socialSecurity);
	
	SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
	Date d1 = fmt.parse(dob);
	
	
	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
	String d2 = fmt2.format(d1);
	
	user.setDate(d2);
	
	user.setGender(gender);
	user.setDeptid(Integer.parseInt(deptid));
	user.setDesignation(designation);
	user.setAddress(address);
	user.setPhone(phone);
	user.setMobile(mobile);
	user.setEmail(email);
	
	
	boolean user_success = user.save();
	
	if(user_success && login_success){
		response.sendRedirect("../pages/user_add.jsp?status=" + Utility.MD5("success"));
		return;
	}
	else {
		response.sendRedirect("../pages/user_add.jsp?status=" + Utility.MD5("error"));
		return;
	}
%>