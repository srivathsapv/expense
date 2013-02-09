<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "../include/layout.jsp" %>
<title>Vowcher - New Voucher Type</title>
<script type="text/javascript">
    $(document).ready(function() {
      $('.multicheck').click(function(e) {     
         $(this).toggleClass("checked"); 
         $(this).find("span").toggleClass("icon-ok"); 
         return false;
      });
    });
    </script>

<div id="body-content">
	<form method = "POST">
		<fieldset>
			<legend>
				Create New Voucher Type
				<p class="legend-desc">
					<i class="icon-question-sign"></i>Enter details about the new
					voucher type
				</p>
			</legend>
			<br /> <input type="text" class="span4 required" valtype = "required alphanumericwithspace" valmsg="Invalid title" id="voucher_name"
				placeholder="Enter voucher name..."><br />
			<textarea rows="5" cols="50" placeholder="Enter a description..."></textarea>
			<br />

			<div class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">Select
					Policy<b class="caret"></b>
				</a>
				<ul class="dropdown-menu scroll">
					<li><a id="chk1" class="multicheck" href="#">Policy 1 <span
							class="pull-right"></span></a></li>
					<li><a id="chk2" class="multicheck checked" href="#">Policy
							2 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk3" class="multicheck checked" href="#">Policy
							3 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk4" class="multicheck checked" href="#">Policy
							4 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk5" class="multicheck checked" href="#">Policy
							5 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk6" class="multicheck checked" href="#">Policy
							6 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk7" class="multicheck checked" href="#">Policy
							7 <span class="pull-right"></span>
					</a></li>
					<li><a id="chk8" class="multicheck checked" href="#">Policy
							8 <span class="pull-right"></span>
					</a></li>
				</ul>
			</div>
			<br /> <br />
			<input type = "submit" class = "btn btn-info" value = "Add Voucher Type">
		</fieldset>
	</form>
</div>