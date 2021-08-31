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
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
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
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
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
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
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


.misDropbtn {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

.misDropbtn:hover, .misDropbtn:focus {
	background-color: #2980B9;
}

.misdropdown {
	position: relative;
	display: inline-block;
}

.misdropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.misdropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.misdropdown a:hover {
	background-color: #ddd;
}

.prmsreportbtn {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

.prmsreportbtn:hover, .prmsreportbtn:focus {
	background-color: #2980B9;
}

.prmsreportdropdown {
	position: relative;
	display: inline-block;
}

.prmsreportdropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.prmsreportdropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.prmsreportdropdown a:hover {
	background-color: #ddd;
}
.misbutton {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

.misbutton:hover, .misbutton:focus {
	background-color: #2980B9;
}

.misreportdown {
	position: relative;
	display: inline-block;
}

.misreportdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 180px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.misreportdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.misreportdown a:hover {
	background-color: #ddd;
}
.profiledropbutton {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

.profiledropbutton:hover, .profiledropbutton:focus {
	background-color: #2980B9;
}

.profiledropdown {
	position: relative;
	display: inline-block;
}

.profiledropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.profiledropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.profiledropdown a:hover {
	background-color: #ddd;
}

.lmsdropbtn {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

.lmsdropbtn:hover, .lmsdropbtn:focus {
	background-color: #2980B9;
}

.lmsdropdown {
	position: relative;
	display: inline-block;
}

.lmsdropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.lmsdropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.lmsdropdown a:hover {
	background-color: #ddd;
}

.show {
	display: block;
}
input[type=submit] {
	background-color: #0e802c;
	color: white;
	font-size: 15px;
	height: 30px;
	width: 300px;
	border: none;
	cursor: pointer;
}

header {
  background-color: white;
  padding: 15px;
  text-align: center;
  font-size: 15px;
  text-color:green;
  
}

/* Create two columns/boxes that floats next to each other */
nav {
  float: left;
  width: 25%;
  height: 500px; /* only for demonstration, should be removed */
  background: white;
  padding: 20px;
}

/* Style the list inside the menu */
nav ul {
  list-style-type: none;
  padding: 0;
}

article {
text-align: justify;
  float: left;
  padding: 20px;
  width: 69%;
  background-color: white;
  height: 500px; /* only for demonstration, should be removed */
}

/* Clear floats after the columns */
section::after {
  content: "";
  display: table;
  clear: both;
}

/* Style the footer */
footer {
  background-color: white;
  padding: 10px;
  text-align: center;
  color: green;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
  }
}

.vl {
  border-left: 1px solid green;
  padding: 10px;
  height: 500px;
}
</style>
<script type="text/javascript">

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
			var dropdowns = document
					.getElementsByClassName("AccEntyDropDown-content");
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
			var dropdowns = document
					.getElementsByClassName("AccReportDropDown-content");
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
			var dropdowns = document
					.getElementsByClassName("payRolldropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}

	function misFunction() {
		document.getElementById("misDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.misDropbtn')) {
			var dropdowns = document
					.getElementsByClassName("misdropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}
	function prmsFunction() {
		document.getElementById("prmsdropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.prmsreportbtn')) {
			var dropdowns = document
					.getElementsByClassName("prmsreportdropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}

	function misreportfunction() {
		document.getElementById("misreportDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.misbutton')) {
			var dropdowns = document
					.getElementsByClassName("misreportdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}
	function myProfileFunction() {
		document.getElementById("myprofiledropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.profiledropbutton')) {
			var dropdowns = document
					.getElementsByClassName("profiledropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}

	function lmsFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.lmsdropbtn')) {
			var dropdowns = document
					.getElementsByClassName("lmsdropdown-content");
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

	
	
<header>
  <div align="center">
			<h1 style="color: green;">Bangladesh House Building Finance Corporation</h1>			
			<h5>22, Purana Paltan</h5>
		</div>
	<hr style="width:100%;text-align:left;margin-left:0">	
</header>

<section>
  <nav>
  
   <f:view>
   
   <fieldset>
   <legend>Entry Module</legend>
   
		<div class="AccEntyDropDown">
			<button onclick="AccEntyFunction()" class="AccEntyDropBtn">  General Accounting Software  </button>
			<div id="accDropDown" class="AccEntyDropDown-content">
				<a id="1" href="VoucherEntryHeadWise.do"> Voucher Entry [Search] </a>
				<a id="2" href="VoucherEntryItemWise.do"> Voucher Entry [Item Wise] </a>
				<a id="3" href="TransactionEntryValidation.do">Voucher Validation </a> 				
				<a id="4" href="NewGlOpeningPages.do"> New Account Open  </a>
				<a id="5" href="BranchWiseItemsCreation.do">Branch Wise Item Creation  </a> 
				<a id="6" href="GLOpeningBalance.do">Opening Balance </a>																
			</div>
			<br /><br />			
		  
		  <div class="payRolldropdown">
			<button onclick="PayrollmyFunction()" class="payrolldropbtn">Payroll Management System </button>
			<div id="PayDropdown" class="payRolldropdown-content">
				<a id="1" href="addEmployeeBasicData.do">Basic Profile</a>
				<a id="2" href="addEmployeeAllowanceData.do">Add Allowance </a> 
				<a id="3" href="addEmployeeDeductionData.do">Add Deduction</a> 
				<a id="4" href="addEmployeeIncentiveData.do">Add Incentive Data</a>
				<a id="5" href="addAnnualIncrementData.do">Annual Increment</a>
				
			</div>
		</div>
		<br></br>
		
		<div class="misdropdown">
			<button onclick="misFunction()" class="misDropbtn">Management Information System </button>
			<div id="misDropdown" class="misdropdown-content">
				<a id="1" href="misLoanDisbursement.do">Disbursement</a>
				<a id="2" href="misLoanRecovery.do">Loan Recovery </a> 
				<a id="4" href="misKharidabariData.do">Kharidabari Data</a>
				<a id="5" href="misCourtCaseSettlementData.do">Court Case Settlement </a>
				<a id="6" href="misFaultyLoanCaseDeedReturn.do">Deed Return of Faulty Loan</a>

			</div>
		</div>
			<br></br>
			
		</div>
		<div class="lmsdropdown">
			<button onclick="lmsFunction()" class="lmsdropbtn">Service Simplification (lms)</button>
			<div id="myDropdown" class="lmsdropdown-content">
				<a id="1" href="BorrowerEmailAddress.do">Borrower Email Address</a>
				
			</div>
		</div>
		</fieldset>
		<br></br>
		
		 <fieldset>
              <legend>Report Module</legend>
              
              <div class="AccReportDropDown">
			<button onclick="AccReportFunction()" class="AccReportDropBtn">General Accounting Software </button>
			<div id="reportDropdown" class="AccReportDropDown-content">
				<a id="4" href="VouherViewReport.do"> Voucher Print(Single) </a> 
				<a id="4" href="BulkVouherViewReport.do"> Voucher Print (Bulk) </a> 
				<a id="5" href="ViewCashBookReport.do">Cash Book[Day Book] Report </a> 
				<a id="6" href="ViewGeneralLedgerStatementReport.do">General Ledger Statement </a> 
				<a id="7" href="viewGLRegisterReport.do">General Ledger Register[Subsidiary] </a>
				<a id="8" href="viewBranchReconciliation.do">Reconciliation Report </a>
				<a id="9" href="ViewFinancialReport.do">Financial Statements [TB,BS,PL]</a>
			</div>
			
		  </div>
		  <br /><br />
           <div class="prmsreportdropdown">
			<button onclick="prmsFunction()" class="prmsreportbtn">Payroll Management System </button>
			<div id="prmsdropdown" class="prmsreportdropdown-content">
				<a id="5" href="ViewMonthlySalaryReport.do">Monthly Salary Report</a>
				<a id="6" href="ViewFestivalBonusReport.do">Festival & Bangla New Year</a> 
				<a id="7" href="ViewIncentiveReport.do">Incentive Report</a>
				<a id="8" href="ViewSalaryCertificate.do"> Salary Certificate</a> 
			</div>
		</div>
		
		<br /><br />   
		
		<div class="misreportdown">
			<button onclick="misreportfunction()" class="misbutton">Management Information System  </button>			
			<div id="misreportDropdown" class="misreportdown-content">
				<a id="7" href="viewMISReport.do">MIS Report Module</a>
			</div>
		</div>
              
        </fieldset>
		<br /><br />   
		<fieldset>
              <legend>Personal Profile</legend>
             <div class="profiledropdown">
			<button onclick="myProfileFunction()" class="profiledropbutton">Personal Profile Menu</button>
			<div id="myprofiledropdown" class="profiledropdown-content">
				<a id="1" href="ResetPassword.do">Password Reset</a>												
				<form action="elixir.do" method="post">
				    <input type="submit" id="submit" value="logout"> </input>
				</form>									
			</div>
		</div>
              
        </fieldset>      
		
		
	</f:view>
	
  </nav>
  
 
</section>

<footer>
<hr style="width:100%;text-align:left;margin-left:0">	
  <div style="text-align: center;">
            <p>Copyright &#xA9; 2019.
              <strong>Design & Developed By ICT Operation, <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
              All Rights Reserved.</p>              
        </div>
</footer>
	
	
	
	
	
</body>
</html>