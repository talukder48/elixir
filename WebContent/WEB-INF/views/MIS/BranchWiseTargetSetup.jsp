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

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


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
  background-color: #ffffff; 
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
	width: 23%;
}

.col-75 {
	float: left;
	width: 50%;
	margin-top: 6px;
}
.col-50 {
	float: left;
	width: 35%;
	margin-top: 6px;
}

.collvl-40 {
	float: left;
	width: 60%;
	
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
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  left: 40px;
  right: 0;
  width:300px
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
}
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  top: 100%;
  left: 0;
  right: 0;
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
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
/* cause google chrome cant assign fetched data in front end form */

var userId="";

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}

function initValues(){	
	LoadTarget();
	document.getElementById("BranchCode").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}
function LoadTarget(){
	clear();	
	SetValue("Class", "elixir.validator.pps.MISDataValidation","N");
	SetValue("Method", "FetchTargetList","L");
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
				var item_srting=obj.TARGET_LIST;	
				var select = document.getElementById("TargetCode");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0] ;
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
}
function fetchData(){
    	clear();    	
		SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		SetValue("TargetCode",document.getElementById("TargetCode").value,"N");	
		SetValue("Class","elixir.validator.pps.MISDataValidation","N");
		SetValue("Method","FetchTargetData","L");
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
					    document.getElementById("ZeroEquitySanction").value=obj.ZERO_EQ_SANCTION;
						document.getElementById("OthersSanction").value=obj.OTHS_PD_SANCTION;
						document.getElementById("ZeroEquityDisburse").value=obj.ZERO_EQ_DISBURSE;
						document.getElementById("OthersDisburse").value=obj.OTHS_PD_DISBURSE;
						document.getElementById("CLAmount").value=obj.LOAN_CL_RECOVERY;
						document.getElementById("UCAmount").value=obj.LOAN_UC_RECOVERY;
						document.getElementById("ExecutiveCase").value=obj.SETTLE_EXECUTIVE_CASE;
						document.getElementById("MiscCase").value=obj.SETTLE_WRIT_CASE;
						document.getElementById("Possession").value=obj.KHARIDABARI_PROCESSION;
						document.getElementById("SaleCase").value=obj.KHARIDABARI_SALE;
						document.getElementById("CommercialAudit").value=obj.AUDIT_COMMERCIAL;
						document.getElementById("PostAudit").value=obj.AUDIT_POST_AUDIT;
						document.getElementById("LoanCaseNumber").value=obj.DEED_RETURN_FL;
				}
  	});	
}

function ZeroEquitySanctionValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("OthersSanction").focus();		
	}
}

function OthersSanctionValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();		
	}
}

function EntryDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('EntyDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("ZeroEquitySanction").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("EntyDate").focus();
	    }
	}
}

