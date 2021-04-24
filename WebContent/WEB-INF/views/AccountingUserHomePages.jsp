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
	min-width: 180px;
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
	document.getElementById("myDropdown").innerHTML = links;
	
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
			<h1>Bangladesh House building Finance Corporation</h1>
		</div>

		<div class="dropdown">
			<button onclick="myFunction()" class="dropbtn"> General Accounting </button>
			<div id="myDropdown" class="dropdown-content">
				<a id="1" href="AccountingVoucherEntryPages.do"> Voucher Entry</a>
				<a id="2" href="TransactionEntryValidation.do">Voucher Validation   </a> 
				<a id="3" href="NewGlOpeningPages.do">New Account  </a> 
				<a id="4" href="VouherViewReport.do">Voucher Print </a> 
				<a id="5" href="CashBookViewReport.do">Cash Book </a> 
				<a id="6" href="GLStatementViewReport.do">GL Statement </a> 
				<a id="7" href="GLRegisterViewReport.do">GL Register </a>
				<a id="8" href="TrailBalanceViewReport.do"> Trail Balance</a>
												
			</div>
		</div>

			

	</f:view>
</body>
</html>