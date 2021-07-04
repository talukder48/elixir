<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Bangladesh House Building Finance Corporation</title>

<style>

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

.col-15 {
	float: left;
	width: 20%;
}
.col-20 {
	float: left;
	width: 20%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.colr-20 {
	float: left;
	width: 28%;
	
}
.collvl-40 {
	float: left;
	width: 60%;
	
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
.col-80 {
	float: left;
	width: 52%;
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
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  left: 40px;
  right: 0;
  width:300px
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
}
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  top: 100%;
  left: 0;
  right: 0;
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
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
/* cause google chrome cant assign fetched data in front end form */

var userId="";

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function initValues(){	
	
	document.getElementById("EmployeeID").value = "";
	document.getElementById("LocationCode").value = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("EmployeeName").value="";	
	document.getElementById("IncentiveBasic").value="0.00";
	document.getElementById("IncentivePct").value="1"
	document.getElementById("EmployeeID").focus();	
}

function EmployeeIDValidation(event){
		if (event.keyCode == 13 || event.which == 13) {			
		clear();	
		SetValue("EmployeeID", document.getElementById("EmployeeID").value,"N");
		SetValue("LocationCode", document.getElementById("LocationCode").value,"N");
		SetValue("FinanYear", document.getElementById("FinanYear").value,"N");
		SetValue("Class", "elixir.validator.pps.FinanceOperation","N");
		SetValue("Method", "FetchIncentiveData","L");	
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
						document.getElementById("EmployeeName").value=obj.EMPLOYEE_NAME;
						document.getElementById("IncentiveBasic").value=parseFloat(obj.INCENTIVE_BASIC).toFixed(2);	
						document.getElementById("IncentivePct").value=parseFloat(obj.INCENTIVE_PCT).toFixed(2);	
						document.getElementById("IncentiveBasic").focus();
					}
			  });		
   }
}

function IncentiveBasicValidation(){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("IncentivePct").focus();
	}
}
function IncentivePctValidation(){
	if (event.keyCode == 13 || event.which == 13) {				
		document.getElementById("submit").focus();
	}
}



function UpdateIncentivceData(event)
{	 
	clear();	
	SetValue("EmployeeID", document.getElementById("EmployeeID").value,"N");
	SetValue("LocationCode", document.getElementById("LocationCode").value,"N");
	SetValue("FinanYear", document.getElementById("FinanYear").value,"N");
	SetValue("IncentiveBasic", document.getElementById("IncentiveBasic").value,"N");
	SetValue("IncentivePct", document.getElementById("IncentivePct").value,"N");
	SetValue("Class","elixir.validator.pps.FinanceOperation","N");
	SetValue("Method","UpdateIncentiveData","L");
		
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
				alert(obj.SUCCESS);
				initValues();
			}		
	});	
								 				
}

</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3  style="color:white;"> Payroll Management System </h3>
		<div class="container">
		   	<h3>Incentive Data Entry Page</h3>
		      <fieldset>
		      <legend>Employee Data </legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="LocationCode">Branch Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="LocationCode" name="LocationCode"  >
					</div>	
										
					 <div class="col-15">
						<label for="FinanYear">Financial Year</label>
					</div>
					<div class="col-20">
						<select id="FinanYear" name="FinanYear"   style="width: 240px;">	
						    <option value="2018-2019">2018-2019</option>					   
							<option value="2019-2020">2019-2020</option>
							<option value="2020-2021">2020-2021</option>	
							<option value="2021-2022">2021-2022</option>
							<option value="2022-2023">2022-2023</option>							
						</select>
					</div>																								
				 </div>		
		      
		       <div class="row">
					<div class="col-15">
						<label for="EmployeeID">Emp ID/PF No</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeID" name="EmployeeID" onkeypress="EmployeeIDValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="EmployeeName">Employee Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeName" name="EmployeeName" readonly >
					</div>										
				 </div>									 
				 	      				
				</fieldset>	
					
				<fieldset>	
				
				<legend>Employee Incentive Data </legend>
																			 										
				<div class="row">
					<div class="col-15">
						<label for="IncentiveBasic">Incentive Basic</label>
					</div>
					<div class="col-20">
						<input type="text" id="IncentiveBasic" name="IncentiveBasic" onkeypress="IncentiveBasicValidation(event)">
					</div>	
					
					<div class="collvl-40">
						<label for="IncentiveBasic">[Jun 30,(Basic Salary Amount)]</label>
					</div>
					
																						
				 </div>	
				 
				 
				 <div class="row">
					<div class="col-15">
						<label for="IncentivePct">Incentive Ratio</label>
					</div>
					<div class="col-20">
						<input type="text" id="IncentivePct" name="IncentivePct" onkeypress="IncentivePctValidation(event)">
					</div>	
					
					<div class="collvl-40">
						<label for="IncentivePct">[If Employee get Full then Incentive Ratio= 1, Else Incentive Ratio= 1*(no of days/365)]</label>
					</div>
																						
				 </div>	
				 				 							
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				
				
			<div class="row">
				<div class="col-15">					
					<form action="currentUserHomePage.do" method="post">
					<input type="submit" id="submit" value="Home"  > 
					</form>
					
				</div>
				<div class="col-15">
					<input type="submit" id="submit" value="Submit"  onclick="UpdateIncentivceData(event)" >
				</div>					
			  </div>
				
			 </div>
			</div>
	</center>
</body>
</html>