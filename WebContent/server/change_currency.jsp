<%
	String mode = request.getParameter("mode");
	if(mode.equals("session")){
		String currency = request.getParameter("currency");
		String currencyText = "";
		String currencyISO = "";
		if(currency.equals("rupees")){
			currencyText = "Indian Rupees";
			currencyISO = "INR";
		}
		else if(currency.equals("dollar")){
			currencyText = "US Dollars";
			currencyISO = "USD";
		}
		else if(currency.equals("yen")){
			currencyText = "Yen";
			currencyISO = "JPY";
		}
		else if(currency.equals("pound")){
			currencyText = "British Pounds";
			currencyISO = "GBP";
		}
		
		out.println(session.getAttribute("currencyISO").toString());
		
		session.setAttribute("currency",currency);
		session.setAttribute("currencyText",currencyText);
		session.setAttribute("currencyISO",currencyISO);
		
	}
	else if(mode.equals("convert")){
		double amount = Double.parseDouble(request.getParameter("amount"));
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		
		currency.CurrencyConverter conv = new currency.CurrencyConverter();
		conv.setFrom(from);
		conv.setTo(to);	
		conv.fetchExchangeRateFromServer();
		out.println(conv.getConvertedAmount(amount));
	}
%>