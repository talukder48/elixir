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
	width: 15%;
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
	width: 35%;
	
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

	function initValues() {
		document.getElementById("EmployeeId").value="";
		document.getElementById("EmployeeName").value="";
		document.getElementById("CurrentBranch").value="";
		document.getElementById("EmployeeDesig").value="";
		document.getElementById("CurrentBasicPay").value="";
		document.getElementById("NewBasicPay").value="";
		document.getElementById("EffectiveDate").value="";
		document.getElementById("EmployeeId").focus();
	}
	
	function EmployeeBranchChecking() {
		
		return 0;
	}
	
	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
			if(EmployeeBranchChecking()==1){
				clear();
				SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
				SetValue("Class","elixir.validator.pps.PRMSValidator","N");
				SetValue("Method","EmployeeIdValidation","L");
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
								document.getElementById("EmployeeName").value=obj.NAME;
								document.getElementById("CurrentBranch").value=obj.BRANCH_CODE;
								document.getElementById("EmployeeDesig").value=obj.DESIGNATION;
								document.getElementById("CurrentBasicPay").value=obj.BASIC_SAL;							
								document.getElementById("basicCheck").focus();
							}		
				});
				
			}else{
				alert("Employee is not belong to this branch!!");
				document.getElementById("EmployeeId").focus();
			}
	
		}
	}


	function BasicUpdationCheck(event) {
		var checkBox = document.getElementById("basicCheck");
		if (checkBox.checked == true) {
			document.getElementById("NewBasicPay").focus();
		}
		if (event.keyCode == 13 || event.which == 13) {
			if (checkBox.checked == true) {
				document.getElementById("NewBasicPay").focus();
			} else
				document.getElementById("basicCheck").focus();
		}
	}

function NewBasicValidation(event) {
	if (event.keyCode == 13 || event.which == 13) {
		var checkBox = document.getElementById("basicCheck");
		if (checkBox.checked == true) {
			if (document.getElementById("NewBasicPay").value == "") {
				alert("amount should not be null!");
				document.getElementById("NewBasicPay").focus();
			} else {
				if (isNaN(document.getElementById("NewBasicPay").value)) {
					alert("please enter valid amount!");
				} else {
					if (parseFloat(document.getElementById("NewBasicPay").value) != parseFloat(document.getElementById("CurrentBasicPay").value)) {
						alert("new basic should not less then or equal: "+ parseFloat(document.getElementById("CurrentBasicPay").value)+ " !");
					} else {
						document.getElementById("EffectiveDate").focus();
					}
				}
			}
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
	function UpdateEmployeeInfo(event) {

		 var c = confirm("Are you sure ?");
		  if (c == true) {
			  			  
			  if (event.keyCode == 13 || event.which == 13) {
					var txtTest = document.getElementById('EffectiveDate');
				    var isValid = IsValidDate(txtTest.value);
				    if (isValid) {				    	
						var User_Id="<%= session.getAttribute("User_Id")%>";
						
						
						clear();
						SetValue("User_Id",User_Id,"N");
						SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
						SetValue("new_designation","NA","N");
						SetValue("new_basic",document.getElementById("NewBasicPay").value,"N");
						SetValue("new_branch","NA","N");				
						SetValue("effective_date",document.getElementById("EffectiveDate").value,"N");
						SetValue("Class","elixir.validator.pps.AdminOperation","N");
						SetValue("Method","EmployeeInfoUpdation","L");
						
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
				  else{
					  	document.getElementById("submit").focus();
				}				    	
				    
			    }
			    else {
			        alert('Incorrect format');
			        document.getElementById("EffectiveDate").focus();
			    }						
			}

	}
	
	$(function() {
		$("#EffectiveDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	
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
						<label for="CurrentBasicPay">Current Basic Pay</label>
					</div>
					<div class="col-20">
						<input type="text" id="CurrentBasicPay" name="CurrentBasicPay" readonly>
					</div>
				</div>
				</fieldset>
				<fieldset>
				
				<div class="row">
					<div class="col-25">
						Is Annual Pay update? <input type="checkbox" id="basicCheck"
							onclick="BasicUpdationCheck(event)" onkeypress="BasicUpdationCheck(event)">
					</div>
					<div class="col-75">
						<input id="NewBasicPay" type="text" name="NewBasicPay" maxlength="45" onkeypress="NewBasicValidation(event)"	placeholder="New Basic Pay">
					</div>
				</div>
				</fieldset>
				
				<fieldset>
				<div class="row">
					<div class="col-25">
						<label for="EffectiveDate">Increment Date</label>
					</div>
					<div class="col-75">
						<input  type="text" id="EffectiveDate" value="" onkeypress="EffectiveDateValidation(event)"  maxlength="45" >
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
						<input type="submit" id="submit" value="Submit"  onclick="UpdateEmployeeInfo(event)" >
					</div>
					
				</div>
								
		</div>
	</center>
</body>
</html>
