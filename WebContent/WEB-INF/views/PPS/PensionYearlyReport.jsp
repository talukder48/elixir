<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Year </title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>  
<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">


     
    <script type="text/javascript">  
        $(function()  
        {  
            var year;  
            $("#financial_Year").datepicker(  
            {  
                onSelect: function(dateText, inst)  
                {  
                    var date = $(this).datepicker('getDate'),  
                        day = date.getDate(),  
                        month = date.getMonth(),  
                        year = date.getFullYear();  
                    year1 = date.getFullYear();  
                    if (month < 3)  
                    {  
                        /* yearyear = year - 1;  
                        year1year1 = year1.toString().substring(2);   */
                    }  
                    else  
                    {  
                        /* yearyear = year;  
                        year1 = (year1 + 1).toString().substring(2);; */  
                        
                    }  
                    $("#financial_Year").val(year-1 + '-' + year1);  
                },  
            });  
        });  
    </script>  
    
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
	document.getElementById("NothiNo").focus();	
}


function FinancialYearValidation(event)
{
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("report_download").focus();
	}
}

function GenerateReport(){	
	
		var DataString = "ReportType="+document.getElementById("ReportType").value;	
		var NothiNo = document.getElementById("NothiNo").value;
		
	    if(NothiNo==""){
	    	NothiNo="N/A";
	    }
		
	   if(document.getElementById("financialYear").value == ""){
			alert("Please enter Finnancial Year");
			document.getElementById("financialYear").focus();
			return;
		}	
	   var loggedBranch="<%=session.getAttribute("BranchCode")%>";
	   
			
		clear();
		SetValue("loggedBranch",loggedBranch);
		SetValue("NothiNo",NothiNo);
		SetValue("financialYear",document.getElementById("financialYear").value);
		SetValue("Class","elixir.report.ics.PensionPaymentSystemReport");
		SetValue("Method","YearlyPensionPaymentSystemReport");
	
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "CommomReportHandler?"+DataMap, true);
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {
		        var filename = "Report_"+ document.getElementById("ReportType").value+".pdf";
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
		
		initValues();
}

</script>
</head>
<body onload="initValues()">
		<center>
		<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3 style="color:white;">Pension Payment System</h3>
		
		<div class="container">
				
				<div class="row">
					<div class="col-25">
						<label for="NothiNo">Nothi No</label>
					</div>
					<div class="col-45">
						<input type="text" id="NothiNo" name="NothiNo">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="financialYear">Financial Year</label>
					</div>
					<div class="col-45">
						<input type="text" id="financialYear" name="financialYear" onkeypress="FinancialYearValidation(event)" onClick="FinancialYearValidation(event)" placeholder = "e.g: 2019-2020">
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
							<label for="ReportType">Report Type</label>                                                                                                                                                                                                                              
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="PensionCertificate">Pension Certificate</option> 
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="report_download"></label>
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Download" onclick="GenerateReport()" > <br>
					</div>
				</div>													
		</div>					
			
	</center>
</body>
</html>