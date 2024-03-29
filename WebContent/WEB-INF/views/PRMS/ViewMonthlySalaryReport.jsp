<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bangladesh House Building Finance Corporation</title>
</head>
<style> 
body {
  background-color: #006666;
 /*  background-image: url('../../Media/bg6.jpg') ;
  background-repeat: repeat;
  background-size: /* 300px 100px   auto ; */
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
	document.getElementById("Branch_Code").value="<%= session.getAttribute("BranchCode")%>";	
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


function GenerateReport(){	
		var DataString="ReportType="+document.getElementById("ReportType").value;	
		var branchCode="";
		if (document.getElementById("Branch_Code").value==""){
			branchCode="NA";
		}
		else{
			branchCode=document.getElementById("Branch_Code").value;
		}
		var user = "<%= session.getAttribute("User_Id")%>";
				
		clear();
		SetValue("loggedBranch",branchCode);
		SetValue("Branch_Code",document.getElementById("Branch_Code").value);
		SetValue("User_Id",user);
		SetValue("Year",document.getElementById("Year").value);
		SetValue("MonthCode",document.getElementById("MonthCode").value);
		SetValue("ReportType",document.getElementById("ReportType").value);
		SetValue("Class","elixir.report.ics.PayrollManagementSystemReport");
		SetValue("Method","MonthlyPRMSReport");
	
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
		<h3  style="color:white;"> Payroll Management System </h3>
		
		<div class="container">
		<fieldset>
				<div class="row">
					<div class="col-25">
						<label for="Branch_Code">Branch Code</label>
					</div>
					<div class="col-45">
						<input type="text" id="Branch_Code" name="Branch_Code" onkeypress="BranchCodeValidation(event)" readonly>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="Year">Year</label>
					</div>
					<div class="col-45">
						<input type="text" id="Year" name="Year" onkeypress="YearValidation(event)">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
							<label for="MonthCode">Month</label>
					</div>
					<div class="col-75">
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
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="details_rpt">Monthly Salary Details Report</option>
							<option value="bank_adv_rpt">Monthly Salary Bank Advice Report</option>
							<option value="indvidual_pay_slip">Monthly Individual Payslip</option>
							<option value="monthly_salary_summary">Monthly Salary Summary Report</option>
							<option value="monthly_others_All">Monthly Others Allowance Report</option>
							<option value="monthly_others_Ded">Monthly Others Deduction Report</option>														
							<option value="HBL">Monthly HB Advance Deduction Report</option>
							<option value="MOT">Monthly Motorcycle Deduction Report</option>
							<option value="COM">Monthly Computer Deduction Report</option>
							<option value="PFC">Monthly PF Contribution  Report</option>
							<option value="PFA">Monthly PF Advance Deduction Report</option>
							<option value="INC">Monthly Income Tax Deduction Report</option>
							<option value="WEL">Monthly Welfare & Newspaper Deduction Report</option>
							<option value="GEN">Monthly Grp. Insurance Report</option>
							<option value="PEN">Monthly Pension Fund Report</option>
							<option value="WAT">Monthly Water Bill Report</option>
							<option value="ELE">Monthly Electric Bill Report</option>
							<option value="GAS">Monthly Gas Bill Report</option>
						</select>
					</div>
				</div>
				</fieldset>
				<div class="col-75"></div>	
				
				<div class="row">
					<div class="col-15">					
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
						
					</div>
					<div class="col-15">
						<input type="submit" id="submit" value="Download!"  onclick="GenerateReport()" >
					</div>
					
				</div>											
		</div>
		<br><br><br>
			
 	
	</center>
</body>
</html>