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
.datepicker {
	width: 10.5em;
	height: 2.5em;
}

body {
  background-color: #006666; 
  /* background-image: url('../../Media/bg6.jpg') ;
  background-repeat: repeat;
  background-size: /* 300px 100px   auto ; */
}

{
box-sizing:border-box;
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

.col-35 {
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
		document.getElementById("EmployeeId").value = "";
		document.getElementById("EmployeeName").value = "";
		document.getElementById("carFare").value = "";
		document.getElementById("carUse").value = "";
		document.getElementById("gasBill").value = "";
		document.getElementById("waterBill").value = "";
		document.getElementById("electricBill").value = "";
		document.getElementById("newspaper").value = "";
		document.getElementById("computer").value = "";
		document.getElementById("motorcycle").value = "";
		document.getElementById("telephoneExcess").value = "";
		document.getElementById("hbAdvPct").value = "";
		document.getElementById("others").value = "";
		document.getElementById("remarksOthers").value = "";
		document.getElementById("hbAdvManual").value = "";
		document.getElementById("pfAdvance").value = "";
		document.getElementById("EmployeeId").focus();
	}

	function EmployeeIdValidation(event) {
		if(document.getElementById("EmployeeId").value==""){
			initValues();
		}
		if (event.keyCode == 13 || event.which == 13) {
			var usr_brn = "<%= session.getAttribute("BranchCode")%>";
			clear();
			SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
			SetValue("UserBranchCode",usr_brn,"N");
			SetValue("Class","elixir.validator.pps.FinanceOperation","N");
			SetValue("Method","FetchDeductionData","L");
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
							document.getElementById("EmployeeName").value = obj.EMP_NAME;
							document.getElementById("carFare").value = obj.CAR_FARE;
							document.getElementById("carUse").value = obj.CAR_USE;
							document.getElementById("gasBill").value = obj.GAS_BILL;
							document.getElementById("waterBill").value = obj.WATER_BILL;
							document.getElementById("electricBill").value = obj.ELECT_BILL;
							document.getElementById("newspaper").value = obj.NEWS_PAPER;
							document.getElementById("computer").value = obj.COMP_DEDUC;
							document.getElementById("motorcycle").value = obj.MCYCLE_DEDUC;
							document.getElementById("telephoneExcess").value = obj.TEL_EXCESS_BILL;
							document.getElementById("hbAdvPct").value = obj.HBADV_DEDUC_PERCENT;
							document.getElementById("hbAdvManual").value = obj.HB_ADV_DEDUC;
							document.getElementById("pfAdvance").value = obj.PFADV_DEDUC;
							document.getElementById("others").value = obj.OTHER_DEDUC;
							document.getElementById("arearHR").value= obj.HR_AREAR_DED;
							if (obj.OTHER_DEDUC > 0) {
								document.getElementById("remarksOthers").value = obj.REMARKS;
							}
							document.getElementById("carFare").focus();
						}
			});						
		}
	}
	
	

	function CarFareValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("carUse").focus();
		}
	}
	function CarUseValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("gasBill").focus();
		}
	}
	function GasBillValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("waterBill").focus();
		}
	}
	function WaterBillValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("electricBill").focus();
		}
	}
	function ElectricValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("newspaper").focus();
		}
	}
	function NewspaperValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("computer").focus();
		}
	}
	function ComputerValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("motorcycle").focus();
		}
	}
	function MotorcycleValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("telephoneExcess").focus();
		}
	}
	function TelephoneValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("hbAdvPct").focus();
		}
	}

	function HbdAdvPctValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("pfAdvance").focus();
		}
	}
	
	function PfAdvanceValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("hbAdvManual").focus();
		}
	}
	function HbdAdvManualValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("others").focus();
		}
	}	
	
	function OthersValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("remarksOthers").focus();
		}
	}
	function RemarksValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("submit").focus();
		}
	}
	function UpdateEmployeeDeduction(event) {

		
		if (document.getElementById("remarksOthers").value == "")
			document.getElementById("remarksOthers").value = "NA";
		
		clear();
		var User_Id="<%= session.getAttribute("User_Id")%>";
		SetValue("User_Id",User_Id,"N");
		SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
		SetValue("hbAdvPct",document.getElementById("hbAdvPct").value);
		SetValue("telephoneExcess",document.getElementById("telephoneExcess").value,"N");
		SetValue("computer",document.getElementById("computer").value,"N");
		SetValue("motorcycle",document.getElementById("motorcycle").value,"N");		
		SetValue("newspaper",document.getElementById("newspaper").value);
		SetValue("electricBill",document.getElementById("electricBill").value,"N");
		SetValue("waterBill",document.getElementById("waterBill").value,"N");		
		SetValue("gasBill",document.getElementById("gasBill").value,"N");
		SetValue("carUse",document.getElementById("carUse").value,"N");
		SetValue("carFare",document.getElementById("carFare").value,"N");
		SetValue("others",document.getElementById("others").value,"N");
		SetValue("hbAdvManual",document.getElementById("hbAdvManual").value,"N");
		SetValue("pfAdvance",document.getElementById("pfAdvance").value,"N");		
		SetValue("remarksOthers",document.getElementById("remarksOthers").value,"N");		
		SetValue("arearHR",document.getElementById("arearHR").value,"N");
		SetValue("Class","elixir.validator.pps.FinanceOperation","N");
		SetValue("Method","UpdateDeduction","L");
		
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
					<input type="text" id="EmployeeId" name="EmployeeId"
						onkeypress="EmployeeIdValidation(event)">
				</div>

				<div class="colr-15">
					<label for="EmployeeName">Employee Name</label>
				</div>
				<div class="coln-20">
					<input type="text" id="EmployeeName" name="EmployeeName" readonly>
				</div>
			</div>
		</fieldset>	
		<fieldset>
			<div class="row">
				<div class="col-15">
					<label for="carFare">Car Fare </label>
				</div>
				<div class="col-20">
					<input type="text" id="carFare" name="carFare"
						onkeypress="CarFareValidation(event)">
				</div>

				<div class="colr-15">
					<label for="carUse">Car Use</label>
				</div>
				<div class="colr-20">
					<input type="text" id="carUse" name="carUse"
						onkeypress="CarUseValidation(event)">
				</div>
			</div>

			<div class="row">
				<div class="col-15">
					<label for="gasBill">Gas Bill </label>
				</div>
				<div class="col-20">
					<input type="text" id="gasBill" name="gasBill"
						onkeypress="GasBillValidation(event)">
				</div>

				<div class="colr-15">
					<label for="waterBill">Water Bill</label>
				</div>
				<div class="colr-20">
					<input type="text" id="waterBill" name="waterBill"
						onkeypress="WaterBillValidation(event)">
				</div>
			</div>

			<div class="row">
				<div class="col-15">
					<label for="electricBill">Electricity</label>
				</div>
				<div class="col-20">
					<input type="text" id="electricBill" name="electricBill"
						onkeypress="ElectricValidation(event)">
				</div>

				<div class="colr-15">
					<label for="newspaper">Newspaper</label>
				</div>
				<div class="colr-20">
					<input type="text" id="newspaper" name="newspaper"
						onkeypress="NewspaperValidation(event)">
				</div>
			</div>

			<div class="row">
				<div class="col-15">
					<label for="computer ">Computer </label>
				</div>
				<div class="col-20">
					<input type="text" id="computer" name="computer"
						onkeypress="ComputerValidation(event)">
				</div>

				<div class="colr-15">
					<label for="motorcycle">Motorcycle</label>
				</div>
				<div class="colr-20">
					<input type="text" id="motorcycle" name="motorcycle"
						onkeypress="MotorcycleValidation(event)">
				</div>
			</div>


			<div class="row">
				<div class="col-15">
					<label for="telephoneExcess">Tel. Ex. </label>
				</div>
				<div class="col-20">
					<input type="text" id="telephoneExcess" name="telephoneExcess"
						onkeypress="TelephoneValidation(event)">
				</div>

				<div class="colr-15">
					<label for="hbAdvPct">HB Adv.(%)</label>
				</div>
				<div class="colr-20">
					<input type="text" id="hbAdvPct" name="hbAdvPct"
						onkeypress="HbdAdvPctValidation(event)">
				</div>
			</div>
			
			
			<div class="row">
				<div class="col-15">
					<label for="pfAdvance">PF Adv </label>
				</div>
				<div class="col-20">
					<input type="text" id="pfAdvance" name="pfAdvance"
						onkeypress="PfAdvanceValidation(event)">
				</div>

				<div class="colr-15">
					<label for="hbAdvManual">HB Adv</label>
				</div>
				<div class="colr-20">
					<input type="text" id="hbAdvManual" name="hbAdvManual"
						onkeypress="HbdAdvManualValidation(event)">
				</div>
			</div>
			

			<div class="row">
				<div class="col-15">
					<label for="others">Others </label>
				</div>
				<div class="col-20">
					<input type="text" id="others" name="others"
						onkeypress="OthersValidation(event)">
				</div>

				<div class="colr-15">
					<label for="remarksOthers">Remarks</label>
				</div>
				<div class="colr-20">
					<input type="text" id="remarksOthers" name="remarksOthers"
						onkeypress="RemarksValidation(event)">
				</div>
			</div>
			
			<div class="row">
				<div class="col-15">
					<label for="arearHR">Arear HR(DED) </label>
				</div>
				<div class="col-20">
					<input type="text" id="arearHR" name="arearHR"
						onkeypress="arearHRValidation(event)">
				</div>

				
			</div>
			</fieldset>
			<br>
			<div class="col-75"></div>
			
			<div class="row">
				<div class="col-15">					
					<form action="currentUserHomePage.do" method="post">
					<input type="submit" id="submit" value="Home"  > 
					</form>
					
				</div>
				<div class="col-15">
					<input type="submit" id="submit" value="Submit"  onclick="UpdateEmployeeDeduction(event)" >
				</div>					
			</div>
			
		</div>
	</center>
</body>
</html>