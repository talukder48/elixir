<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<style> 
body {
  background-color: #cccccc;
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
	background-color: #FAE5D3;
	padding: 20px;
}

.col-25 {
	float: left;
	width: 15%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
}
.col-45{
float: left;
	width: 20%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 40%;
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
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BranchCode").value=usr_brn;
	
	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
	var current_datetime = new Date()
	entdOn = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
	document.getElementById("MonthCode").value = dt.getMonth()+1; 
	
	if(user == "F9999" || "F1520"){
		document.getElementById('Branch_Code').readOnly = false;
	}
	
	document.getElementById("BranchCode").focus();
}
function BranchCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
	if (document.getElementById("Branch_Code").value != "") {
		clear();
		SetValue("branch_code",document.getElementById("Branch_Code").value);
		SetValue("Class","PRMSValidator");
		SetValue("Method","BranchKeyPress");
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
					} else {						
						document.getElementById("BranchCode").focus();
					}					
				}
			}
		};
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();
	}
	else{
		document.getElementById("BranchCode").focus();
	}
 }
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
$(function() {
	$("#TransactionDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});


function AuthBatchNumber(event){
	var user = "<%= session.getAttribute("User_Id")%>";
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		    clear();
		    SetValue("BranchCode",document.getElementById("BranchCode").value);
		    SetValue("User_Id",user);	
		    SetValue("TransactionDate",document.getElementById("TransactionDate").value);
		    SetValue("BatchNumber",document.getElementById("BatchNumber").value);		    
			SetValue("Class","AccountingManagement");
			SetValue("Method","AuthorizeTransaction");
			
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
			xhttp.open("POST", "TransactionServlet?" + DataMap, true);
			xhttp.send();		  
	  } else {
		  document.getElementById("authbatch").focus();
	  }	
}

function ViewBatchNumber()
{	    
	   
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	var DataString="loggedBranch="+usr_brn+"&ReportType="+document.getElementById("ReportType").value+
	"&BranchCode="+document.getElementById("BranchCode").value+
	"&TransactionDate="+document.getElementById("TransactionDate").value+
	"&BatchNumber="+document.getElementById("BatchNumber").value;
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "TranReportServlet?"+DataString, true);
		
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {
		        var filename = "Report_"+ document.getElementById("ReportType").value +".pdf";
		        if (typeof window.chrome !== 'undefined') {
		            // Chrome version
		            var link = document.createElement('a');
		            link.href = window.URL.createObjectURL(xhttp.response);		       
		            window.open(link.href);		            
		            //link.download = "PdfName-" + new Date().getTime() + ".pdf";
		            //link.click();
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
		<h1>Bangladesh House Building Finance Corporation</h1>
		<h4> General Accounting System System</h4>
		
		<div class="container">
		<fieldset>	
		   <legend>Transaction Details</legend> 			
				<div class="row">
					<div class="col-25">
						<label for="BranchCode">BranchCode</label>
					</div>
					<div class="col-45">
						<input type="text" id="BranchCode" name="BranchCode" onkeypress="BranchCodeValidation(event)">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="TransactionDate">Transaction Date</label>
					</div>
					<div class="col-45">
						<input type="text" id="TransactionDate" name="TransactionDate" onkeypress="BranchCodeValidation(event)">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="BatchNumber">Batch Number</label>
					</div>
					<div class="col-45">
						<input type="text" id="BatchNumber" name="BatchNumber" onkeypress="BranchCodeValidation(event)">
					</div>
				</div>
								
				<div class="row">
					<div class="col-25">
							<label for="ReportType">Report Type</label>
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="SingleBatch">Print Batch</option>									
						</select>
					</div>
				</div>
				</fieldset>
				<div class="row">
					<div class="col-25">
						<label for="report_download"></label>
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Print Batch" onclick="ViewBatchNumber()" > <br>
					</div>
					
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>