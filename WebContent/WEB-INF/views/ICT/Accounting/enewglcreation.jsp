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

<title>Insert title here</title>

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

.col-15 {
	float: left;
	width: 15%;
}
.col-20 {
	float: left;
	width: 16%;
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
/* cause google chrome cant assign fetched data in front end form */

var userId="";

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function initValues(){	
	
	document.getElementById("glcode").value = "";
	document.getElementById("glname").value = "";
	document.getElementById("headglcode").value="";
	document.getElementById("entyDate").value="";
	document.getElementById("glremarks").value="";
	
	
	document.getElementById("glcode").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}

function glCodeValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("glcode", document.getElementById("glcode").value);
		SetValue("Class", "AccontingParameterSetup");
		SetValue("Method", "FetchGLCodeDetails");	
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {					
					document.getElementById("glname").value=obj.GLNAME;
					document.getElementById("gltype").value=obj.GL_TYPE;
					document.getElementById("subgl").value=obj.SUB_GL;
					document.getElementById("headglcode").value=obj.MAINHEAD;
					document.getElementById("expendituretype").value=obj.EXPENDITURE_TYPE;
					document.getElementById("incometype").value=obj.INCOME_TYPE;
					document.getElementById("entyDate").value=obj.ENTY_ON;
					document.getElementById("glremarks").value=obj.REMARKS;
					document.getElementById("glname").focus();
				}
			}
		};
		
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();					
   }
}

function glNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("gltype").focus();
	}
}
function GlTypeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("subgl").focus();
	}
}

function SubGlTypeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("headglcode").focus();
	}
}

function HeadGlValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("incometype").focus();
	}
}
function IncomeTypeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("expendituretype").focus();
	}
}

function ExpenditureTypeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("entyDate").focus();
	}
}


function GlEntyDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('entyDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("glremarks").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("entyDate").focus();
	    }
	}
}

function RemarksValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		 document.getElementById("submit").focus();
	}
}


function GLSetUpFunction(event)
{			
		clear();
		SetValue("User_Id",userId);		
		SetValue("glcode",document.getElementById("glcode").value);
		SetValue("glname",document.getElementById("glname").value);
		SetValue("gltype",document.getElementById("gltype").value);
		SetValue("subgl", document.getElementById("subgl").value);
		SetValue("headglcode",document.getElementById("headglcode").value);
		SetValue("expendituretype",document.getElementById("expendituretype").value);
		SetValue("incometype",document.getElementById("incometype").value);
		SetValue("entyDate",document.getElementById("entyDate").value);
		SetValue("glremarks",document.getElementById("glremarks").value);
		
		SetValue("Class","AccontingParameterSetup");
		SetValue("Method","GLSetupFunction");
		
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
	xhttp.open("POST", "HTTPValidator?" + DataMap, true);
	xhttp.send();			
}

$(function() {
	$("#entyDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>

</head>
<body onload="initValues()">
	<center>
		<div class="container">
		   		
		      <fieldset>
		      <legend>GL Identifier</legend> 
		       <div class="row">
					<div class="col-15">
						<label for="glcode">GL Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="glcode" name="glcode" onkeypress="glCodeValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="glname">GL Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="glname" name="glname" onkeypress="glNameValidation(event)" >
					</div>										
				 </div>		      				
				</fieldset>		
				<fieldset>	
				<legend>GL Details</legend>
															
				<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="gltype">GL Type </label>
					</div>				
					<div class="col-20">
						<select id="gltype" name="gltype" onkeypress="GlTypeValidation(event)" style="width: 175px;" >
							<option value="A">A-Asset </option>
							<option value="L">L-Liability</option>
						</select>
					</div>														
				</div>
				<br>
				
				<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="subgl">Sub GL ? </label>
					</div>				
					<div class="col-20">
						<select id="subgl" name="subgl" onkeypress="SubGlTypeValidation(event)" style="width: 175px;" >
							<option value="1">Y-Yes</option>
							<option value="0">N-No</option>
						</select>
					</div>	
					
				  <div class="colr-15">
						<label for="headglcode">Head GL Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="headglcode" name="headglcode" onkeypress="HeadGlValidation(event)">
					</div>
														
				</div>
				
				<br>
				<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="incometype">Income Type </label>
					</div>				
					<div class="col-20">
						<select id="incometype" name="incometype" onkeypress="IncomeTypeValidation(event)" style="width: 175px;" >
							<option value="C">C-Capital</option>
							<option value="R">R-Revenue</option>
						</select>
					</div>	
					
				  <div class="colr-15">
						<label for="expendituretype">Expenditure Type</label>
					</div>
					<div class="col-20">
						<select id="expendituretype" name="expendituretype" onkeypress="ExpenditureTypeValidation(event)" style="width: 175px;" >
							<option value="C">C-Capital</option>
							<option value="R">R-Revenue</option>
						</select>
					</div>
														
				</div>
								<br>
				<div class="row">
					<div class="col-15">
						<label for="entyDate">Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="entyDate" value="" onkeypress="GlEntyDateValidation(event)" >
					</div>										
				</div>	

			<div class="row">	
					
				  <div class="col-15">
						<label for="glremarks">Remarks</label>
					</div>
					<div class="col-80">
						<input type="text" id="glremarks" name="glremarks" onkeypress="RemarksValidation(event)">
					</div>
														
				</div>
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="GLSetUpFunction(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>