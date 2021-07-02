<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<style> 
body {
 
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
	width: 40%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
}
.col-45{
float: left;
	width: 46%;
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


.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

/* Tax Button  */

.taxButton {
  display: inline-block;
  border-radius: 4px;
  background-color: #4CAF50;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 15px;
  padding: 10px;
  width: 150px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.taxButton {
  background-color: #ffe6e6; 
  color: black; 
  border: 2px solid #008CBA;
}

.taxButton span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.3s;
}

.taxButton span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.3s;
  
}

.taxButton:hover {
  background-color: #4CAF50;
  color: white;
}
.taxButton:hover span {
  padding-right: 25px;
}

.taxButton:hover span:after {
  opacity: 1;
  right: 0;
}

</style> 

<script type="text/javascript">
var DataMap="";
function SetValue(key,value){
	var Node = key+"*"+value;
	if(DataMap!=""){
		DataMap=DataMap+"$"+Node;
	}
	else{
		DataMap="data="+Node;
	}
}
function clear(){
	DataMap="";
}

function initValues(){
	var dt = new Date();
	var user = "<%= session.getAttribute("User_Id")%>";
	document.getElementById("Year").value=dt.getFullYear();
	
	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
	var current_datetime = new Date()
	entdOn = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
	document.getElementById("MonthCode").value = dt.getMonth()+1; 
	
	if(user == "F9999" || "F1520"){
		document.getElementById('Branch_Code').readOnly = false;
	}
	
	document.getElementById("Year").focus();
}

function YearValidation(event)
{
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MonthCode").focus();
	}
}

function MonthCodeValidation(event)
{
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ReportType").focus();
	}
}



function GetPensionReport()
{	    
	

	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
		
	clear();
	SetValue("loggedBranch",usr_brn);
	SetValue("MonthCode",document.getElementById("MonthCode").value);
	SetValue("Year",document.getElementById("Year").value);
	SetValue("ReportType",document.getElementById("ReportType").value);
	SetValue("pensionDist",document.getElementById("pensionDist").value);
	SetValue("ActivationType",document.getElementById("ActivationType").value);
	SetValue("Class","elixir.report.ics.PensionPaymentSystemReport");
	SetValue("Method","MonthlyPensionPaymentSystemReport");
	
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "CommomReportHandler?"+DataMap, true);
		
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {
		        var filename = "Report_"+ document.getElementById("ReportType").value +".pdf";
		        if (typeof window.chrome !== 'undefined') {
		            // Chrome version
		            var link = document.createElement('a');
		            link.href = window.URL.createObjectURL(xhttp.response);		       
		            window.open(link.href);		            
		        
		        } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
		            // IE version
		            var blob = new Blob([xhttp.response], { type: 'application/pdf' });
		            window.navigator.msSaveBlob(blob, filename);
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
		<h3 style="color:white;">Pension Payment System</h3>
		
		<div class="container">
		<fieldset>	
		   <legend> Monthly Pension Report Lists</legend> 			
				<div class="row">
					<div class="col-25">
						<label for="Year">Pension Year</label>
					</div>
					<div class="col-25">
						<input type="text" id="Year" name="Year" onkeypress="YearValidation(event)">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
							<label for="pensionDist">Branch Location</label>
					</div>
					<div class="col-25">
						<select id="pensionDist" name="pensionDist"  onkeypress="pensionDistValidation(event)">
							<option value="D">Dhaka</option>
							<option value="O">Outside of Dhaka</option>
							<option value="A">All[Both Dhaka,Outside of Dhaka]</option>							
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
							<label for="ActivationType">Activity Type</label>
					</div>
					<div class="col-25">
						<select id="ActivationType" name="ActivationType"  onkeypress="pensionDistValidation(event)">
							<option value="Y">A-Active only</option>
							<option value="N">I-Inactive</option>
							<option value="B">B-[Both Active & Inactive]</option>							
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
							<label for="MonthCode">Pension Month</label>
					</div>
					<div class="col-25">
						<select id="MonthCode" name="MonthCode"  onkeypress="MonthCodeValidation(event)">
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
							<label for="ReportType">Report Type</label>
					</div>
					<div class="col-25">
						<select id="ReportType" name="ReportType" >
							<option value="PensionRpt">Monthly Pension Details Report</option>
							<option value="PensionAdvice">Monthly Pension Advice Report</option>
							<option value="PensionAdviceByBranch">Monthly Pension Advice Report By Branch Wise</option>
							<option value="PensionDeduction">Monthly Report on HB,Computer,Motor Deduction</option>	
							<option value="ArearReportDetails">Monthly Arrears Details Report</option>		
							<option value="PenPaySlip">Monthly Pension slip Report</option>																			
							<option value="PensionerDetails">List of Pensioner Details By Activation Type</option>
							<option value="PensionerDetailsByType">List of Pensioner Details By Pension Type Wise</option>
							<option value="InharitanceDetails">List of Inheritance Details By Relation Type</option>														
						
						</select>
					</div>
				</div>
				</fieldset>
				<div class="row">
					<div class="col-15">					
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
						
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Download" onclick="GetPensionReport()" > <br>
					</div>
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>