<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
	width: 15%;
	text-align: left;
}
.colr-15 {
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
	function SetValue(key,value){
		var Node = "<cell> <key>"+key+"</key> <value>"+value+"</value> </cell>";
		DataMap=DataMap+Node;
	}
	function clear(){
		DataMap="";
	}
	function xmlFinal(){
		DataMap="data=<root>"+DataMap+"</root>";
	}

	function initValues() {
		document.getElementById("EmployeeId").value="";
		document.getElementById("EmployeeName").value="";
		document.getElementById("CurrentBranch").value="";
		document.getElementById("EmployeeDesig").value="";
		document.getElementById("CurrentBasicPay").value="";
		document.getElementById("OrganizationName").value="";
		document.getElementById("NewBasicPay").value="";
		document.getElementById("NewDesignation").value="";
		document.getElementById("EffectiveDate").value="";
		document.getElementById("EmployeeId").focus();
	}
	
	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			clear();
			SetValue("EmployeeId",document.getElementById("EmployeeId").value);
			SetValue("Class","PRMSValidator");
			SetValue("Method","EmployeeIdValidation");
			xmlFinal();
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							document.getElementById("EmployeeName").value=obj.NAME;
							document.getElementById("CurrentBranch").value=obj.BRANCH_CODE;
							document.getElementById("EmployeeDesig").value=obj.DESIGNATION;
							document.getElementById("CurrentBasicPay").value=obj.BASIC_SAL;							
							document.getElementById("branchCheck").focus();
						}									
				}
			};
			xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
			xhttp.send();			
		}
	}
	
	function branchCodeValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
				if (document.getElementById("TrainingLocation").value == "S" && (document.getElementById("OrganizationName").value=="" ||document.getElementById("OrganizationName").value==null)) {
					alert("Attached Branch Code should not be null!");
					document.getElementById("OrganizationName").focus();
				} else {
					
					clear();
					SetValue("branch_code",document.getElementById("OrganizationName").value);
					SetValue("Class","PRMSValidator");
					SetValue("Method","BranchKeyPress");
					xmlFinal();
					var xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							var obj = JSON.parse(this.responseText);
							if (obj.ERROR_MSG != "") {
								alert(obj.ERROR_MSG);
							} else {
								document.getElementById("BranchName").innerHTML=obj.BRN_NAME;
								document.getElementById("EffectiveDate").focus();
							}
						}
					};
					xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
					xhttp.send();

				}
		}
	}
	

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
	

	
	
	function EffectiveDateValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			var txtTest = document.getElementById('EffectiveDate');
		    var isValid = IsValidDate(txtTest.value);
		    if (isValid) {
		    	document.getElementById("submit").focus();
		    }
		    else {
		        alert('Incorrect format');
		        document.getElementById("EffectiveDate").focus();
		    }						
		}
	}
	function PfActivationIMethod(event) {
		 var c = confirm("Are you sure ?");
		  if (c == true) {
				if(document.getElementById("OrganizationName").value=="")document.getElementById("OrganizationName").value = "NA";
				clear();
				SetValue("EmployeeId",document.getElementById("EmployeeId").value);
				SetValue("TrainingLocation",document.getElementById("TrainingLocation").value);
				SetValue("AttachedBranch",document.getElementById("OrganizationName").value);
				SetValue("effective_date",document.getElementById("EffectiveDate").value);
				SetValue("Class","AdminOperation");
				SetValue("Method","PfActivationIMethod");
				xmlFinal();
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

				xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
				xhttp.send();
		  }
		  else{
			  	document.getElementById("submit").focus();
		}
		
	}
	
	$(function() {
		$("#EffectiveDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	$(function() {
		$("#StartDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	$(function() {
		$("#EndDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	
	
	
	
</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3 style="color:white;">Human Resource Management System</h3>
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
					<div class="colr-20">
						<input type="text" id="EmployeeName" name="EmployeeName" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-15">
						<label for="CurrentBranch">Current Branch</label>
					</div>
					<div class="col-20">
						<input type="text" id="CurrentBranch" name="CurrentBranch" readonly>
					</div>
					<div class="colr-15">
						<label for="EmployeeDesig">Employee Designation</label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeDesig" name="EmployeeDesig" readonly>
					</div>
				</div>	
				
				<div class="row">
					<div class="col-15">
						<label for="EntrySerial">Entry Serial</label>
					</div>
					<div class="col-20">
						<input type="text" id="EntrySerial" name="EntrySerial" onkeypress="EntrySerialValidation(event)">
					</div>					
				</div>
				
				
							
				</fieldset>
								<br>								
			<fieldset>	
			<legend>Training Details</legend>
						
				<div class="row">
					<div class="col-15">
						<label for="TrainingLocation">Training Location</label>
					</div>
					<div class="col-20">
						<select id="TrainingLocation" name="TrainingLocation"   onkeypress="ActivationTypeValidator(event)" style="width: 350px;">
							 
							<option value="D">D-Domestic</option>	
							<option value="A">A-Abroad</option>
																				
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-15">
						  
						 <label for="OrganizationName">Organization Name</label>
					</div>
					<div class="col-75">		
						<input id="OrganizationName" type="text" name="OrganizationName"  onkeypress="NoOfDaysValidation(event)" >
				    </div>
				    
				</div>
				
				<div class="row">
					<div class="col-15">
						  
						 <label for="TrainingSubject">Training Subject</label>
					</div>
					<div class="col-75">		
						<input id="TrainingSubject" type="text" name="TrainingSubject"  onkeypress="TrainingSubjectValidation(event)" >
				    </div>
				    
				</div>
				<br>
				
				<div class="row">
					<div class="col-15">
						<label for="StartDate"> Training Start Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="StartDate" value="" onkeypress="StartDateValidation(event)"  maxlength="45" >
					</div>
					
					
					<div class="colr-15">
						<label for="EndDate">Training End Date</label>
					</div>
					<div class="colr-20">
						<input  type="text" id="EndDate" value="" onkeypress="EndDateValidation(event)"  maxlength="45" >
					</div>
				</div>
				
				
				
				
				<div class="row">
					<div class="col-15">
						<label for="officeOrder">Office Order No</label>
					</div>
					<div class="col-20">
						<input  type="text" id="officeOrder" value="" onkeypress="officeOrderValidation(event)"  maxlength="45" >
					</div>
					
					
					<div class="colr-15">
						<label for="officeOrderDate">Office Order Date</label>
					</div>
					<div class="colr-20">
						<input  type="text" id="officeOrderDate" value="" onkeypress="officeOrderDateValidation(event)"  maxlength="45" >
					</div>
				</div>
				
				
				<div class="row">
					<div class="col-15">
						  
						 <label for="TrainingRemarks">Remarks</label>
					</div>
					<div class="col-75">		
						<input id="TrainingRemarks" type="text" name="TrainingRemarks"  onkeypress="TrainingRemarksValidation(event)" >
				    </div>
				    
				</div>
				
							
			</fieldset>
			
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="PfActivationIMethod(event)" >
				</div>
		</div>
	</center>
</body>
</html>
