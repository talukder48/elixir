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
	background-color:#ffffff;
	padding: 20px;
}

.col-15 {
	float: left;
	text-align: left;
	width: 10%;
}
.colr-15 {
	float: left;
	text-align: left;
	width: 15%;
	margin-left: 50px;
}
.col-20 {
	float: left;
	width: 27%;
}
.colr-20 {
	float: left;
	width: 28%;
	
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
	width: 40%;
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
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  top: 100%;
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

var BD_DistrictList = ["Bagerhat","Bandarban","Barguna","Barisal","Bhola","Bogra","Brahmanbaria","Chandpur","Chittagong","Chuadanga","Comilla","Cox's Bazar","Dhaka","Dinajpur","Faridpur","Feni","Gaibandha","Gazipur","Gopalganj","Habiganj","Jaipurhat","Jamalpur","Jessore","Jhalakati","Jhenaidah","Khagrachari","Khulna","Kishoreganj","Kurigram","Kustia","Lakshmipur","Lalmonirhat","Madaripur","Magura","Manikganj","Meherpur","Moulvibazar","Munshiganj","Mymensingh","Naogaon","Narail","Narayanganj","Narsingdi","Natore","Nawabganj","Netrakona","Nilphamari","Noakhali","Pabna","Panchagarh","Chattagram","Patuakhali","Pirojpur","Rajbari","Rajshahi","Rangpur","Satkhira","Shariatpur","Sherpur","Sirajganj","Sunamganj","Sylhet","Tangail","Thakurgaon"];
function autocomplete(inp, arr) {
	  var currentFocus;
	  inp.addEventListener("input", function(e) {
	      var a, b, i, val = this.value;
	      closeAllLists();
	      if (!val) { return false;}
	      currentFocus = -1;
	      a = document.createElement("DIV");
	      a.setAttribute("id", this.id + "autocomplete-list");
	      a.setAttribute("class", "autocomplete-items");
	      this.parentNode.appendChild(a);
	      for (i = 0; i < arr.length; i++) {
	        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
	          b = document.createElement("DIV");
	          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
	          b.innerHTML += arr[i].substr(val.length);
	          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
	          b.addEventListener("click", function(e) {
	              inp.value = this.getElementsByTagName("input")[0].value;
	              closeAllLists();
	          });
	          a.appendChild(b);
	        }
	      }
	  });
	  inp.addEventListener("keydown", function(e) {
	      var x = document.getElementById(this.id + "autocomplete-list");
	      if (x) x = x.getElementsByTagName("div");
	      if (e.keyCode == 40) {
	        currentFocus++;
	        addActive(x);
	      } else if (e.keyCode == 38) { //up
	        currentFocus--;
	        addActive(x);
	      } else if (e.keyCode == 13) {
	        e.preventDefault();
	        if (currentFocus > -1) {
	          if (x) x[currentFocus].click();
	        }
	      }
	  });
	  function addActive(x) {
	    if (!x) return false;
	    removeActive(x);
	    if (currentFocus >= x.length) currentFocus = 0;
	    if (currentFocus < 0) currentFocus = (x.length - 1);
	    x[currentFocus].classList.add("autocomplete-active");
	  }
	  function removeActive(x) {
	    for (var i = 0; i < x.length; i++) {
	      x[i].classList.remove("autocomplete-active");
	    }
	  }
	  function closeAllLists(elmnt) {
	    var x = document.getElementsByClassName("autocomplete-items");
	    for (var i = 0; i < x.length; i++) {
	      if (elmnt != x[i] && elmnt != inp) {
	        x[i].parentNode.removeChild(x[i]);
	      }
	    }
	  }
	  document.addEventListener("click", function (e) {
	      closeAllLists(e.target);
	  });
	}



	var emp_dob = "";
	var userId="";
	
	
	function IsValidDate(myDate) {
	    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
	    return filter.test(myDate);
	}
	
	function initValues() {
		document.getElementById("NothiNo").value = "";
		document.getElementById("EmployeeName").value = "";
		document.getElementById("BenificiaryName").value = "";
		document.getElementById("contactNo").value = "";
		document.getElementById("Address").value = "";
		document.getElementById("email").value = "";
		document.getElementById("DOB").value = "";
		document.getElementById("HandicapType").value = "";						
		document.getElementById("homeDist").value = "";
		document.getElementById("NID").value = "";		
		document.getElementById("PensionType").value="";
		document.getElementById("ActivationType").value = "";
		document.getElementById("BankAccount").value = "";
		document.getElementById("BranchName").value = "";
		document.getElementById("bankName").value = "";	
		document.getElementById("pctPenAmt").value = "";
		document.getElementById("PenAmt").value =  "";
		document.getElementById("SerialNo").value="";
		document.getElementById("PensionType").value="";
		document.getElementById("BranchDistrict").value="";
		document.getElementById("PrAddress").value = "";		
		document.getElementById("NothiNo").focus();
		userId="<%= session.getAttribute("User_Id")%>";
	}
	
	function NothiValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("NothiNo", document.getElementById("NothiNo").value,"N");
		SetValue("Class", "elixir.validator.pps.PensionValidation","N");
		SetValue("Method", "FetchPensionEmployeeData","L");	
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
						if (obj.EMP_NAME!=null) {						
							 document.getElementById("EmployeeName").value = obj.EMP_NAME;						
							 document.getElementById("SerialNo").focus();					
						}
						else{
							initValues();	
							document.getElementById("BenificiaryName").focus();		
						}
					}		
		});					
	}
}
	
	function SerialNoValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("NothiNo", document.getElementById("NothiNo").value,"N");
		SetValue("SerialNo", document.getElementById("SerialNo").value,"N");
		SetValue("Class", "elixir.validator.pps.PensionValidation","N");
		SetValue("Method", "FetchPensionInharitance","L");	
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
						if (obj.RELATIONTYPE !=null) {	
							
							var r = confirm("Data already exists!\nDo you want to update?");
					           if (r == true) {
					        	   document.getElementById("BenificiaryName").value = obj.BENIFICIARYNAME;
									document.getElementById("contactNo").value = obj.CONTACT_NO;
									document.getElementById("Address").value = obj.ADDRESS;
									document.getElementById("email").value = obj.EMAIL;
									document.getElementById("HandicapType").value = obj.HANDICAP;						
									document.getElementById("homeDist").value = obj.HOME_DISTRICT;
									document.getElementById("NID").value = obj.NID;	
									document.getElementById("DOB").value = obj.DOB;	
									document.getElementById("ActivationType").value = obj.SUCC_ACC_ACTIVE;						
									document.getElementById("BankAccount").value = obj.BANK_ACCOUNT;
									document.getElementById("BranchName").value = obj.BRANCH_NAME;
									document.getElementById("bankName").value =  obj.BANK_NAME;							
									document.getElementById("pctPenAmt").value = obj.PENSION_PCT;
									document.getElementById("PenAmt").value =  obj.PENSION_AMT;	
									document.getElementById("homeDist").value =  obj.DISTRICT;	
									document.getElementById("PensionType").value=obj.RELATIONTYPE;
									document.getElementById("BranchDistrict").value = obj.BRANCH_DISTRICT;
									document.getElementById("PrAddress").value = obj.PRADDRESS;		
									document.getElementById("BenificiaryName").focus();		
					           }
					           else{
					        	   document.getElementById("SerialNo").focus();	
					           }																			
						}
						else{						
						var r = confirm("Data Not Found\nDo you want to Add ?");
					           if (r == true) {
					        	   document.getElementById("BenificiaryName").focus();	
					           }
					           else{
					        	   document.getElementById("SerialNo").focus();	
					           }													
							}
					}
		});								
	}
}	

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
	
