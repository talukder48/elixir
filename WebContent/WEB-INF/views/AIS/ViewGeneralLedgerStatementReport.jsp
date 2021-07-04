<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bangladesh House Building Finance Corporation</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
function SetValue(key,value,itemsl){
	if(itemsl=='L'){
		var Node ='"'+ key+'"'+":"+'"'+value+'"';
	}
	else{
		var Node ='"'+ key+'"'+":"+'"'+value+'"'+",";
	}
	DataMap=DataMap+Node;
}
function clear(){
	DataMap="";
}
function xmlFinal(){
	DataMap="{"+DataMap+"}";
}

var DataMapReport="";
function SetValueReport(key,value){
	var Node = key+"*"+value;
	if(DataMapReport!=""){
		DataMapReport=DataMapReport+"$"+Node;
	}
	else{
		DataMapReport="data="+Node;
	}
}
function clearReport(){
	DataMapReport="";
}

function loadgitem(){
	var loggedBranch="<%=session.getAttribute("BranchCode")%>";
	clear();		
	SetValue("loggedBranch", loggedBranch,"N");
	SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
	SetValue("Method", "FetchGLData","L");	
	xmlFinal();	
	$.ajax({
		  method: "POST",
		  url: "CommomAjaxCallHandler",
		  data: { DataString: DataMap }
		})
		  .done(function( responseMessage ) {
		    var obj = JSON.parse(responseMessage);
		    if (obj.ERROR_MSG != "") {
				alert(obj.ERROR_MSG);
			} else {				 
				gl_srting=obj.GL_LIST;					
				var select = document.getElementById("glcode");                  
				 var gl_arrayList = gl_srting.split(',');
				 for(var i = 0; i < gl_arrayList.length; i++) {
					 gl_arrayList[i] = gl_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");				
				    var gl_keyValue = gl_arrayList[i].split(':');
				    var option = document.createElement("option");
				    option.value=gl_keyValue[0];
				    option.text=gl_keyValue[1]+":"+gl_keyValue[0];	
				    select.add(option, null);				   				   
				 }
			}
	});					
}

function initValues(){
	loadgitem();
	var user = "<%= session.getAttribute("User_Id")%>";
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BranchCode").value=usr_brn;
	document.getElementById("BranchCode").focus();
}

$(function() {
	$("#TransactionDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

function ViewAllReport()
{	    
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";
	clearReport();		
	SetValueReport("loggedBranch",usr_brn);
	SetValueReport("BranchCode",document.getElementById("BranchCode").value);
	SetValueReport("ReportType",document.getElementById("ReportType").value);
	SetValueReport("glcode",document.getElementById("glcode").value);
	SetValueReport("Class","elixir.report.ics.GeneralAccountingReport");
	SetValueReport("Method","GeneralLedgerStatementPrint");
	var xhttp = new XMLHttpRequest();		
	xhttp.open("POST", "CommomReportHandler?"+DataMapReport, true);
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
		<h3  style="color:white;"> General Accounting System </h3>
		
		<div class="container">
		<fieldset>	
		   <legend>Transaction Details</legend> 			
				<div class="row">
					<div class="col-25">
						<label for="BranchCode">BranchCode</label>
					</div>
					<div class="col-45">
						<input type="text" id="BranchCode" name="BranchCode" readonly>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="glcode">GL Code</label>
					</div>
					<div class="col-75">
					<select id="glcode" name="glcode">
						
					</select>
					</div>
				</div>
												
				<div class="row">
					<div class="col-25">
							<label for="ReportType">Report Type</label>
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="GLStatement">GL Statement</option>
							<!-- <option value="ViewGLBalance">GL Balance List</option> -->
						</select>
					</div>
				</div>
				</fieldset>
				<div class="row">
					<div class="col-25">
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Print Report" onclick="ViewAllReport()" > <br>
					</div>
					
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>