<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "../include/layout.jsp"/> 
<div id = "body-content">
	<form>
  		<fieldset>
    		<legend>
    			Add new employee
    			<p class = "legend-desc"><i class = "icon-question-sign"></i>Enter the details of the new employee in the company</p>
    		</legend><br>
    		<input class = "span4" type="text" placeholder="Enter your first name..."><br>
    		<input class = "span4" type="text" placeholder="Enter your middle name..."><br>
    		<input class = "span4" type="text" placeholder="Enter your last name..."><br>
    		<input class = "span4" type="text" placeholder="Enter your social security..."><br>
    		<label>Date of Birth</label><select class = "span4">
   				<option value = ''>Date</option>
   				<option value = 'type1'>1</option>
   				<option value = 'type2'>2</option>
   				<option value = 'type2'>3</option>
   				<option value = 'type2'>4</option>
   				<option value = 'type2'>5</option>
   				<option value = 'type2'>6</option>
   				<option value = 'type2'>7</option>
   				<option value = 'type2'>8</option>
   				<option value = 'type2'>9</option>
   				<option value = 'type2'>10</option>
   				<option value = 'type1'>11</option>
   				<option value = 'type2'>12</option>
   				<option value = 'type2'>13</option>
   				<option value = 'type2'>14</option>
   				<option value = 'type2'>15</option>
   				<option value = 'type2'>16</option>
   				<option value = 'type2'>17</option>
   				<option value = 'type2'>18</option>
   				<option value = 'type2'>19</option>
   				<option value = 'type2'>20</option>
   				<option value = 'type1'>21</option>
   				<option value = 'type2'>22</option>
   				<option value = 'type2'>23</option>
   				<option value = 'type2'>24</option>
   				<option value = 'type2'>25</option>
   				<option value = 'type2'>26</option>
   				<option value = 'type2'>27</option>
   				<option value = 'type2'>28</option>
   				<option value = 'type2'>29</option>
   				<option value = 'type2'>30</option>
   				<option value = 'type2'>31</option>
   			</select>
    		<select class = "span4">
    		 	<option value = ''>Month</option>
   				<option value = 'type1'>January</option>
   				<option value = 'type2'>February</option>
   				<option value = 'type2'>March</option>
   				<option value = 'type2'>April</option>
   				<option value = 'type2'>May</option>
   				<option value = 'type2'>June</option>
   				<option value = 'type2'>July</option>
   				<option value = 'type2'>August</option>
   				<option value = 'type2'>September</option>
   				<option value = 'type2'>October</option>
   				<option value = 'type1'>November</option>
   				<option value = 'type2'>December</option>
   			</select>
   			
   			<select class = "span4">
    		 	<option value = ''>Year</option>
   				<option value = 'type1'>1985</option>
   				<option value = 'type2'>1986</option>
   				<option value = 'type2'>1987</option>
   				<option value = 'type2'>1988</option>
   				<option value = 'type2'>1989</option>
   				<option value = 'type2'>1990</option>
   				<option value = 'type2'>1991</option>
   				<option value = 'type2'>1992</option>
   				<option value = 'type2'>1993</option>
   				<option value = 'type2'>1994</option>
   				<option value = 'type1'>1995</option>
   				<option value = 'type2'>1996</option>
   				<option value = 'type2'>1997</option>
   				<option value = 'type2'>1998</option>
   				<option value = 'type1'>1999</option>
   				<option value = 'type2'>2000</option>
   				<option value = 'type2'>2001</option>
   				<option value = 'type2'>2002</option>
   				<option value = 'type2'>2003</option>
   				<option value = 'type2'>2004</option>
   				<option value = 'type2'>2005</option>
   				<option value = 'type2'>2006</option>
   				<option value = 'type2'>2007</option>
   				<option value = 'type2'>2008</option>
   				<option value = 'type2'>2009</option>
   				<option value = 'type2'>2010</option>
   				<option value = 'type2'>2011</option>
   				<option value = 'type2'>2012</option>
   				<option value = 'type2'>2013</option>
   			</select>
   			
   			<select class = "span4">
   				<option value = ''>Gender</option>
   				<option value = 'type1'>Male</option>
   				<option value = 'type1'>Female</option>
   				<option value = 'type1'>Other</option>
   			</select><br>
   		
    		<select class = "span4">
   				<option value = ''>Select your department</option>
   				<option value = 'type1'>Dept1</option>
   				<option value = 'type2'>Dept2</option>
   			</select><br>
   			<input class = "span4" type="text" placeholder="Enter your designation..."><br>
    		<textarea rows="5" cols = "50" placeholder="Enter your address..."></textarea><br>
    		<input class = "span4" type="text" placeholder="Enter your phone number.."><br>
    		<input class = "span4" type="text" placeholder="Enter your mobile number.."><br>
    		<input class = "span4" type="text" placeholder="Enter your email id..."><br>
    		<label>Upload Photo</label><input class = "span4" type="file"><br>
    		<textarea rows="5" cols = "50" placeholder="Enter a description..."></textarea><br>
    		<br><br><button type="submit" class="btn btn-info">Submit</button>
    	</fieldset>
	</form>
</div>







