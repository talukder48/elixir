<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>  
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />  
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>  
</head>
<title>Bangladesh House Building Finance Corporation</title>
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

/* Back Button --Salary Report Page  */

.backButton {
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

.backButton {
  background-color: #ffe6e6; 
  color: black; 
  border: 2px solid #008CBA;
}

.backButton span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.3s;
}

.backButton span:after {
  content: '\00ab';
  position: absolute;
  opacity: 0;
  top: 0;
  left: -20px;
  transition: 0.3s;
  
}

.backButton:hover {
  background-color: #4CAF50;
  color: white;
}
.backButton:hover span {
  padding-left: 25px;
}

.backButton:hover span:after {
  opacity: 1;
  left: 0;
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
	document.getElementById("Branch_Code").value="<%= session.getAttribute("BranchCode")%>";	
	var user = "<%= session.getAttribute("User_Id")%>";
	document.getElementById("Year").value=dt.getFullYear();
	document.getElementById("Year").focus();
	if(user == "F9999" || "F1520"){
		document.getElementById('Branch_Code').readOnly = false;
	}
	
}
function ValidateEmployeeId()
{
	if (event.keyCode == 13 || event.which == 13) {
		
	}
}

function YearValidation()
{
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MonthCode").focus();
	}
}

function MonthCodeValidation()
{
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ReportType").focus();
	}
}

function GenerateReport(){	
	
		clear();
		SetValue("Branch_Code",document.getElementById("Branch_Code").value);
		SetValue("Year",document.getElementById("Year").value);
		SetValue("MonthCode",document.getElementById("MonthCode").value);
		SetValue("bonusType",document.getElementById("bonusType").value);
		SetValue("ReportType",document.getElementById("ReportType").value);
		SetValue("Class","elixir.report.ics.PayrollManagementSystemReport");
		SetValue("Method","BonusPRMSReport");

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
<body onload="initValues()">
	<center>		
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3  style="color:white;"> Payroll Management System </h3>
		<div class="container">
				<div class="row">
					<div class="col-25">
						<label for="Branch_Code">Branch Code</label>
					</div>
					<div class="col-45">
						<input type="text" id="Branch_Code" name="Branch_Code" readonly>
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
							<label for="bonusType">Bonus Type</label>
					</div>
					<div class="col-75">
						<select id="bonusType" name="bonusType" >
								<option value="EIDFT">Eid-Ul-Fitr</option>
								<option value="EIDAH">Eid-Ul-Adha</option>
								<option value="NEWYR">Nabobarsha</option>
								<option value="DURGA">Durga Puja</option>
								<!-- <option value="INCTV">Incentive</option> -->
								
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-25">
							<label for="ReportType">Report Type</label>
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
								<option value="bonus_dtl_rpt">Details Report</option>
								<option value="_bonus_bank_adv_rpt">Bank Advice Report</option>
						</select>
					</div>
				</div>
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
		
			
			
	</center>	
</body>

</html>