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
  background-color: #ffffff; 
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
	
	document.getElementById("LoanAcc").value = "";
	document.getElementById("LocationCode").value = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BorrowerName").value="";
	document.getElementById("LoanType").value="";
	document.getElementById("productNature").value="";	
	document.getElementById("SiteLocation").value="";
	document.getElementById("Address").value="";
	document.getElementById("MailAddress").value="";
	document.getElementById("PhoneAddress").value="";
	
	document.getElementById("LoanAcc").focus();	
}

function LoanAccValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
		
		var string=document.getElementById("LoanAcc").value;
		document.getElementById("LoanAcc").value=string.padStart(8, '0');
		
		clear();	
		SetValue("LoanAcc", document.getElementById("LoanAcc").value,"N");
		SetValue("LocationCode", document.getElementById("LocationCode").value,"N");
		SetValue("LocationCatagory", document.getElementById("LocationCatagory").value,"N");
		SetValue("Class", "elixir.validator.pps.ServiceValidation","N");
		SetValue("Method", "FetchAccountDetails","L");	
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
					document.getElementById("BorrowerName").value=obj.BORROWER_NAME;
					document.getElementById("LoanType").value=obj.LN_TYPE;
					document.getElementById("productNature").value=obj.PROD_NATURE;
					document.getElementById("SiteLocation").value=obj.SITE_ADD;
					document.getElementById("Address").value=obj.ADDRESS;
					document.getElementById("MailAddress").value=obj.EMAIL_ID;					
					document.getElementById("PhoneAddress").value=obj.PHONE_NUMBER;					
					document.getElementById("MailAddress").focus();
				}			
		}); 		
						
   }
}

function validateEmail(email) {
	  const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}

function EmailIdValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		 if (validateEmail(document.getElementById("MailAddress").value)) {
			 document.getElementById("PhoneAddress").focus();
			  } else {
			    alert(document.getElementById("MailAddress").value + " is not valid ");
			    document.getElementById("MailAddress").focus();
			  }
	}
}

function PhoneNumberValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var phoneno = /^\d{11}$/;
		var inputText=document.getElementById("PhoneAddress").value;
		if((inputText.match(phoneno))){
			document.getElementById("submit").focus();
		}else{
			alert(document.getElementById("PhoneAddress").value + " is not valid ");
		    document.getElementById("PhoneAddress").focus();
		}
	}
}

function UpdateBorrowerData(event)
{
	 if (!validateEmail(document.getElementById("MailAddress").value)) {
		 alert(document.getElementById("MailAddress").value + " is not valid ");
		    document.getElementById("MailAddress").focus();
	 }
	 else{
		    var phoneno = /^\d{11}$/;
			var inputText=document.getElementById("PhoneAddress").value;
			if(!(inputText.match(phoneno))){
				alert(document.getElementById("PhoneAddress").value + " is not valid ");
			    document.getElementById("PhoneAddress").focus();
			}
			else{
				
				clear();	
				SetValue("LoanAcc", document.getElementById("LoanAcc").value,"N");
				SetValue("LocationCode", document.getElementById("LocationCode").value,"N");
				SetValue("LocationCatagory", document.getElementById("LocationCatagory").value,"N");
				SetValue("MailAddress", document.getElementById("MailAddress").value,"N");
				SetValue("PhoneAddress", document.getElementById("PhoneAddress").value,"N");	
				SetValue("Class", "elixir.validator.pps.ServiceValidation","N");
				SetValue("Method","UpdateBorrowerDeduction","L");					
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
	 }				
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
		   	<h1 style="color:green;">Bangladesh House Building Finance Corporation</h1>
		         <h3  style="color:green;"> Service Simplification (LMS) </h3>
		      <fieldset>
		      <legend>Borrower Loan Case </legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="LocationCode">Office Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="LocationCode" name="LocationCode" onkeypress="LocationCodeValidation(event)" readonly>
					</div>	
										
					 <div class="col-15">
						<label for="LocationCatagory">Loan Category</label>
					</div>
					<div class="col-20">
						<select id="LocationCatagory" name="LocationCatagory"   style="width: 240px;">						   
							<option value="00">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
						</select>
					</div>																								
				 </div>		
		      
		       <div class="row">
					<div class="col-15">
						<label for="LoanAcc">Loan Account</label>
					</div>
					<div class="col-20">
						<input type="text" id="LoanAcc" name="LoanAcc" onkeypress="LoanAccValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="BorrowerName">Borrower Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="BorrowerName" name="BorrowerName" readonly >
					</div>										
				 </div>	
				
				 
				 	      				
				</fieldset>	
					
				<fieldset>	
				<legend>Borrower Details </legend>
															
				  <div class="row">
					<div class="col-15">
						<label for="LoanType">Loan Type</label>
					</div>
					<div class="col-20">
						<input type="text" id="LoanType" name="LoanType" readonly>
					</div>
					
					<div class="col-15">
						<label for="productNature">Product Nature</label>
					</div>
					<div class="col-20">
						<input type="text" id="productNature" name="productNature" readonly >
					</div>										
				 </div>	
				
				
				 <div class="row">
					<div class="col-15">
						<label for="SiteLocation">Site Location</label>
					</div>
					<div class="col-20">
						<textarea id="SiteLocation" name="SiteLocation" rows="3" cols="40" readonly ></textarea>
					</div>
					
					<div class="col-15">
						<label for="Address">Address</label>
					</div>
					<div class="col-20">
						<textarea id="Address" name="Address" rows="3" cols="40" readonly ></textarea>
					</div>										
				 </div>	
				
				<div class="row">
					<div class="col-15">
						<label for="MailAddress">Mail Address</label>
					</div>
					<div class="col-20">
						<input type="text" id="MailAddress" name="MailAddress" onkeypress="EmailIdValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="PhoneAddress">Phone Number</label>
					</div>
					<div class="col-20">
						<input type="text" id="PhoneAddress" name="PhoneAddress"  onkeypress="PhoneNumberValidation(event)">
					</div>										
				 </div>	
			
				</fieldset>	
						
						<br>
				<div class="row">
				
					<div class="col-15">					
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
						
					</div>
					<div class="col-20">
						<input type="submit" id="Submit" value="Submit" onclick="UpdateBorrowerData(event)" > 
					</div>									
			   </div>			
																	
				
			</div>
	</center>
</body>
</html>