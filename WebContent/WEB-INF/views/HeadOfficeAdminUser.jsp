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


.hrmEntryDropBtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.hrmEntryDropBtn:hover, .hrmEntryDropBtn:focus {
	background-color: #2980B9;
}

.hrmEntyDropDown {
    max-width: 200px;
	position: relative;
	display: inline-block;
}

.hrmEntyDropDown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 180px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.hrmEntyDropDown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.hrmEntyDropDown a:hover {
	background-color: #ddd;
}

.hrmReportDropBtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.hrmReportDropBtn:hover, .hrmReportDropBtn:focus {
	background-color: #2980B9;
}

.hrmReportDropDown {
	position: relative;
	display: inline-block;
}

.hrmReportDropDown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 190px;
	overflow: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.hrmReportDropDown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.hrmReportDropDown a:hover {
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

.pensiondropbtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

.pensiondropbtn:hover, .pensiondropbtn:focus {
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

.misDropbtn {
	background-color: #3498DB;
	color: white;
	padding: 16px;
	font-size: 16px;
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
	document.getElementById("hrmEntyDropDown").innerHTML = links;
	
}


function hrmEntyFunction() {
  document.getElementById("hrmEntyDropDown").classList.toggle("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.hrmEntryDropBtn')) {
    var dropdowns = document.getElementsByClassName("hrmEntyDropDown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}


function hrmReportFunction() {
	  document.getElementById("reportDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
	  if (!event.target.matches('.hrmReportDropBtn')) {
	    var dropdowns = document.getElementsByClassName("hrmReportDropDown-content");
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
	
	
	function pensionFunction() {
		  document.getElementById("penDropdown").classList.toggle("show");
		}

		window.onclick = function(event) {
		  if (!event.target.matches('.pensiondropbtn')) {
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
		function MisFunction() {
			  document.getElementById("misDropdown").classList.toggle("show");
			}

			window.onclick = function(event) {
			  if (!event.target.matches('.misDropbtn')) {
			    var dropdowns = document.getElementsByClassName("misdropdown-content");
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

		<div class="hrmEntyDropDown">
			<button onclick="hrmEntyFunction()" class="hrmEntryDropBtn">  HR Management [Entry Module] </button>
			<div id="hrmEntyDropDown" class="hrmEntyDropDown-content">
				<a id="1" href="addEmployeeRecord.do">Employee Record Entry</a>
				<a id="3" href="addTransferRecord.do">Transfer Record Entry</a> 
				<a id="4" href="addIncrementRecord.do">Increment Record Entry</a> 
				<a id="5" href="addPromotionRecord.do">Promotion Record Entry</a>
				<a id="6" href="addSuspendRecord.do">Suspend Record Entry</a>
				<a id="2" href="addLeaveRecord.do">All Leave Record Entry</a> 														
			</div>
			<br /><br />
			
			<div class="hrmReportDropDown">
			<button onclick="hrmReportFunction()" class="hrmReportDropBtn">HR Management [Report Module]</button>
			<div id="reportDropdown" class="hrmReportDropDown-content">
				<a id="1" href="VouherViewReport.do"> Personal Data Register</a> 
				<a id="2" href="CashBookViewReport.do">Advance Data Report </a> 
				<a id="2" href="CashBookViewReport.do">Audit Objection Report </a>
				<a id="2" href="CashBookViewReport.do">Leave Related Register </a>
				<a id="2" href="CashBookViewReport.do">Transfer Related Report </a>
				<a id="2" href="CashBookViewReport.do">All Employee Register </a>
			</div>
			
		  </div>
		  <br /><br />
		  
			<div class="misdropdown">
			<button onclick="MisFunction()" class="misDropbtn">Employee Loan Management System</button>
			<div id="misDropdown" class="misdropdown-content">
				<a id="1" href="viewAdvanceReport.do">Employee Loan Statements</a>
			</div>
		</div>
			
			
		</div>

			

	</f:view>
</body>
</html>