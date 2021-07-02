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
<style>

.datepicker
{ 
    width: 10.5em;
    height: 2.5em;
}
body {
  background-color: #006666;
  /* background-image: url('../../Media/bg6.jpg') ;
  background-repeat: repeat;
  background-size: /* 300px 100px  auto ; */
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
	width: 15%;
}
.colr-15 {
	float: left;
	width: 20%;
	margin-left: 50px;
}
.col-20 {
	float: left;
	width: 20%;
}
.coln-20 {
	float: left;
	width: 30%;
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
	document.getElementById("telephone").value="0";
	document.getElementById("transport").value="0";
	document.getElementById("arrear").value="0";
	document.getElementById("wash").value="0";
	document.getElementById("domestic").value="0";
	document.getElementById("others").value="0";
	document.getElementById("entertainment").value="0";
	document.getElementById("education").value="0";
	document.getElementById("remarksOthers").value="0";
	document.getElementById("hillAllwnc").value="0";
	document.getElementById("arrearBasic").value="0";
	document.getElementById("EmployeeId").focus();
}
function EmployeeIdValidation(event){
	if(document.getElementById("EmployeeId").value==""){
		initValues();
	}
	if (event.keyCode == 13 || event.which == 13) {
		var usr_brn="<%=session.getAttribute("BranchCode")%>";
		clear();
		SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
		SetValue("UserBranchCode",usr_brn,"N");
		SetValue("Class","elixir.validator.pps.FinanceOperation","N");
		SetValue("Method","FetchAllowanceData","L");
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
						document.getElementById("telephone").value=obj.TEL_ALLOWANCE;
						document.getElementById("transport").value=obj.TRANS_ALLOWANCE;
						document.getElementById("arrear").value=obj.ARREAR;
						document.getElementById("wash").value=obj.WASH_ALLOWANCE;
						document.getElementById("domestic").value=obj.DOMES_ALLOWANCE;
						document.getElementById("others").value=obj.OTHER_ALLOWANCE;
						document.getElementById("entertainment").value=obj.ENTERTAIN_ALLOWANCE;
						document.getElementById("education").value=obj.EDU_ALLOWANCE;
						document.getElementById("hillAllwnc").value=obj.HILL_ALLWNC;
						document.getElementById("arrearBasic").value=obj.ARREAR_BASIC;
						document.getElementById("arrearHR").value=obj.HR_AREAR_ALW;
						if(obj.OTHER_ALLOWANCE>0){
							document.getElementById("remarksOthers").value=obj.REMARKS;
						}
						document.getElementById("telephone").focus();
				}			
		});
				
	}
}

function TelAndIntValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("transport").focus();
	}
}
function TransportValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("arrear").focus();
	}
}
function ArrearValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("wash").focus();
	}
}
function WashValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("education").focus();
	}
}
function EducationValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("entertainment").focus();
	}
}
function EntertainmentValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("domestic").focus();
	}
}
function DomesticValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("hillAllwnc").focus();
	}
}

function HillAllwncValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("others").focus();
	}
}
function OthersValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("remarksOthers").focus();
	}
}

function RemarksValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("arrearBasic").focus();
	}
}

function ArrearBasicValidation(event){
	
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("arrearHR").focus();
	}
}

function ArreararrearHRValidation(event){
	
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

function UpdateEmployeeAllowance(event){
	
	if (document.getElementById("remarksOthers").value=="")document.getElementById("remarksOthers").value="NA";		
			clear();
			var User_Id="<%= session.getAttribute("User_Id")%>";
			SetValue("User_Id",User_Id,"N");
			SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
			SetValue("telephone",document.getElementById("telephone").value,"N");
			SetValue("transport",document.getElementById("transport").value,"N");
			SetValue("arrear",document.getElementById("arrear").value,"N");
			SetValue("education",document.getElementById("education").value,"N");
			SetValue("entertainment",document.getElementById("entertainment").value,"N");
			SetValue("domestic",document.getElementById("domestic").value,"N");
			SetValue("wash",document.getElementById("wash").value,"N");		
			SetValue("arrearBasic",document.getElementById("arrearBasic").value,"N");
			SetValue("others",document.getElementById("others").value,"N");
			SetValue("remarksOthers",document.getElementById("remarksOthers").value,"N");
			SetValue("hillAllwnc",document.getElementById("hillAllwnc").value,"N");	
			SetValue("arrearHR",document.getElementById("arrearHR").value,"N");
			SetValue("Class","elixir.validator.pps.FinanceOperation","N");
			SetValue("Method","UpdateAllowance","L");
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
					<label for="telephone">Tel./Internet </label>
				</div>
				<div class="col-20">
					<input type="text" id="telephone" name="telephone"  onkeypress="TelAndIntValidation(event)" >
				</div>
				
				<div class="colr-15">
					<label for="transport">Transport</label>
				</div>
				<div class="colr-20">
					<input type="text" id="transport" name="transport"  onkeypress="TransportValidation(event)" >
				</div>										
			  </div>	
					
			<div class="row">
				<div class="col-15">
					<label for="arrear">Arrear(Other) </label>
				</div>
				<div class="col-20">
					<input type="text" id="arrear" name="arrear"   onkeypress="ArrearValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="wash">Wash</label>
				</div>
				<div class="colr-20">
					<input type="text" id="wash" name="wash"  onkeypress="WashValidation(event)" >
				</div>										
			  </div>	
			
			<div class="row">
				<div class="col-15">
					<label for="education">Education </label>
				</div>
				<div class="col-20">
					<input type="text" id="education" name="education"  onkeypress="EducationValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="entertainment">Entertainment</label>
				</div>
				<div class="colr-20">
					<input type="text" id="entertainment" name="entertainment"   onkeypress="EntertainmentValidation(event)">
				</div>										
			  </div>	
			  
			  <div class="row">
				<div class="col-15">
					<label for="domestic">Domestic </label>
				</div>
				<div class="col-20">
					<input type="text" id="domestic" name="domestic"  onkeypress="DomesticValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="others">Others</label>
				</div>
				<div class="colr-20">
					<input type="text" id="others" name="others"   onkeypress="OthersValidation(event)">
				</div>										
			  </div>	
			  
			  <div class="row">
				<div class="col-15">
					<label for="hillAllwnc">Hill Allw. </label>
				</div>
				<div class="col-20">
					<input type="text" id="hillAllwnc" name="hillAllwnc"  onkeypress="HillAllwncValidation(event)">
				</div>
				
				<div class="colr-15">
					<label for="remarksOthers">Remarks</label>
				</div>
				<div class="colr-20">
					<input type="text" id="remarksOthers" name="remarksOthers"   onkeypress="RemarksValidation(event)">
				</div>										
			  </div>	
			  
			  <div class="row">
			  
				<div class="col-15">
					<label for="arrearBasic">Arrear Basic </label>
				</div>
				<div class="col-20">
					<input type="text" id="arrearBasic" name="arrearBasic"  onkeypress="ArrearBasicValidation(event)">
				</div>	
				
				<div class="colr-15">
					<label for="arrearHR">Arrear HR </label>
				</div>
				<div class="colr-20">
					<input type="text" id="arrearHR" name="arrearHR"  onkeypress="ArreararrearHRValidation(event)">
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
					<input type="submit" id="submit" value="Submit"  onclick="UpdateEmployeeAllowance(event)" >
				</div>					
			</div>
						
		</div>
	</center>
</body>
</html>