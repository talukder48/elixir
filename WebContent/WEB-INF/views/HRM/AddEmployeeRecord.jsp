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
    text-align: left;
	float: left;
	width: 15%;
}
.colx-15 {
	float: left;
	width: 10%;
}
.colr-15 {
    text-align: left;
	float: left;
	width: 15%;
	margin-left: 50px;
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
var emp_joining_date = "";
var emp_dob = "";
var userId="";


function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function initValues(){
	document.getElementById("EmployeeId").value="";
	document.getElementById("EmployeeName").value="";
	document.getElementById("JoiningDate").value="";
	document.getElementById("BranchCode").value="";
	document.getElementById("DOB").value="";
	document.getElementById("contactNo").value="";
	document.getElementById("TIN").value="";
	document.getElementById("SeniorityCode").value="";
	document.getElementById("Address").value="";
	document.getElementById("email").value="";
	document.getElementById("ReligionType").value="";
	document.getElementById("HighestDegree").value="";
	document.getElementById("homeDist").value="";
	document.getElementById("NID").value="";	
	document.getElementById("EmployeeId").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}

function EmployeeIdValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		
		var usr_brn = "<%= session.getAttribute("BranchCode")%>";
		clear();
		SetValue("UserBranchCode",usr_brn);
		SetValue("EmployeeId",document.getElementById("EmployeeId").value);
		SetValue("Class","AdminOperation");
		SetValue("Method","FetchEmpData");
		
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
							    document.getElementById("EmployeeName").value=obj.EMP_NAME;
								document.getElementById("JoiningDate").value=obj.JOINING_DATE;
								document.getElementById("Designation").value=obj.DESIG_CODE;
								document.getElementById("BranchCode").value=obj.EMP_BRN_CODE;
								document.getElementById("DOB").value=obj.DOB;
								document.getElementById("contactNo").value=obj.CONTACT_NO;
								document.getElementById("TIN").value=obj.TIN_NO;
								document.getElementById("SeniorityCode").value=obj.DESIG_SENIORITY_CODE;
								document.getElementById("Address").value=obj.ADDRESS;
								document.getElementById("email").value=obj.EMAIL;
								document.getElementById("ReligionType").value=obj.RELIGION;				
								document.getElementById("GenderType").value=obj.GENDER;
								document.getElementById("Rhfactor").value=obj.RHFACTOR;
								document.getElementById("BloodGrp").value=obj.BLOOD_GRP;
								document.getElementById("homeDist").value=obj.HOME_DISTRICT;
								document.getElementById("NID").value=obj.NID;
								document.getElementById("DeptCode").value=obj.EMP_DEPT_CODE;
								document.getElementById("HighestDegree").value=obj.HIGHEST_DEGREE;
								document.getElementById("EmployeeName").focus();
								
						  } else {
							  initValues();							 
						  }	
					}
					else{
						initValues();	
						document.getElementById("EmployeeName").focus();		
					}
				}															
			}
		};
		
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();					
	}
}

function EmployeeNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BranchCode").focus();
	}
}
function BranchCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
	if (document.getElementById("BranchCode").value != "") {
		clear();
		SetValue("branch_code",document.getElementById("BranchCode").value);
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
						document.getElementById("Designation").focus();
					}					
				}
			}
		};
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();
	}
	else{
		alert("Branch Code Should not be null!");
		document.getElementById("Designation").focus();
	}
 }
}

function DesignationValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("JoiningDate").focus();
	}
}
function JoiningDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('JoiningDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("DeptCode").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("JoiningDate").focus();
	    }
	}
}

function DeptCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("GenderType").focus();
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
		document.getElementById("TIN").focus();
	}
}
function TINValidation(event){
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
	    	document.getElementById("homeDist").focus();
	    }
	}
}

function  HomeDistValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID").focus();
	}
}
function  NIDValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SeniorityCode").focus();
	}
}

function SeniorityCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Address").focus();
	}
}
function AddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("HighestDegree").focus();
	}
}
function HighestDegreeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

