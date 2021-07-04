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

	function initValues() {
		document.getElementById("EmployeeId").value="";
		document.getElementById("EmployeeName").value="";	
		document.getElementById("NoOfDay").value="";
		document.getElementById("TotalDays").value="";
		document.getElementById("EmployeeId").focus();
	}
	
	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			clear();
			SetValue("EmployeeId",document.getElementById("EmployeeId").value);
			SetValue("Class","PRMSValidator");
			SetValue("Method","EmployeeIdValidation");
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							document.getElementById("EmployeeName").value=obj.NAME;													
							document.getElementById("SalaryType").focus();
						}									
				}
			};
			xhttp.open("POST", "HTTPValidator?" + DataMap, true);
			xhttp.send();			
		}
	}
	
	function NoOfDaylidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("TotalDays").focus();
		}
	}
	
	function TotalDayslidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("submit").focus();
		}
	}
		
function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
	
	function FractionSalaryMathod(event) {
		var User_Id= "<%=session.getAttribute("User_Id")%>";
		 var c = confirm("Are you sure ?");
		  if (c == true) {
				clear();
				SetValue("EmployeeId",document.getElementById("EmployeeId").value);
				SetValue("SalaryType",document.getElementById("SalaryType").value);
				SetValue("NoOfDay",document.getElementById("NoOfDay").value);
				SetValue("TotalDays",document.getElementById("TotalDays").value);
				SetValue("User_Id",User_Id);
				SetValue("Class","SuperOperation");
				SetValue("Method","FractionSalaryMathod");
				
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
		  else{
			  	document.getElementById("submit").focus();
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
	<h3>[Fraction Salary Calculation]</h3>
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
				</fieldset>
				
				
				<fieldset>
				
				
				<div class="row">
					<div class="col-25">
						<label for="SalaryType">Salary Type</label>
					</div>
					<div class="col-25">
						<select id="SalaryType" name="SalaryType" maxlength="45" onkeypress="ActivationTypeValidator(event)">
							<option value="F">F-Fraction</option>
							<option value="C">C-Cancel</option>												
						</select>
					</div>
				</div>
												
				<div class="row">
					<div class="col-25">
						<label for="NoOfDay">No of Days</label>
					</div>
					
						<div class="col-15">		
						<input id="NoOfDay" type="text" name="NoOfDay" maxlength="20" onkeypress="NoOfDaylidation(event)" >
				  
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="TotalDays">Total Days of The Month</label>
					</div>
					
						<div class="col-15">		
						<input id="TotalDays" type="text" name="TotalDays" maxlength="20" onkeypress="TotalDayslidation(event)" >
				   
					</div>
				</div>
											
				</fieldset>
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="FractionSalaryMathod(event)" >
				</div>
		</div>
	</center>
</body>
</html>
