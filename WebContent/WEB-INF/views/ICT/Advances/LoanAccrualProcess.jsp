<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style>

/* Popup container - can be anything you want */
.popup {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.popup .popuptext {
  visibility: hidden;
  width: 160px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 8px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}
.popup .hide {
  visibility: hiden;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}

/* .datepicker
{ 
    width: 10.5em;
    height: 2.5em;
} */
body {
 /*  background-image: url('../../Media/bg6.jpg') ;
  background-repeat: no-repeat;
  background-size:  /* 300px 100px    auto ; */
  background-color: #cccccc; 
}

 {
	box-sizing: border-box;
}

input[type=text],select,textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
}

label {
	padding: 12px 12px 12px 0;
	display: inline-block;
}

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: left;
}

input[type=submit]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #85adad;
	padding: 20px;
}

.col-15 {
	float: left;
	width: 15%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.col-20 {
	float: left;
	width: 20%;
}
.colr-20 {
	float: left;
	width: 35%;
	margin-left: 5px;
}
.col-25 {
	float: left;
	width: 40%;
}

.col-35{
float: left;
	width: 30%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 50%;
	margin-top: 6px;
}



/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
	.col-25,.col-75,input[type=submit] {
		width: 100%;
		margin-top: 0;
	}
}
</style>

<script type="text/javascript">
	$(document).on('keydown', 'input[pattern]', function(e){
	  var input = $(this);
	  var oldVal = input.val();
	  var regex = new RegExp(input.attr('pattern'), 'g');

	  setTimeout(function(){
	    var newVal = input.val();
	    if(!regex.test(newVal)){
	      input.val(oldVal); 
	    }
	  }, 0);
	});
	
	$(function() {
		$("#DisbDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});

	var DataMap = "";
	function SetValue(key, value) {
		var Node = key + "*" + value;
		if (DataMap != "") {
			DataMap = DataMap + "$" + Node;
		} else {
			DataMap = "data=" + Node;
		}
	}
	function clear() {
		DataMap = "";
	}

	function initValues() {
		document.getElementById("EmployeeId").value = "";		
		document.getElementById("EmployeeId").focus();
	}
		
	function AccrualProcess(event) {
		var userId= "<%= session.getAttribute("User_Id")%>";
		clear();
		SetValue("EntdBy",userId);
		SetValue("Year",document.getElementById("Year").value);
		SetValue("MonthCode",document.getElementById("MonthCode").value);
		SetValue("LoanType",document.getElementById("LoanType").value);
		SetValue("Class","SuperValidation");
		SetValue("Method","AccrualProcess");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					alert(obj.SUCCESS);
					initValues();
				}									
		}
	};
	xhttp.open("POST", "HTTPValidator?" + DataMap, true);
	xhttp.send();
  }
</script>

</head>
<body onload="initValues()">
	<center>
	<h2>Accrual Process By Month</h2>
		<div class="container">					
				<div class="row">
					<div class="col-25">
						<label for="Year"> Year</label>
					</div>
					<div class="col-75">
						<input type="text" id="Year" name="Year" onkeypress="YearValidation(event)">
					</div>
				</div>							
				<div class="row">
					<div class="col-25">
							<label for="MonthCode"> Month</label>
					</div>
					<div class="col-75">
						<select id="MonthCode" name="MonthCode"  onkeypress="EmployeeIdValidation(event)">
							<option value="1">January</option>
							<option value="2">February</option>
							<option value="3">March</option>
							<option value="4">April</option>
							<option value="5">May</option>
							<option value="6">June</option>
							<option value="7">July</option>
							<option value="8">August</option>
							<option value="9">September</option>
							<option value="10">October</option>
							<option value="11">November</option>
							<option value="12">December</option>							
						</select>
					</div>
				</div>
				<div class="row">				
					<div class="col-25">
						<label for="LoanType">Loan Type </label>
					</div>				
					<div class="col-75">
						<select id="LoanType" name="LoanType"  onkeypress="LoanTypeValidation(event)">
							<option value="HBL">HBL</option>
							<option value="COM">Computer</option>
							<option value="MOT">Motor Cycle</option>	
							<option value="PFC">PF Contribution</option>								
						</select>
					</div>
				</div>								
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="accrualProcess" value="Execute!"
						onclick="AccrualProcess(event)">
				</div>
		</div>	
	</center>
</body>
</html>