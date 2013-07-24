<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="auth.Authentication,
				 user.Notification,
				 user.User,
				 org.json.JSONArray,
				 org.json.JSONObject,
				 voucher.Voucher,
				 voucher.Status" %>
<%
	if(request.getMethod().equals("POST")){
		String sid=request.getParameter("sid");
		String username=request.getParameter("username");
		
		Authentication auth = new Authentication(username);
		if(!auth.getSecureId().equals(sid)) {
			out.println(auth.getSecureId());
			out.println(sid);
			out.println("AUTH_ERROR");
			return;
		}
		
		Notification[] list = Notification.list("USERID",username);
		JSONArray json_arr = new JSONArray();
		for(Notification note:list){
			JSONObject json_obj = new JSONObject();
			json_obj.put("TIMEUPDATE",note.getTimeupdate());
			json_obj.put("CATEGORY",note.getCategory());
			
			String statusStr = "";
			String statusSetter = "";
			
			Voucher vouch;
			User vouchUser;
			if(note.getCategory().equals("voucher status change")){
				Status status = new Status(Integer.parseInt(note.getCategoryid()));
				statusStr = status.getStatus();
				
				User setter = new User(status.getUserid());
				statusSetter = setter.getFirstName() + " " + setter.getlastName();
				
				vouch = new Voucher(status.getVoucherid());
				
			}
			else {
				vouch = new Voucher(Integer.parseInt(note.getCategoryid()));
			}
			vouchUser = new User(vouch.getUserid());
			
			json_obj.put("STATUS",statusStr);
			json_obj.put("STATUS_SETTER",statusSetter);
			json_obj.put("VOUCHER_ID",vouch.getVoucherid());
			json_obj.put("VOUCHER_TITLE",vouch.getTitle());
			json_obj.put("VOUCHER_USERNAME",vouchUser.getFirstName() + " " + vouchUser.getlastName());
			
			json_arr.put(json_obj);
		}
		
		JSONObject notifJson = new JSONObject();
		notifJson.put("NOTIFICATIONS",json_arr);
		out.println(notifJson.toString());
	}
%>