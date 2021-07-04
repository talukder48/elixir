<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<style> 
body {
  /* background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
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
	background-color: #339933;
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
	 document.getElementById("Year").value= "";
	 document.getElementById("Branch_Code").value="";
	 
	 var dt = new Date();
		var user = "<%= session.getAttribute("User_Id")%>";
		document.getElementById("Branch_Code").value="<%= session.getAttribute("BranchCode")%>";	
		document.getElementById("Year").value=dt.getFullYear();
		
		const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		var current_datetime = new Date()
		entdOn = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		document.getElementById("MonthCode").value = dt.getMonth()+1; 
	 	 
		if(user == "BHBFC"){
			document.getElementById('Branch_Code').readOnly = false;
		}		
		document.getElementById("Year").focus();
}

function SendMail(event){
		clear();
		SetValue("Branch_Code",document.getElementById("Branch_Code").value);
		SetValue("Year",document.getElementById("Year").value);
		SetValue("MonthCode",document.getElementById("MonthCode").value);
		SetValue("mailcode",document.getElementById("mailcode").value);	
		
		SetValue("Class","SuperOperation");
		SetValue("Method","BulkMailSendMethod");
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					alert(obj.SUCCESS);
					//initValues();
				}									
		}
		};
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();			
}


</script>
<body onload="initValues()">
	<center>
	
	<br><br>
	<h2>Mail Service</h2>
	<div class="container">
	
				<div class="row">
					<div class="col-25">
						<label for="Branch_Code">Branch Code</label>
					</div>
					<div class="col-75">
						<input type="text" id="Branch_Code" name="Branch_Code" onkeypress="BranchCodeValidation(event)">
					</div>
				</div>
	
				<div class="row">
					<div class="col-25">
						<label for="Year">Year</label>
					</div>
					<div class="col-75">
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
						<label for="">Mail Type</label>
					</div>
					<div class="col-75">
					<select id="mailcode" name="mailcode">
						<option value="Payslip">Individual PaySlip</option>
						<option value="SalaryCertificate">Salary Certificate</option>
						<option value="details_branch">Salary Details Report</option>
						<option value="bank_advice_branch">Salary Bank Advice Report</option>
						<option value="payslip_branch">Monthly Individual Payslip</option>
						<option value="BranchLoan">Branch Wise account List</option>
						
					</select>
				</div>
				</div>
				<br>
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="mailId" value="Send Mail" onclick="SendMail(event)" >
				</div>
									
	</div>
	</center>
</body>
</html>