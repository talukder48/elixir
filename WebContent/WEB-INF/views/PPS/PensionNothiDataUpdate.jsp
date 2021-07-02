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
	text-align: left;
	width: 10%;
}
.colr-15 {
	float: left;
	text-align: left;
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

function autocomplete(inp, arr) {
	  var currentFocus;
	  inp.addEventListener("input", function(e) {
	      var a, b, i, val = this.value;
	      closeAllLists();
	      if (!val) { return false;}
	      currentFocus = -1;
	      a = document.createElement("DIV");
	      a.setAttribute("id", this.id + "autocomplete-list");
	      a.setAttribute("class", "autocomplete-items");
	      this.parentNode.appendChild(a);
	      for (i = 0; i < arr.length; i++) {
	        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
	          b = document.createElement("DIV");
	          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
	          b.innerHTML += arr[i].substr(val.length);
	          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
	          b.addEventListener("click", function(e) {
	              inp.value = this.getElementsByTagName("input")[0].value;
	              closeAllLists();
	          });
	          a.appendChild(b);
	        }
	      }
	  });
	  inp.addEventListener("keydown", function(e) {
	      var x = document.getElementById(this.id + "autocomplete-list");
	      if (x) x = x.getElementsByTagName("div");
	      if (e.keyCode == 40) {
	        currentFocus++;
	        addActive(x);
	      } else if (e.keyCode == 38) { //up
	        currentFocus--;
	        addActive(x);
	      } else if (e.keyCode == 13) {
	        e.preventDefault();
	        if (currentFocus > -1) {
	          if (x) x[currentFocus].click();
	        }
	      }
	  });
	  function addActive(x) {
	    if (!x) return false;
	    removeActive(x);
	    if (currentFocus >= x.length) currentFocus = 0;
	    if (currentFocus < 0) currentFocus = (x.length - 1);
	    x[currentFocus].classList.add("autocomplete-active");
	  }
	  function removeActive(x) {
	    for (var i = 0; i < x.length; i++) {
	      x[i].classList.remove("autocomplete-active");
	    }
	  }
	  function closeAllLists(elmnt) {
	    var x = document.getElementsByClassName("autocomplete-items");
	    for (var i = 0; i < x.length; i++) {
	      if (elmnt != x[i] && elmnt != inp) {
	        x[i].parentNode.removeChild(x[i]);
	      }
	    }
	  }
	  document.addEventListener("click", function (e) {
	      closeAllLists(e.target);
	  });
	}




/* cause google chrome cant assign fetched data in front end form */
var emp_joining_date = "";
var emp_dob = "";
var userId="";
var BD_DistrictList = ["Bagerhat","Bandarban","Barguna","Barisal","Bhola","Bogra","Brahmanbaria","Chandpur","Chittagong","Chuadanga","Comilla","Cox's Bazar","Dhaka","Dinajpur","Faridpur","Feni","Gaibandha","Gazipur","Gopalganj","Habiganj","Jaipurhat","Jamalpur","Jessore","Jhalakati","Jhenaidah","Khagrachari","Khulna","Kishoreganj","Kurigram","Kustia","Lakshmipur","Lalmonirhat","Madaripur","Magura","Manikganj","Meherpur","Moulvibazar","Munshiganj","Mymensingh","Naogaon","Narail","Narayanganj","Narsingdi","Natore","Nawabganj","Netrakona","Nilphamari","Noakhali","Pabna","Panchagarh","Chattagram","Patuakhali","Pirojpur","Rajbari","Rajshahi","Rangpur","Satkhira","Shariatpur","Sherpur","Sirajganj","Sunamganj","Sylhet","Tangail","Thakurgaon"];


function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function initValues(){	
	
	document.getElementById("eNothiNo").value = "";
	document.getElementById("EmployeeId").value = "";
	document.getElementById("EmployeeName").value = "";
	document.getElementById("DOB").value = "";
	document.getElementById("PRLDate").value = "";
	document.getElementById("Designation").value = "";
	document.getElementById("contactNo").value = "";
	document.getElementById("PrAddress").value = "";
	document.getElementById("Address").value = "";
	document.getElementById("email").value = "";
	document.getElementById("ReligionType").value = "";						
	document.getElementById("GenderType").value = "";
	document.getElementById("homeDist").value = "";
	document.getElementById("NID").value = "";							
	document.getElementById("ActivationType").value = "";
	document.getElementById("BankAccount").value = "";
	document.getElementById("BranchName").value = "";
	document.getElementById("bankName").value = "";	
	document.getElementById("BranchDistrict").value = "";
	
	document.getElementById("NothiNo").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}