function BenificiaryNameValidation(event) {
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("pctPenAmt").focus();
	}
}

function PensionPctValidation(event) {
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("PenAmt").focus();
	}
}

function PensionAmtValidation(event) {
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DOB").focus();
	}
}

function DOBValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('DOB');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("contactNo").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("DOB").focus();
	    }
	}
}

function ContactValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("homeDist").focus();
	}
}
function  HomeDistValidation(event){
	
	autocomplete(document.getElementById("homeDist"), BD_DistrictList);
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID").focus();
	}
}

function  NIDValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("email").focus();
	}
}
function EmailValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		var email = document.getElementById('email');
	    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	    if (!filter.test(email.value)) {
	    	alert('Please provide a valid email address');
	    }
	    else{
	    	document.getElementById("Address").focus();
	    }
	}
}
function AddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("bankName").focus();
	}
}
function BankNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BranchName").focus();
	}
}
function BranchNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BankAccount").focus();
	}
}
function BankAccountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

function BranchDistrictValidation(event) {
	autocomplete(document.getElementById("BranchDistrict"), BD_DistrictList);
}
	
function AddPensionInharitanceInfo(event)
{			
		clear();
		SetValue("User_Id",userId,"N");		
		SetValue("NothiNo",document.getElementById("NothiNo").value,"N");
		SetValue("SerialNo",document.getElementById("SerialNo").value,"N");	
		SetValue("BenificiaryName",document.getElementById("BenificiaryName").value,"N");
		SetValue("PensionType",document.getElementById("PensionType").value,"N");
		SetValue("HandicapType",document.getElementById("HandicapType").value,"N");		
		SetValue("pctPenAmt",document.getElementById("pctPenAmt").value,"N");
		SetValue("PenAmt",document.getElementById("PenAmt").value,"N");				
		SetValue("DOB",document.getElementById("DOB").value,"N");
		SetValue("contactNo",document.getElementById("contactNo").value,"N");
		SetValue("homeDist",document.getElementById("homeDist").value,"N");
		SetValue("NID",document.getElementById("NID").value,"N");
		SetValue("email",document.getElementById("email").value);		
		SetValue("ActivationType",document.getElementById("ActivationType").value,"N");						
		SetValue("Address",document.getElementById("Address").value,"N");
		SetValue("bankName",document.getElementById("bankName").value,"N");	
		SetValue("BranchName",document.getElementById("BranchName").value,"N");
		SetValue("BankAccount",document.getElementById("BankAccount").value,"N");
		SetValue("PrAddress",document.getElementById("PrAddress").value,"N");	
		SetValue("BranchDistrict",document.getElementById("BranchDistrict").value,"N");		
		SetValue("Class","elixir.validator.pps.PensionValidation","N");
		SetValue("Method","AddPensionInharitance","L");
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
	$("#DOB").datepicker({
		dateFormat : 'dd-M-yy'
	});
});
	