function TargetSave(event)
{			
		clear();
		SetValue("User_Id",userId,"N");	
		SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		SetValue("TargetCode",document.getElementById("TargetCode").value,"N");		
		SetValue("ZeroEquitySanction",document.getElementById("ZeroEquitySanction").value,"N");
		SetValue("OthersSanction",document.getElementById("OthersSanction").value,"N");		
		SetValue("ZeroEquityDisburse",document.getElementById("ZeroEquityDisburse").value,"N");
		SetValue("OthersDisburse",document.getElementById("OthersDisburse").value,"N");	
		SetValue("CLAmount",document.getElementById("CLAmount").value,"N");
		SetValue("UCAmount",document.getElementById("UCAmount").value,"N");		
		SetValue("ExecutiveCase",document.getElementById("ExecutiveCase").value,"N");
		SetValue("MiscCase",document.getElementById("MiscCase").value,"N");		
		SetValue("Possession",document.getElementById("Possession").value,"N");
		SetValue("SaleCase",document.getElementById("SaleCase").value,"N");		
		SetValue("CommercialAudit",document.getElementById("CommercialAudit").value,"N");
		SetValue("PostAudit",document.getElementById("PostAudit").value,"N");		
		SetValue("LoanCaseNumber",document.getElementById("LoanCaseNumber").value,"N");		
		SetValue("Class","elixir.validator.pps.MISDataValidation","N");
		SetValue("Method","TargetValueSetup","L");	
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

$(function() {
	$("#EntyDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
		
});

</script>

</head>
<body onload="initValues()">
	<center>
	   	<h1 style="color:green;">Bangladesh House Building Finance Corporation</h1>
		         <h3  style="color:green;"> Management Information System </h3>
	
		<div class="container">
		   		
		      <fieldset>
		      <legend>Target Identifier</legend> 

				
				<div class="row">
					<div class="col-15">
							<label for="BranchCode">Branch Name</label>
					</div>
					<div class="col-50">
						<select id="BranchCode" name="BranchCode" >						   
							<option value="0100">Chattogram Branch</option>
							<option value="0101">Cumilla Branch</option>
							<option value="0102">Noakhali Branch</option>
							<option value="0103">Cox's Bazar</option>
							<option value="0104">Rangamati Branch</option>
							<option value="0105">Brahmanbaria</option>
							<option value="0106">Chandpur</option>
							<option value="0107">Feni</option>
							<option value="0108">Laxmipur</option>
							<option value="0200">Khulna Branch</option>
							<option value="0201">Sathkhira</option>
							<option value="0202">Bagerhat</option>
							<option value="0203">Jashore Branch</option>
							<option value="0204">Kushtia Branch</option>
							<option value="0205">Magura</option>
							<option value="0206">Jhinaidah</option>
							<option value="0207">Chuadanga</option>
							<option value="0300">Rajshahi Branch</option>
							<option value="0301">Bogura Branch</option>
							<option value="0302">Nawgaon</option>
							<option value="0303">Pabna  Branch</option>
							<option value="0304">Natore</option>
							<option value="0305">Sirajganj</option>
							<option value="0400">Barishal Branch</option>
							<option value="0401">Jhalokati</option>
							<option value="0402">Potuakhali</option>
							<option value="0403">Bhola</option>
							<option value="0404">Pirojpur</option>
							<option value="0405">Barguna</option>
							<option value="0500">Sylhet Branch</option>
							<option value="0501">Sreemongal</option>
							<option value="0502">Hobiganj</option>
							<option value="0503">Sunamganj</option>
							<option value="0600">Main Branch,Dhaka North.</option>
							<option value="0601">Gazipur Sadar Branch</option>
							<option value="0602">Narsindhi branch</option>
							<option value="0603">Manikganj</option>
							<option value="0700">Dhanmondi</option>
							<option value="0800">Sadar Main Branch</option>
							<option value="0801">Khilgaon</option>
							<option value="0802">Keraniganj</option>
							<option value="0803">Munshiganj</option>
							<option value="0900">Mirpur</option>
							<option value="0901">Pallabi</option>
							<option value="1000">Gulshan</option>
							<option value="2000">Savar</option>
							<option value="2001">Faridpur Branch</option>
							<option value="2002">Gopalganj  Branch</option>
							<option value="2003">Madaripur</option>
							<option value="2004">Rajbari</option>
							<option value="3000">Narayanganj Branch</option>
							<option value="4000">Mymensingh Branch</option>
							<option value="4001">Tangail Branch</option>
							<option value="4002">Jamalpur Branch</option>
							<option value="4003">Kishoreganj</option>
							<option value="4004">Netrokona</option>
							<option value="4005">Sherpur</option>
							<option value="5000">Rangpur Branch</option>
							<option value="5001">Dinajpur Branch</option>
							<option value="5002">Kurigram</option>
							<option value="5003">Gaibandha</option>
							<option value="5004">Lalmonirhat</option>
							<option value="5005">Thakurgaon </option>														
						</select>
					</div>
				</div>	
					
					
			    <div class="row">
					<div class="col-15">
						<label for="">Target Code</label>
					</div>
					<div class="col-50">
					<select id="TargetCode" name="TargetCode">						
					</select>
				</div>
				</div>		
				
				
				<div class="col-50"></div>
				<div class="row">
					<input type="submit" id="fetchData" value="Fetch Data" onclick="fetchData(event)" >
				</div>						            				
				</fieldset>	
									
				<fieldset>		
					 <legend>Target Details</legend>			
																						
				<div class="row">	
					<div class="col-15">
						<label for="ZeroEquitySanction">Zero Equity Sanction  </label>
					</div>
					<div class="col-15">
						<input type="text" id="ZeroEquitySanction" name="ZeroEquitySanction" onkeypress="ZeroEquitySanctionValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="OthersSanction">Other Products Sanction</label>
					</div>
					<div class="col-15">
						<input type="text" id="OthersSanction" name="OthersSanction" onkeypress="OthersSanctionValidation(event)">
					</div>																				  														
				</div>																																
									
																						
				<div class="row">	
					<div class="col-15">
						<label for="ZeroEquityDisburse">Zero Equity Disburse </label>
					</div>
					<div class="col-15">
						<input type="text" id="ZeroEquityDisburse" name="ZeroEquityDisburse" onkeypress="ZeroEquityDisburseValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="OthersDisburse">Other Products Disburse </label>
					</div>
					<div class="col-15">
						<input type="text" id="OthersDisburse" name="OthersDisburse" onkeypress="OthersDisburseValidation(event)">
					</div>																				  														
				</div>																																
																												
				<div class="row">	
					<div class="col-15">
						<label for="CLAmount">CL Amount </label>
					</div>
					<div class="col-15">
						<input type="text" id="CLAmount" name="CLAmount" onkeypress="CLAmountValidation(event)">
					</div>	
					
					<div class="col-15">
						<label for="UCAmount">UC Amount </label>
					</div>
					<div class="col-15">
						<input type="text" id="UCAmount" name="UCAmount" onkeypress="UCAmountValidation(event)">
					</div>	
													  														
				</div>												
																												
				<div class="row">	
					<div class="col-15">
						<label for="ExecutiveCase">Executive Cases </label>
					</div>
					<div class="col-15">
						<input type="text" id="ExecutiveCase" name="ExecutiveCase" onkeypress="ExecutiveCaseValidation(event)">
					</div>	
					
					<div class="col-15">
						<label for="MiscCase"> Misc. Case </label>
					</div>
					<div class="col-15">
						<input type="text" id="MiscCase" name="MiscCase" onkeypress="MiscCaseValidation(event)">
					</div>										  														
				</div>														
																						
				<div class="row">	
					<div class="col-15">
						<label for="Possession">No of Possession </label>
					</div>
					<div class="col-15">
						<input type="text" id="Possession" name="Possession" onkeypress="PossessionValidation(event)">
					</div>	
					
					<div class="col-15">
						<label for="SaleCase">No of Sale </label>
					</div>
					<div class="col-15">
						<input type="text" id="SaleCase" name="SaleCase" onkeypress="SaleCaseValidation(event)">
					</div>									  														
				</div>																									
																			
				<div class="row">	
					<div class="col-15">
						<label for="CommercialAudit">Commercial Audit </label>
					</div>
					<div class="col-15">
						<input type="text" id="CommercialAudit" name="CommercialAudit" onkeypress="CommercialAuditValidation(event)">
					</div>	
					
					<div class="col-15">
						<label for="PostAudit">Post Audit </label>
					</div>
					<div class="col-15">
						<input type="text" id="PostAudit" name="PostAudit" onkeypress="PostAuditValidation(event)">
					</div>															  														
				</div>																																
																						
				<div class="row">	
					<div class="col-15">
						<label for="LoanCaseNumber">No of Loan Case </label>
					</div>
					<div class="col-15">
						<input type="text" id="LoanCaseNumber" name="LoanCaseNumber" onkeypress="LoanCaseNumberValidation(event)">
					</div>									  														
				</div>											
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
				
				<div class="col-15">
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
					</div>
				<div class="col-15">
					<input type="submit" id="submit" value="Submit" onclick="TargetSave(event)" >
					</div>
				</div>
			 </div>
			</div>
	</center>
</body>
</html>