/* function NothiValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
	clear();
	SetValue("NothiNo", document.getElementById("NothiNo").value);
	SetValue("Class", "PensionValidation");
	SetValue("Method", "FetchPensionEmployeeData");	
	xmlFinal();
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var obj = JSON.parse(this.responseText);
			if (obj.ERROR_MSG != "") {
				alert(obj.ERROR_MSG);
			} else {
				if (obj.EMP_NAME!=null) {
					var r = confirm("Employee already exists!\nDo you want to update?");
					  if (r == true) {		
						    document.getElementById("PensionType").value= obj.PENSIONER_TYPE;
						    document.getElementById("EmployeeName").value = obj.EMP_NAME;
							document.getElementById("eNothiNo").value = obj.ENOTHI_NUM;
							document.getElementById("EmployeeId").value = obj.EMP_ID;
							document.getElementById("DOB").value = obj.DOB;
							document.getElementById("Designation").value = obj.DESIGNATION_CODE;
							document.getElementById("PRLDate").value = obj.PRL_DATE;
							document.getElementById("contactNo").value = obj.CONTACT_NO;
							document.getElementById("PrAddress").value = obj.PRADDRESS;							
							document.getElementById("Address").value = obj.ADDRESS;
							document.getElementById("email").value = obj.EMAIL;
							document.getElementById("ReligionType").value = obj.RELIGION;							
							document.getElementById("GenderType").value = obj.GENDER;
							document.getElementById("homeDist").value = obj.HOME_DISTRICT;
							document.getElementById("NID").value = obj.NID;							
							document.getElementById("ActivationType").value = obj.ACTIVATION_TYPE;
							document.getElementById("BankAccount").value = obj.ACCOUNT_NUM;
							document.getElementById("BranchName").value = obj.BRANCH_NAME;
							document.getElementById("bankName").value = obj.BANK_NAME;		
							document.getElementById("BranchDistrict").value = obj.BRANCH_DISTRICT;
							document.getElementById("eNothiNo").focus();
							
					  } else {
						  initValues();							 
					  }	
				}
				else{
					initValues();	
					document.getElementById("eNothiNo").focus();		
				}
			}															
		}
	};
	
	xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
	xhttp.send();					

		}
} */


function NothiValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		clear();
		SetValue("NothiNo", document.getElementById("NothiNo").value,"N");
		SetValue("Class", "elixir.validator.pps.PensionValidation","N");
		SetValue("Method", "FetchPensionEmployeeData","L");	
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
						if (obj.EMP_NAME!=null) {
							var r = confirm("Employee already exists!\nDo you want to update?");
							  if (r == true) {		
								    document.getElementById("PensionType").value= obj.PENSIONER_TYPE;
								    document.getElementById("EmployeeName").value = obj.EMP_NAME;
									document.getElementById("eNothiNo").value = obj.ENOTHI_NUM;
									document.getElementById("EmployeeId").value = obj.EMP_ID;
									document.getElementById("DOB").value = obj.DOB;
									document.getElementById("Designation").value = obj.DESIGNATION_CODE;
									document.getElementById("PRLDate").value = obj.PRL_DATE;
									document.getElementById("contactNo").value = obj.CONTACT_NO;
									document.getElementById("PrAddress").value = obj.PRADDRESS;							
									document.getElementById("Address").value = obj.ADDRESS;
									document.getElementById("email").value = obj.EMAIL;
									document.getElementById("ReligionType").value = obj.RELIGION;							
									document.getElementById("GenderType").value = obj.GENDER;
									document.getElementById("homeDist").value = obj.HOME_DISTRICT;
									document.getElementById("NID").value = obj.NID;							
									document.getElementById("ActivationType").value = obj.ACTIVATION_TYPE;
									document.getElementById("BankAccount").value = obj.ACCOUNT_NUM;
									document.getElementById("BranchName").value = obj.BRANCH_NAME;
									document.getElementById("bankName").value = obj.BANK_NAME;		
									document.getElementById("BranchDistrict").value = obj.BRANCH_DISTRICT;
									document.getElementById("eNothiNo").focus();
									
							  } else {
								  initValues();							 
							  }	
						}
						else{
							initValues();	
							document.getElementById("eNothiNo").focus();		
						}
				  
					}
	
		});
	}
}

function eNothiValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			 document.getElementById("EmployeeId").focus();
	}
}

function EmployeeIdValidation(event) {
	if (event.keyCode == 13 || event.which == 13) {
		 document.getElementById("EmployeeName").focus();
	}
}

function EmployeeNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("PRLDate").focus();
	}
}
function PRLDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Designation").focus();
	}
}

function DesignationValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ReligionType").focus();
	}
}

function GenderValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BloodGrp").focus();
	}
}
function BloodGrpValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Rhfactor").focus();
	}
}
function RhfactorValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DOB").focus();
	}
}
function DOBValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('DOB');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("contactNo").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("DOB").focus();
	    }
	}
}

function ContactValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("homeDist").focus();
	}
}
function  HomeDistValidation(event){
	autocomplete(document.getElementById("homeDist"), BD_DistrictList);
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID").focus();
	}
}

function  NIDValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("email").focus();
	}
}
function EmailValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		var email = document.getElementById('email');
	    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	    if (!filter.test(email.value)) {
	    	alert('Please provide a valid email address');
	    }
	    else{
	    	document.getElementById("Address").focus();
	    }
	}
}
function AddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("bankName").focus();
	}
}
function BankNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BranchName").focus();
	}
}
function BranchNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BankAccount").focus();
	}
}
function BankAccountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

$(function() {
	$("#PRLDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

$(function() {
	$("#DOB").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

function BranchDistrictValidation(event) {
	autocomplete(document.getElementById("BranchDistrict"), BD_DistrictList);
}

function AddPensionEmployeeInfo(event)
{			
		clear();
		SetValue("User_Id","1123","N");
		SetValue("NothiNo",document.getElementById("NothiNo").value,"N");
		SetValue("eNothiNo",document.getElementById("eNothiNo").value,"N");		
		SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
		SetValue("PRLDate",document.getElementById("PRLDate").value,"N");
		SetValue("EmployeeName",document.getElementById("EmployeeName").value,"N");
		SetValue("Designation",document.getElementById("Designation").value,"N");
		SetValue("GenderType",document.getElementById("GenderType").value,"N");
		SetValue("DOB",document.getElementById("DOB").value,"N");
		SetValue("contactNo",document.getElementById("contactNo").value,"N");
		SetValue("email",document.getElementById("email").value,"N");		
		SetValue("homeDist",document.getElementById("homeDist").value,"N");
		SetValue("NID",document.getElementById("NID").value,"N");				
		SetValue("Address",document.getElementById("Address").value,"N");
		SetValue("ReligionType",document.getElementById("ReligionType").value,"N");		
		SetValue("ActivationType",document.getElementById("ActivationType").value,"N");
		SetValue("BankAccount",document.getElementById("BankAccount").value,"N");				
		SetValue("BranchName",document.getElementById("BranchName").value,"N");
		SetValue("bankName",document.getElementById("bankName").value,"N");	
		SetValue("PrAddress",document.getElementById("PrAddress").value,"N");	
		SetValue("BranchDistrict",document.getElementById("BranchDistrict").value,"N");	
		SetValue("PensionType",document.getElementById("PensionType").value,"N");	
		SetValue("Class","elixir.validator.pps.PensionValidation","N");
		SetValue("Method","AddPensionEmployee","L");
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
		<h3 style="color:white;">Pension Payment System</h3>
		<div class="container">
		   	
		      <fieldset>
		      <legend>Identifier</legend> 
		       <div class="row">
					<div class="col-15">
						<label for="NothiNo">Nothi No</label>
					</div>
					<div class="col-20">
						<input type="text" id="NothiNo" name="NothiNo" onkeypress="NothiValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="eNothiNo">E-Nothi No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="eNothiNo" name="eNothiNo" onkeypress="eNothiValidation(event)" >
					</div>										
				 </div>		      				
				</fieldset>		
				<fieldset>	
				<legend>Personal Details</legend>
					
				
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
					<div class="colr-20">
						<input type="text" id="EmployeeName" name="EmployeeName" onkeypress="EmployeeNameValidation(event)" >
					</div>										
				 </div>
				
				
				<div class="row">
					<div class="col-15">
						<label for="PRLDate">PRL Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="PRLDate" value="" onkeypress="PRLDateValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="Designation">Designation </label>
					</div>				
					<div class="colr-20">
						<select id="Designation" name="Designation"  onkeypress="DesignationValidation(event)" style="width: 405px;">							
							<option value="0">Chairman</option>
							<option value="1">MD</option>
							<option value="2">DMD</option>
							<option value="3">General Manager</option>
							<option value="4">Deputy General Manager</option>
							<option value="10">Assistant General Manager</option>
							<option value="11">Senior System Analyst</option>
							<option value="21">Senior Principal Officer</option>
							<option value="22">System Analyst</option>
							<option value="30">Principal Officer</option>
							<option value="31">Public Relation Officer</option>
							<option value="32">Executive Engineer</option>
							<option value="33">Programmer</option>
							<option value="40">Law Officer</option>
							<option value="41">Senior Officer</option>
							<option value="42">Assistant Engineer</option>
							<option value="43">Assistant Programmer</option>						
							<option value="50">Sub Assistant Engineer</option>																				
							<option value="51">Officer</option>
							<option value="52">Computer Operator</option>
							<option value="60">Supervisor</option>
							<option value="62">Data Entry Operator</option>	
							<option value="80">Driver</option>	
							<option value="81">Electrician</option>	
							<option value="82">Office Assistant</option>
							<option value="83">Carpentar</option>
							<option value="84">Lift Operator</option>									
							<option value="85">Plumber</option>	
							<option value="86">Helper</option>	
							<option value="87">Chowkider</option>	
							<option value="88">Sweeper</option>	
							<option value="89">Cleaner</option>	
							<option value="90">Mali</option>
							<option value="91">Photocopy M/O</option>		
							<option value="98">Typist</option>
						</select>
					</div>
				</div>
					
				<div class="row">	
							
					
					<div class="col-15">
						<label for="GenderType">Gender </label>
					</div>	
							
					<div class="col-20">
						<select id="GenderType" name="GenderType" onkeypress="GenderValidation(event)" style="width: 390px;" >
							<option value="M">M-Male</option>
							<option value="F">F-Female</option>
						</select>
					</div>	
					
					
					<div class="colr-15">
						<label for="ReligionType">Religion </label>
					</div>
					<div class="colr-20">
						<select id="ReligionType" name="ReligionType" style="width: 405px;">
							<option value="M">Muslim</option>
							<option value="H">Hindu</option>		
							<option value="O">Other</option>							
						</select>
					</div>
			
				</div>
				
								
				<div class="row">
					<div class="col-15">
						<label for="DOB">Date of Birth</label>
					</div>
					<div class="col-20">
						<input  type="text" id="DOB" value="" onkeypress="DOBValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="contactNo"> Contact No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="contactNo" name="contactNo" onkeypress="ContactValidation(event)"  >
					</div>	
				</div>	

				<div class="row">
					<div class="col-15">
						<label for="homeDist"> Home District</label>
					</div>
					<div class="col-20">
						<input type="text" id="homeDist" name="homeDist" onkeypress="HomeDistValidation(event)">
					</div>	
				
					<div class="colr-15">
						<label for="NID">NID No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="NID" value="" onkeypress="NIDValidation(event)" >
					</div>										
				</div>	
							
			
				
				<div class="row">
					<div class="col-15">
						<label for="PrAddress">Present Address</label>
					</div>
					<div class="col-20">
						   <input type="text" id="PrAddress" name="PrAddress" onkeypress="PreAddressValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="Address"> Permanent Address</label>
					</div>
					<div class="colr-20">
					<input type="text" id="Address" value="" onkeypress="AddressValidation(event)" >
					</div>	
				</div>	
				
				<div class="row">
					<div class="col-15">
						<label for="email">Email</label>
					</div>
					<div class="col-20">
						   <input type="text" id="email" name="email" onkeypress="EmailValidation(event)">
					</div>	
					
					<div class="colr-15">
						<label for="PensionType">Pension Type </label>
					</div>
					<div class="colr-20">
						<select id="PensionType" name="PensionType" style="width: 405px;">
							<option value="M">M-Monthly Pensioner</option>
							<option value="S">S-100% Surrender </option>		
							<option value="R">R-Replaced Pensioner</option>							
						</select>
					</div>
														
				</div>	
				
				
				</fieldset>	
					
				<fieldset>
				  <legend>Bank Details:</legend> 
				<div class="row">				
					<div class="col-15">
						<label for="bankName"> Bank Name </label>
					</div>				
					<div class="col-20">
						<input type="text" id="bankName" name="bankName" onkeypress="BankNameValidation(event)"  >
					
				   </div>
				
					<div class="colr-15">
						<label for="BranchName"> Branch Name </label>
					</div>				
					<div class="colr-20">
						<input type="text" id="BranchName" name="BranchName" onkeypress="BranchNameValidation(event)"  >					
				   </div>					
				</div>	
				
				 <div class="row">				
					<div class="col-15">
						<label for="BankAccount"> Bank Account </label>
					</div>				
					<div class="col-20">
						<input type="text" id="BankAccount" name="BankAccount" onkeypress="BankAccountValidation(event)"  >
					
				   </div>
				   
					   <div class="colr-15">
							<label for="ActivationType">Activation Type</label>
					</div>
						<div class="colr-20">
							<select id="ActivationType" name="ActivationType"  maxlength="45" onkeypress="ActivationTypeValidator(event)" style="width: 405px;">
								<option value="Y">Y-Pension Active</option>
								<option value="N">N-Pension In Active</option>												
							</select>
					</div>					   								   
				  </div>
				  
				  <div class="row">				
					<div class="col-15">
						<label for="BranchDistrict"> Branch District </label>
					</div>				
					<div class="col-20">
						<input type="text" id="BranchDistrict" name="BranchDistrict" onkeypress="BranchDistrictValidation(event)"  >					
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
						<input type="submit" id="submit" value="Submit" onclick="AddPensionEmployeeInfo(event)" >
					</div>
					
				</div>
				
			 </div>
			</div>
	</center>
</body>
</html>