</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3 style="color:white;">Pension Payment System</h3>
		<div class="container">
		
             <fieldset>
              <legend>Identifier</legend> 
				<div class="row">
					<div class="col-15">
						<label for="NothiNo">Nothi No</label>
					</div>
					<div class="col-20">
						<input type="text" id="NothiNo" name="NothiNo" onkeypress="NothiValidation(event)">
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
						<label for="SerialNo">Serial No.</label>
					</div>
					<div class="col-20">
						<input type="text" id="SerialNo" name="SerialNo" onkeypress="SerialNoValidation(event)">
					</div>
				
					<div class="colr-15">
						<label for="BenificiaryName"> Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="BenificiaryName" name="BenificiaryName" onkeypress="BenificiaryNameValidation(event)">
					</div>
				</div>
				
				</fieldset>
				<fieldset>
				<legend>Inheritance Details</legend>	
				
				  <div class="row">
					<div class="col-15">
						<label for="PensionType">Pension Type </label>
					</div>
					<div class="col-20">
						<select id="PensionType" name="PensionType" style="width:390px;">							
							<option value="W">W-Wife</option>
							<option value="H">H-Husband</option>
							<option value="S">S-Son</option>
							<option value="D">D-Daughter</option>
						</select>
					</div>
				
					<div class="colr-15">
						<label for="HandicapType">Physically Handicap </label>
					</div>
					<div class="colr-20">
						<select id="HandicapType" name="HandicapType" style="width: 405px;">
							<option value="Y">Y-Yes</option>
							<option value="N">N-No</option>		
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-15">
						<label for="pctPenAmt">(%)of predecessor</label>
					</div>
					<div class="col-20">
						<input type="text" id="pctPenAmt" name="pctPenAmt" onkeypress="PensionPctValidation(event)">
					</div>	
				
					<div class="colr-15">
						<label for="PenAmt">Arr.Pension</label>
					</div>
					<div class="colr-20">
						<input type="text" id="PenAmt" value="" onkeypress="PensionAmtValidation(event)" >
					</div>										
				</div>					  				
								
				<div class="row">
					<div class="col-15">
						<label for="DOB">Date of Birth</label>
					</div>
					<div class="col-20">
						<input  type="text" id="DOB" value="" onkeypress="DOBValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="contactNo"> Contact No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="contactNo" name="contactNo" onkeypress="ContactValidation(event)"  >
					</div>	
				</div>	

				<div class="row">
					<div class="col-15">
						<label for="homeDist"> Home District</label>
					</div>
					<div class="col-20">
						<input type="text" id="homeDist" name="homeDist" onkeypress="HomeDistValidation(event)">
					</div>	
				
					<div class="colr-15">
						<label for="NID">NID No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="NID" value="" onkeypress="NIDValidation(event)" >
					</div>										
				</div>	
							
			
				
				<div class="row">
					<div class="col-15">
						<label for="PrAddress">Present Address</label>
					</div>
					<div class="col-20">
						   <input type="text" id="PrAddress" name="PrAddress" onkeypress="PreAddressValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="Address"> Permanent Address</label>
					</div>
					<div class="colr-20">
					<input type="text" id="Address" value="" onkeypress="AddressValidation(event)" >
					</div>	
				</div>	
				
				<div class="row">
					<div class="col-15">
						<label for="email">Email</label>
					</div>
					<div class="col-20">
						   <input type="text" id="email" name="email" onkeypress="EmailValidation(event)">
					</div>										
				</div>	
				<br>	
					
					
				</fieldset>
				
				<fieldset >
				<legend>Bank Details:</legend> 
				
				<div class="row">				
					<div class="col-15">
						<label for="bankName"> Bank Name </label>
					</div>				
					<div class="col-20">
						<input type="text" id="bankName" name="bankName" onkeypress="BankNameValidation(event)"  >
					
				   </div>
				
					<div class="colr-15">
						<label for="BranchName"> Branch Name </label>
					</div>				
					<div class="colr-20">
						<input type="text" id="BranchName" name="BranchName" onkeypress="BranchNameValidation(event)"  >					
				   </div>					
				</div>	
				
				 <div class="row">				
					<div class="col-15">
						<label for="BankAccount"> Bank Account </label>
					</div>				
					<div class="col-20">
						<input type="text" id="BankAccount" name="BankAccount" onkeypress="BankAccountValidation(event)"  >
					
				   </div>	
				   
				   <div class="colr-15">
						<label for="ActivationType">Activation Type</label>
				</div>
					<div class="colr-20">
						<select id="ActivationType" name="ActivationType"  maxlength="45" onkeypress="ActivationTypeValidator(event)" style="width: 405px;">
							<option value="Y">Y-Pension Active</option>
							<option value="N">N-Pension In Active</option>												
						</select>
				</div>	
				   												
				</div>	
				
				<div class="row">				
					<div class="col-15">
						<label for="BranchDistrict"> Branch District </label>
					</div>				
					<div class="col-20">
						<input type="text" id="BranchDistrict" name="BranchDistrict" onkeypress="BranchDistrictValidation(event)"  >					
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
					     <input type="submit" id="submit" value="Submit" onclick="AddPensionInharitanceInfo(event)" >
					</div>
				</div>
				
			 </div>
		</div>
	</center>
</body>
</html>
