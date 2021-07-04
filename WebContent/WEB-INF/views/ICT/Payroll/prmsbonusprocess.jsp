<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<style> 
body {
 /*  background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
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
	background-color: #339933;
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

.col-25 {
	float: left;
	width: 40%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
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
var User_Id="";
function initValues(){
		User_Id= "<%=session.getAttribute("User_Id")%>";
		var today = new Date();
/* 		document.getElementById("asonDate").value = ('0' + today.getDate())
				.slice(-2)
				+ '-'
				+ ('0' + (today.getMonth() + 1)).slice(-2)
				+ '-'
				+ today.getFullYear(); */
		document.getElementById("bonusPct").value = "";
		document.getElementById("orderNo").value = "";
		var dt = new Date();
		document.getElementById("Year").value=dt.getFullYear();		
		document.getElementById("bonusType").focus();
	}

	function BonusType(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("bonusPct").focus();
		}
	}

	function BonusPercentage(event) {
		if (event.keyCode == 13 || event.which == 13) {
			if(document.getElementById("bonusPct").value != ""){
				document.getElementById("orderNo").focus();
			}
			else
				document.getElementById("bonusPct").focus();
		}
	}

	function OrderNo(event) {
		if (event.keyCode == 13 || event.which == 13) {
			if(document.getElementById("orderNo").value != ""){
				document.getElementById("bonusProcess").focus();
			}
			else
				document.getElementById("orderNo").focus();
		}
	}

	function BonusProcess(event) {
		var c = confirm("Are you sure?");
		if (c == true) {
			clear();
		    SetValue("User_Id",User_Id);
		    SetValue("bonusType",document.getElementById("bonusType").value);
		    SetValue("bonusPct",document.getElementById("bonusPct").value);
		    SetValue("orderNo",document.getElementById("orderNo").value);
		    SetValue("MonthCode",document.getElementById("MonthCode").value);
		    SetValue("Year",document.getElementById("Year").value);
			SetValue("Class","SuperOperation");
			SetValue("Method","BonusProcess");
			
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
		} else {
			document.getElementById("bonusType").focus();
		}
	}
</script>
<body onload="initValues()">
	<center>
		<h2>[Bonus Calculation Process]</h2>
				
		<div class="container">
								
				<div class="row">
					<div class="col-25">
						<label for="Year">Basic Year</label>
					</div>
					<div class="col-75">
						<input type="text" id="Year" name="Year" onkeypress="YearValidation(event)">
					</div>
				</div>							
				<div class="row">
					<div class="col-25">
							<label for="MonthCode">Basic Month</label>
					</div>
					<div class="col-75">
						<select id="MonthCode" name="MonthCode"  onkeypress="EmployeeIdValidation(event)">
							<option value="1">January</option>
							<option value="2">February</option>
							<option value="3">March</option>
							<option value="4">April</option>
							<option value="5">May</option>
							<option value="6">June</option>
							<option value="7">July</option>
							<option value="8">August</option>
							<option value="9">September</option>
							<option value="10">October</option>
							<option value="11">November</option>
							<option value="12">December</option>
							
						</select>
					</div>
				</div>
			
			<div class="row">
				<div class="col-25">
					<label for="bonusType">Bonus Type </label>
				</div>
				<div class="col-75">
					<select id="bonusType" name="bonusType"
						onkeypress="BonusType(event)">
						<option value="EIDFT">Eid-Ul-Fitr</option>
						<option value="EIDAH">Eid-Ul-Adha</option>
						<option value="NEWYR">Nabobarsha</option>
						<option value="DURGA">Durga Puja</option>
						<option value="INCTV">Incentive</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-25">
					<label for="bonusPct">Bonus Percentage</label>
				</div>
				<div class="col-75">
					<input type="text" id="bonusPct" name="bonusPct"
						onkeypress="BonusPercentage(event)">
				</div>
			</div>
			<div class="row">
				<div class="col-25">
					<label for="orderNo">Order No.</label>
				</div>
				<div class="col-75">
					<input type="text" id="orderNo" name="orderNo"
						onkeypress="OrderNo(event)">
				</div>
			</div>
			<div class="col-75"></div>
			<div class="row">
				<input type="submit" id="bonusProcess" value="Execute!"
					onclick="BonusProcess(event)">
			</div>
		</div>
	</center>
</body>
</html>