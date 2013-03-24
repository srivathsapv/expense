<%@ page import="currency.CurrencyConverter" %>
<% 
CurrencyConverter conv = new CurrencyConverter();
conv.setFrom("INR");
conv.setTo("EUR");	
conv.fetchExchangeRateFromServer();
out.println(conv.getCovertedAmount(50));
%>
