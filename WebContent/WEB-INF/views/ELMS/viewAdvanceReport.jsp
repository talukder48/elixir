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
  background-color: #006666; 
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
	background-color: #ffffff;
	padding: 20px;
}

.col-25 {
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
.col-75 {
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
		$("#RealDate").datepicker({
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
		document.getElementById("BranchCode").value = "";
		document.getElementById("BranchName").value = "";
		document.getElementById("EmployeeId").value = "";
		document.getElementById("FinYear").value = "";
		document.getElementById("EmployeeName").value = "";			
		document.getElementById("BranchCode").focus();
	}
	function BranchCodeValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
			if (document.getElementById("BranchCode").value=="" ||document.getElementById("BranchCode").value=="0"){
				document.getElementById("BranchName").innerHTML = "For All Branch";
				document.getElementById("EmployeeId").focus();
			}
			else
				{
				clear();
				SetValue("branch_code", document.getElementById("BranchCode").value);
				SetValue("Class", "ELMSValidator");
				SetValue("Method", "BranchKeyPress");
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {

					if (this.readyState == 4 && this.status == 200) {
						var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							document.getElementById("BranchName").innerHTML = obj.BRN_NAME;
							document.getElementById("EmployeeId").focus();
						}
					}
				};
				xhttp.open("POST", "HTTPValidator?" + DataMap, true);
				xhttp.send();
				
			}
		}
	}
	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
			if(document.getElementById("EmployeeId").value=="" || document.getElementById("EmployeeId").value=="0"){
				document.getElementById("EmployeeName").innerHTML = "For All Employee";
				document.getElementById("FinYear").focus();
			}
			else
				{
				clear();
				SetValue("EmployeeId", document.getElementById("EmployeeId").value);
				SetValue("Class", "FinanceOperation");
				SetValue("Method", "FetchEmpData");
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {

					if (this.readyState == 4 && this.status == 200) {
						var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							document.getElementById("EmployeeName").innerHTML = obj.EMP_NAME;
							document.getElementById("FinYear").focus();
						}
					}
				};
				xhttp.open("POST", "HTTPValidator?" + DataMap, true);
				xhttp.send();
				}			
		}
	}
	
	function FinYearValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
			if(document.getElementById("FinYear").value=="" || document.getElementById("FinYear").value=="0"){
				alert("Fin Year Should not be null");
				document.getElementById("FinYear").focus();
			}
			else
				{
				 document.getElementById("LoanType").focus();
			}			
		}
	}
	
	
	
	function FinanceReport(){
		
		var usr_brn = "<%= session.getAttribute("BranchCode")%>";

		var DataString="LoanType="+document.getElementById("LoanType").value;
		DataString=DataString+"&FinYear="+document.getElementById("FinYear").value+"&BranchCode="+document.getElementById("BranchCode").value+"&EmployeeId="+document.getElementById("EmployeeId").value+"&loggedBranch="+usr_brn;
			var xhttp = new XMLHttpRequest();		
			xhttp.open("POST", "LoanReportServlet?"+DataString, true);
			xhttp.responseType = "blob";
			xhttp.onreadystatechange = function () {
			    if (xhttp.readyState === 4 && xhttp.status === 200) {
			        var filename = "Report_"+ document.getElementById("LoanType").value+"_"+document.getElementById("BranchCode").value +".pdf";
			        if (typeof window.chrome !== 'undefined') {
			            // Chrome version
			            var link = document.createElement('a');
			            link.href = window.URL.createObjectURL(xhttp.response);		       
			            window.open(link.href);		            
			           
			        } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
			            // IE version
			            var blob = new Blob([xhttp.response], { type: 'application/pdf' });
			            window.navigator.msSaveBlob(blob, filename);
			           // window.open(window.navigator.msSaveBlob(blob, filename));
			        } else {
			            // Firefox version
			            var file = new File([xhttp.response], filename, { type: 'application/force-download' });
			            window.open(URL.createObjectURL(file));		            
			        }
			    }
			};
			xhttp.send();			
	}
	
</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3 style="color:white;">Employee Loan Management System</h3>
		
		<div class="container">
		   
		     <fieldset>
				   <legend>Reports[HB,Computer,Motor,PF]</legend> 
				<div class="row">
					<div class="col-25">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-25">
						<input type="text" id="BranchCode" name="BranchCode" onkeypress="BranchCodeValidation(event)">
					</div>
					
					<div class="colr-15">
						
					</div>
					<div class="colr-15">						
						<p id="BranchName" ></p>
					</div>										
				 </div>
				 
				<div class="row">
					<div class="col-25">
						<label for="EmployeeId">Employee ID</label>
					</div>
					<div class="col-25">
						<input type="text" id="EmployeeId" name="EmployeeId" onkeypress="EmployeeIdValidation(event)">
					</div>
					
					<div class="colr-15">
						
					</div>
					<div class="col-25">
						<p id="EmployeeName" ></p>
					</div>										
				 </div>
			     
			     
			     <div class="row">
					<div class="col-25">
						<label for="FinYear">Financial Year</label>
					</div>
					<div class="col-25">
						<input type="text" id="FinYear" name="FinYear" onkeypress="FinYearValidation(event)" placeholder="eg: 2019-2020">
					</div>
					
									
				 </div>
			     			
				<div class="row">
					<div class="col-25">
						<label for="LoanType">Loan Type</label>
					</div>
					<div class="col-25">
						<select id ="LoanType"  onkeypress="LoanTypeKeyPress(event)" >
							<option id="3"   value="PF"> PF-PF Advanced</option>
			        		<option id="1"   value="HBL">HBL-HB Loan</option>
			        		<option id="2"   value="COM">COM-Computer</option>	
			        		<option id="3"   value="MOT">MOT-Motorcycle</option>
			        	
			           </select>		
					</div>					
				</div>
				</fieldset>																			
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Download" onclick="FinanceReport(event)" >
				</div>
		</div>
	</center>
</body>
</html>