$(function() {
	$("#JoiningDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

$(function() {
	$("#DOB").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

function AddEmployeeInfo(event)
{			
		clear();
		SetValue("EntdBy",userId);
		SetValue("EmployeeId",document.getElementById("EmployeeId").value);
		SetValue("EmployeeName",document.getElementById("EmployeeName").value);
		SetValue("BranchCode",document.getElementById("BranchCode").value);
		SetValue("Designation",document.getElementById("Designation").value);
		SetValue("JoiningDate",document.getElementById("JoiningDate").value);	
		SetValue("DeptCode",document.getElementById("DeptCode").value);
		SetValue("GenderType",document.getElementById("GenderType").value);
		SetValue("BloodGrp",document.getElementById("BloodGrp").value);
		SetValue("Rhfactor",document.getElementById("Rhfactor").value);
		SetValue("DOB",document.getElementById("DOB").value);
		SetValue("contactNo",document.getElementById("contactNo").value);
		SetValue("TIN",document.getElementById("TIN").value);
		SetValue("email",document.getElementById("email").value);		
		SetValue("homeDist",document.getElementById("homeDist").value);
		SetValue("NID",document.getElementById("NID").value);				
		SetValue("SeniorityCode",document.getElementById("SeniorityCode").value);
		SetValue("Address",document.getElementById("Address").value);
		SetValue("ReligionType",document.getElementById("ReligionType").value);
		SetValue("HighestDegree",document.getElementById("HighestDegree").value);
		
		SetValue("Class","AdminOperation");
		SetValue("Method","AddNewEmployee");
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

</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3 style="color:white;">Human Resource Management System</h3>
		
		<div class="container">
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
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="BranchCode" value="" onkeypress="BranchCodeValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="Designation">Designation </label>
					</div>				
					<div class="colr-20">
						<select id="Designation" name="Designation"  onkeypress="DesignationValidation(event)" style="width: 288px;">							
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
						</select>
					</div>
				</div>
				
				<div class="row">

					<div class="col-15">
						<label for="JoiningDate">Joining Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="JoiningDate" value="" onkeypress="JoiningDateValidation(event)" >
					</div>
					<div class="colr-15">
						<label for="DeptCode"> Dept. Code</label>
					</div>
					<div class="colr-20">
						<select id="DeptCode" name="DeptCode" onkeypress="DeptCodeValidation(event)" style="width: 288px;">
						    <option value="0"> Not Applicable </option>
							<option value="1">	BOARD OF DIRECTORS</option>
							<option value="2">	MD's SECRETARIAT</option>
							<option value="3">	DMD's OFFICE</option>
							<option value="4">	GM (Loan, PHRD & East)</option>
							<option value="5">	GM (Admin, ICT & Accounts)</option>
							<option value="6">	GM (Audit & West)</option>
							<option value="7">	GM(Law, Training, Saleable & CS)</option>
							<option value="8">	GM (Recovery, Engineering & Marketing)</option>
							<option value="26">	GM(Loan & West)</option>
							<option value="10">	BOARD SECRETARIAT</option>
							<option value="11">	ADMINISTRATION</option>
							<option value="12">	Training</option>
							<option value="13">	Marketing & Development(PRU)</option>
							<option value="14">	RECOVERY</option>
							<option value="15">	LAW</option>
							<option value="16">	Common Services</option>
							<option value="17">	Saleable & Management</option>
							<option value="18">	ICT Operation</option>
							<option value="19">	ICT System</option>
							<option value="20">	ACCOUNTS AND FINANCE</option>
							<option value="21">	LOAN</option>
							<option value="22">	Engineering</option>
							<option value="23">	AUDIT</option>
							<option value="24">	P.H.R.D.</option>
							<option value="25">	R.P.U.H.F.P.</option>
						</select>
					</div>	
				</div>

				<div class="row">	
					<div class="col-15">
						<label for="GenderType">Gender </label>
					</div>				
					<div class="col-20">
						<select id="GenderType" name="GenderType" onkeypress="GenderValidation(event)" style="width: 288px;" >
							<option value="M">M-Male</option>
							<option value="F">F-Female</option>
						</select>
					</div>	
				
					<div class="colr-15">
						<label for="BloodGrp">Blood Group</label>
					</div>
								
					<div class="colx-15">
						<select id="BloodGrp" name="BloodGrp" onkeypress="BloodGrpValidation(event)" style="width: 145px;">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="AB">AB</option>
							<option value="O">O</option>
						</select>
					</div>				
					<div class="colx-15">
						<select id="Rhfactor" name="Rhfactor" onkeypress="RhfactorValidation(event)" style="width: 156px;">
							<option value="positive">Positive</option>
							<option value="negative">Negative</option>							
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
						<label for="TIN">TIN No.</label>
					</div>
					<div class="col-20">
						<input type="text" id="TIN" value="" onkeypress="TINValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="email"> Email</label>
					</div>
					<div class="colr-20">
						<input type="text" id="email" name="email" onkeypress="EmailValidation(event)">
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
						<label for="SeniorityCode">Seniority  Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="SeniorityCode" value="" onkeypress="SeniorityCodeValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="Address"> Address</label>
					</div>
					<div class="colr-20">
					<input type="text" id="Address" value="" onkeypress="AddressValidation(event)" >
					</div>	
				</div>	
				
				<div class="row">
					<div class="col-15">
						<label for="ReligionType">Religion </label>
					</div>
					<div class="col-20">
						<select id="ReligionType" name="ReligionType" style="width: 288px;">
							<option value="M">Muslim</option>
							<option value="H">Hindu</option>		
							<option value="O">Other</option>							
						</select>
					</div>
					
					<div class="colr-15">
						<label for="HighestDegree">Highest Degree </label>
					</div>
					<div class="colr-20">
						<input type ="text" id="HighestDegree" name="HighestDegree" placeholder="e.g: BSc. in CSE or BSc(Hon)..." onkeypress="HighestDegreeValidation(event)" >												
					</div>																
				</div>					
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="AddEmployeeInfo(event)" >
				</div>
		</div>
	</center>
</body>
</html>