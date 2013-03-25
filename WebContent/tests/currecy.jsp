<%@ page import="currency.CurrencyConverter" %>
<% 
CurrencyConverter conv = new CurrencyConverter();
conv.setFrom("YEN");
conv.setTo("INR");	
conv.fetchExchangeRateFromServer();
out.println(conv.getConvertedAmount(50));
%>
