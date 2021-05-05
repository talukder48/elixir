<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:f="http://java.sun.com/jsf/core"
	xmlns:h="http://java.sun.com/jsf/html">
<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Bangladesh House Building Finance Corporation</title>
<script src="http://domain.tld/path/to/external.js"
	type="text/javascript"></script>
<style>


.AccEntyDropBtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.AccEntyDropBtn:hover, .AccEntyDropBtn:focus {
	background-color: #2980B9;
}

.AccEntyDropDown {
    max-width: 200px;
	position: relative;
	display: inline-block;
}

.AccEntyDropDown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 180px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.AccEntyDropDown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.AccEntyDropDown a:hover {
	background-color: #ddd;
}

.AccReportDropBtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.AccReportDropBtn:hover, .AccReportDropBtn:focus {
	background-color: #2980B9;
}

.AccReportDropDown {
	position: relative;
	display: inline-block;
}

.AccReportDropDown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.AccReportDropDown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.AccReportDropDown a:hover {
	background-color: #ddd;
}


.payrolldropbtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.payrolldropbtn:hover, .payrolldropbtn:focus {
	background-color: #2980B9;
}

.payRolldropdown {
	position: relative;
	display: inline-block;
}

.payRolldropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.payRolldropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.payRolldropdown a:hover {
	background-color: #ddd;
}

.dropbtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
	background-color: #2980B9;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown a:hover {
	background-color: #ddd;
}



.show {
	display: block;
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
function init()
{
	var ArrayList="<%=session.getAttribute("Array")%>";
	document.getElementById("accDropDown").innerHTML = links;
	
}


function AccEntyFunction() {
  document.getElementById("accDropDown").classList.toggle("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.AccEntyDropBtn')) {
    var dropdowns = document.getElementsByClassName("AccEntyDropDown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


function AccReportFunction() {
	  document.getElementById("reportDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
	  if (!event.target.matches('.AccReportDropBtn')) {
	    var dropdowns = document.getElementsByClassName("AccReportDropDown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}
	
	
	

	function PayrollmyFunction() {
	  document.getElementById("PayDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
	  if (!event.target.matches('.payrolldropbtn')) {
	    var dropdowns = document.getElementsByClassName("payRolldropdown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}	
	
	
	function myFunction() {
		  document.getElementById("myDropdown").classList.toggle("show");
		}

		window.onclick = function(event) {
		  if (!event.target.matches('.dropbtn')) {
		    var dropdowns = document.getElementsByClassName("dropdown-content");
		    var i;
		    for (i = 0; i < dropdowns.length; i++) {
		      var openDropdown = dropdowns[i];
		      if (openDropdown.classList.contains('show')) {
		        openDropdown.classList.remove('show');
		      }
		    }
		  }
		}
	
</script>
</head>
<body onload="init()">

	<f:view>


		<div align="center">
			<h1>Bangladesh House Building Finance Corporation</h1>			
			<h5>22, Purana Paltan</h5>
		</div>

		<div class="AccEntyDropDown">
			<button onclick="AccEntyFunction()" class="AccEntyDropBtn">  General Accounting [Entry Module] </button>
			<div id="accDropDown" class="AccEntyDropDown-content">
				<a id="1" href="AccountingVoucherEntryPages.do"> Voucher Entry [Search] </a>
				<a id="2" href="VoucherEntryItemWise.do"> Voucher Entry [Item Wise] </a>
				<a id="3" href="TransactionEntryValidation.do">Voucher Validation </a> 				
				<a id="4" href="NewGlOpeningPages.do"> New Account Open  </a>
				<a id="5" href="BranchWiseItemsCreation.do">Branch Wise Item Creation  </a> 
				<a id="6" href="GLOpeningBalance.do">Opening Balance </a>																
			</div>
			<br /><br />
			
			<div class="AccReportDropDown">
			<button onclick="AccReportFunction()" class="AccReportDropBtn">General Accounting [Report Module]</button>
			<div id="reportDropdown" class="AccReportDropDown-content">
				<a id="4" href="VouherViewReport.do">Single Voucher Print </a> 
				<a id="5" href="CashBookViewReport.do">Cash Book[Day Book] Report </a> 
				<a id="6" href="GLStatementViewReport.do">General Ledger Statement </a> 
				<a id="7" href="GLRegisterViewReport.do">General Ledger Register[Subsidiary] </a>
				<a id="8" href="TrailBalanceViewReport.do">Financial Statements[TB,BS,PL]</a>
			</div>
			
		  </div>
		  <br /><br />
		  
		  <div class="payRolldropdown">
			<button onclick="PayrollmyFunction()" class="payrolldropbtn">Payroll Management System</button>
			<div id="PayDropdown" class="payRolldropdown-content">
				<a id="1" href="addEmployeeBasicData.do">Basic Profile</a>
				<a id="2" href="addEmployeeAllowanceData.do">Add Allowance </a> 
				<a id="3" href="addEmployeeDeductionData.do">Add Deduction</a> 
				<a id="4" href="addEmployeeIncentiveData.do">Add Incentive Data</a>
				<a id="5" href="ViewMonthlySalaryReport.do">Monthly Salary Report</a>
				<a id="6" href="ViewFestivalBonusReport.do">Festival & Bangla New Year</a> 
				<a id="7" href="ViewIncentiveReport.do">Incentive Report</a>
				<a id="8" href="ViewSalaryCertificate.do"> Salary Certificate</a> 
				
			</div>
		</div>
		
		<br /><br />
		
		<div class="dropdown">
			<button onclick="myFunction()" class="dropbtn">Pension Payment System </button>
			<div id="myDropdown" class="dropdown-content">
				<a id="1" href="PensionNothiDataUpdate.do"> Pension Employee Record Entry</a>
				<a id="2" href="PensionInharitanceDataUpdate.do">Inheritance Record Entry </a> 
				<a id="3" href="PensionAllwanceDataUpdate.do">Allowance Record Enty</a> 
				<a id="4" href="PensionDeductionDataUpdate.do">Deduction Record Entry</a> 
				<a id="5" href="PensionMonthlyReportView.do">Monthly Report</a> 
				<a id="6" href="PensionYearlyReportview.do">Yearly Report</a>
				<a id="7" href="PensionBonusReportView.do">Bonus Report</a>
			</div>
		</div>
			
		</div>

			

	</f:view>
</body>
</html>