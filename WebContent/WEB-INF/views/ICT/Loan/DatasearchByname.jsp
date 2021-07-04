<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
	width: 27%;
}
.colr-20 {
	float: left;
	width: 28%;
	
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


function initValues(){
	var dt = new Date();
	var user = "<%= session.getAttribute("User_Id")%>";			
}

function Parameter1validation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MonthCode").focus();
	}
}


function GetSearchReport()
{	    
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";
	
	if (document.getElementById("parameter1").value=="" ){
		document.getElementById("parameter1").value="N/A";
	}
	if (document.getElementById("parameter2").value=="" ){
		document.getElementById("parameter2").value="N/A";
	}
	if (document.getElementById("parameter3").value=="" ){
		document.getElementById("parameter3").value="N/A";
	}
	if (document.getElementById("parameter4").value=="" ){
		document.getElementById("parameter4").value="N/A";
	}
	if (document.getElementById("parameter5").value=="" ){
		document.getElementById("parameter5").value="N/A";
	}
	if (document.getElementById("parameter6").value=="" ){
		document.getElementById("parameter6").value="N/A";
	}
	if (document.getElementById("parameter7").value=="" ){
		document.getElementById("parameter7").value="N/A";
	}
	if (document.getElementById("parameter8").value=="" ){
		document.getElementById("parameter8").value="N/A";
	}
	if (document.getElementById("parameter9").value=="" ){
		document.getElementById("parameter9").value="N/A";
	}
	if (document.getElementById("parameter10").value=="" ){
		document.getElementById("parameter10").value="N/A";
	}
	
	var DataString="ReportType="+document.getElementById("ReportType").value+"&loggedBranch="+usr_brn
	+"&p_type="+document.getElementById("SearchBy").value
	+"&parameter1="+document.getElementById("parameter1").value
	+"&parameter2="+document.getElementById("parameter2").value
	+"&parameter3="+document.getElementById("parameter3").value
	+"&parameter4="+document.getElementById("parameter4").value
	+"&parameter5="+document.getElementById("parameter5").value
	+"&parameter6="+document.getElementById("parameter6").value
	+"&parameter7="+document.getElementById("parameter7").value
	+"&parameter8="+document.getElementById("parameter8").value
	+"&parameter9="+document.getElementById("parameter9").value
	+"&parameter10="+document.getElementById("parameter10").value;
	
	
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "DataSearchingServlet?"+DataString, true);
		
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
		<div class="container">
		<fieldset>	
		   <legend>Data Searching Parameter List</legend> 	
		   		<div class="row">
					<div class="col-15">
							<label for="SearchBy">Search By</label>
					</div>
					<div class="col-75">
						<select id="SearchBy" name="SearchBy" >
							<option value="N">Search By Name</option>
							<option value="ID">Search By NID</option>	
																				
						</select>
					</div>
				</div>
		   		
				<div class="row">
					<div class="col-15">
						<label for="parameter1">Parameter1</label>
					</div>
					<div class="col-20">
						<input type="text" id="parameter1" name="parameter1" onkeypress="Parameter1validation(event)">
					</div>
										
					<div class="colr-15">
						<label for="parameter1">Parameter2</label>
					</div>
					<div class="colr-20">
						<input type="text" id="parameter2" name="parameter2" onkeypress="Parameter2validation(event)">
					</div>					
				</div>	
				<div class="row">
					<div class="col-15">
						<label for="parameter3">Parameter3</label>
					</div>
					<div class="col-20">
						<input type="text" id="parameter3" name="parameter3" onkeypress="Parameter3validation(event)">
					</div>
										
					<div class="colr-15">
						<label for="parameter4">Parameter4</label>
					</div>
					<div class="colr-20">
						<input type="text" id="parameter4" name="parameter4" onkeypress="Parameter4validation(event)">
					</div>										
				</div>	
					
				<div class="row">
					<div class="col-15">
						<label for="parameter5">Parameter5</label>
					</div>
					<div class="col-20">
						<input type="text" id="parameter5" name="parameter5" onkeypress="Parameter5validation(event)">
					</div>
										
					<div class="colr-15">
						<label for="parameter6">Parameter6</label>
					</div>
					<div class="colr-20">
						<input type="text" id="parameter6" name="parameter6" onkeypress="Parameter6validation(event)">
					</div>					
				</div>	
				<div class="row">
					<div class="col-15">
						<label for="parameter7">Parameter7</label>
					</div>
					<div class="col-20">
						<input type="text" id="parameter7" name="parameter7" onkeypress="Parameter7validation(event)">
					</div>
										
					<div class="colr-15">
						<label for="parameter8">Parameter8</label>
					</div>
					<div class="colr-20">
						<input type="text" id="parameter8" name="parameter8" onkeypress="Parameter8validation(event)">
					</div>					
				</div>		
				
				<div class="row">
					<div class="col-15">
						<label for="parameter1">Parameter9</label>
					</div>
					<div class="col-20">
						<input type="text" id="parameter9" name="parameter9" onkeypress="Parameter9validation(event)">
					</div>
										
					<div class="colr-15">
						<label for="parameter1">Parameter10</label>
					</div>
					<div class="colr-20">
						<input type="text" id="parameter10" name="parameter10" onkeypress="Parameter10validation(event)">
					</div>					
				</div>								
			
				<div class="row">
					<div class="col-15">
							<label for="ReportType">Search Type</label>
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="ALL">All-All Product Report</option>
							<option value="BHBFC">OLD-Product Search</option>	
							<option value="BHBFCFLAT">EMI-Product Search</option>
							<option value="BHBFCOCR">OCR- Search</option>
							<option value="BHBFCPRJ">ISF- Search</option>
							<option value="BranchLoan">Branch Wise Account List</option>	
																				
						</select>
					</div>
				</div>
				</fieldset>
				<div class="row">
					<div class="col-25">
						<label for="report_download"></label>
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Download" onclick="GetSearchReport()" > <br>
					</div>
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>