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
<style>

.datepicker
{ 
    width: 10.5em;
    height: 2.5em;
}
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

.col-15 {
	float: left;
	width: 20%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.coln-20 {
	float: left;
	width: 30%;
}
.col-20 {
	float: left;
	width: 20%;
}
.colr-20 {
	float: left;
	width: 20%;
	
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
	width: 35%;
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

function initValues(){
	document.getElementById("EmployeeId").value="";
	document.getElementById("EmployeeName").value="";
	document.getElementById("basicPay").value="";
	document.getElementById("taxDeduct").value="";
	document.getElementById("PFDeduct").value="";
	document.getElementById("bankACNo").value="";
	document.getElementById("EmployeeId").focus();
	
}
function EmployeeIdValidation(event){
	if(document.getElementById("EmployeeId").value==""){
		initValues();
	}
	if (event.keyCode == 13 || event.which == 13) {	
		var usr_brn = "<%= session.getAttribute("BranchCode")%>";
		clear();
		SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
		SetValue("UserBranchCode",usr_brn,"N");
		SetValue("Class","elixir.validator.pps.FinanceOperation","N");
		SetValue("Method","FetchEmpInitData","L");
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
						initValues();
					} else {
						 document.getElementById("EmployeeName").value=obj.EMP_NAME;						
						if(parseFloat(obj.NEW_BASIC)>0.0 || parseFloat(obj.TAX)>0.0 || parseFloat(obj.PF_DEDUCTION_PCT)>0.0 || obj.BANK_ACC!=null){							
								document.getElementById("basicPay").value=obj.NEW_BASIC;	
								document.getElementById("taxDeduct").value=obj.TAX;
								document.getElementById("PFDeduct").value=obj.PF_DEDUCTION_PCT;
								document.getElementById("bankACNo").value=obj.BANK_ACC;							
							var r = confirm("Profile already initialized!\nDo you want to update?");
							  if (r == true) {
								  document.getElementById("basicPay").focus();													   
							  } else {
								  initValues();							 
							  }		
						}else {
							document.getElementById("basicPay").value="";	
							document.getElementById("taxDeduct").value="";	
							document.getElementById("PFDeduct").value="";	
							document.getElementById("bankACNo").value="";	
							document.getElementById("basicPay").focus();							 
						  }							 				
					}					
		});
		
	}
}
function BasicPayValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("basicPay").value==""){			
			document.getElementById("basicPay").focus();
		}else{
			document.getElementById("taxDeduct").focus();	
		}		
	}	
}
function TaxDeductValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("taxDeduct").value==""){
			document.getElementById("taxDeduct").value=="0";
			document.getElementById("PFDeduct").focus();
		}else{
			document.getElementById("PFDeduct").focus();	
		}	
	}	
}
function PFDeductValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("PFDeduct").value==""){			
			document.getElementById("PFDeduct").focus();
		}else{
			document.getElementById("bankACNo").focus();	
		}
	}	
}
function BankACNoValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("bankACNo").value==""){			
			document.getElementById("bankACNo").focus();
		}else{
			document.getElementById("submit").focus();	
		}
	}
}

function InitProfile(event){
	clear();
	SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
	SetValue("basicPay",document.getElementById("basicPay").value,"N");
	SetValue("taxDeduct",document.getElementById("taxDeduct").value,"N");
	SetValue("PFDeduct",document.getElementById("PFDeduct").value,"N");
	SetValue("bankACNo",document.getElementById("bankACNo").value,"N");
	SetValue("Class","elixir.validator.pps.FinanceOperation","N");
	SetValue("Method","UpdateInitProfile","L");
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

function exit(){
	
	var User_Id="<%= session.getAttribute("User_Id")%>";
	var branch_code="<%= session.getAttribute("BranchCode")%>";
	clear();
	SetValue("User_Id",User_Id,"N");
	SetValue("branch_code",branch_code,"L");
	xmlFinal();							
	$.ajax({
		  method: "POST",
		  url: "RedirrectHandaler",
		  data: { DataString: DataMap }
		})
		  .done(function( responseMessage ) {
		    var obj = JSON.parse(responseMessage);
		    if (obj.ERROR_MSG != "") {
				alert(obj.ERROR_MSG);
			} else {
				
				if(obj.USER_TYPE=="BR"){
					alert(window.location.href)
					top.location = self.location.href = "/";
				}
				
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
		<fieldset>
			<div class="row">
				<div class="col-15">
					<label for="EmployeeId">Employee ID</label>
				</div>
				<div class="col-20">
					<input type="text" id="EmployeeId" name="EmployeeId" onkeypress="EmployeeIdValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="EmployeeName">Employee Name</label>
				</div>
				<div class="coln-20">
					<input type="text" id="EmployeeName" name="EmployeeName" readonly >
				</div>										
			 </div>
			 </fieldset>
			<fieldset>
				<div class="row">
				<div class="col-15">
					<label for="basicPay">Basic Pay </label>
				</div>
				<div class="col-20">
					<input type="text" id="basicPay" name="basicPay" onkeypress="BasicPayValidation(event)" readonly>
				</div>
				
				<div class="colr-15">
					<label for="taxDeduct">Tax Deduction</label>
				</div>
				<div class="colr-20">
					<input type="text" id="taxDeduct" name="taxDeduct" onkeypress="TaxDeductValidation(event)" >
				</div>										
			 </div>	
					
			<div class="row">
				<div class="col-15">
					<label for="PFDeduct">PF Deduct.(%) </label>
				</div>
				<div class="col-20">
					<input type="text" id="PFDeduct" name="PFDeduct" onkeypress="PFDeductValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="bankACNo" >Bank A/C No.</label>
				</div>
				<div class="colr-20">
					<input type="text" id="bankACNo" name="bankACNo"  onkeypress="BankACNoValidation(event)">
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
						<input type="submit" id="submit" value="Submit"  onclick="InitProfile(event)" >
					</div>
					
				</div>
		</div>
	</center>
</body>
</html>