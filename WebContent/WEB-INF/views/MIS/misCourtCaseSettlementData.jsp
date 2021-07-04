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
	width: 15%;
}
.col-20 {
	text-align:left;
	float: left;
	width: 16%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
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
	width: 50%;
	margin-top: 6px;
}
.col-80 {
	float: left;
	width: 15%;
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

	document.getElementById("BranchCode").value= "<%= session.getAttribute("BranchCode")%>";
	document.getElementById("ExecutiveCase").value="0";
	document.getElementById("MiscCase").value="0";	
	document.getElementById("EntyDate").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}


function ExecutiveCaseValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MiscCase").focus();		
	}
}

function MiscCaseValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();		
	}
}

function EntryDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('EntyDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {	    	
	    	clear();
			SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
			SetValue("EntyDate",document.getElementById("EntyDate").value,"N");	
			SetValue("Class","elixir.validator.pps.MISDataValidation","N");
			SetValue("Method","FetchCourtCaseSettlementData","L");
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
						if (obj.EXECUTIVE_CASE!=null) {
							var r = confirm("Data already exists!\nDo you want to update?");
							  if (r == true) {		
								    document.getElementById("ExecutiveCase").value=obj.EXECUTIVE_CASE;
									document.getElementById("MiscCase").value=obj.WRIT_CSE;							
									document.getElementById("ExecutiveCase").focus();							
							  }
						}
						else{
							document.getElementById("ExecutiveCase").value="0";
							document.getElementById("MiscCase").value="0";
							document.getElementById("ExecutiveCase").focus();
						}			
					}	
			}); 					
						    	
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("EntyDate").focus();
	    }
	}
}
function fetchData(){

	var txtTest = document.getElementById('EntyDate');
    var isValid = IsValidDate(txtTest.value);
    if (isValid) {	    	
    	clear();
		SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		SetValue("EntyDate",document.getElementById("EntyDate").value,"N");	
		SetValue("Class","elixir.validator.pps.MISDataValidation","N");
		SetValue("Method","FetchCourtCaseSettlementData","L");
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
					if (obj.EXECUTIVE_CASE!=null) {
						var r = confirm("Data already exists!\nDo you want to update?");
						  if (r == true) {		
							    document.getElementById("ExecutiveCase").value=obj.EXECUTIVE_CASE;
								document.getElementById("MiscCase").value=obj.WRIT_CSE;							
								document.getElementById("ExecutiveCase").focus();							
						  }
					}
					else{
						document.getElementById("ExecutiveCase").value="0";
						document.getElementById("MiscCase").value="0";
						document.getElementById("ExecutiveCase").focus();
					}			
				}	
		}); 					
					    	
    }
    else {
        alert('Incorrect format');
        document.getElementById("EntyDate").focus();
    }

}
function saveData(event)
{			
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  clear();
			SetValue("User_Id",userId,"N");				
			SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
			SetValue("EntyDate",document.getElementById("EntyDate").value,"N");		
			SetValue("ExecutiveCase",document.getElementById("ExecutiveCase").value,"N");
			SetValue("MiscCase",document.getElementById("MiscCase").value,"N");						
			SetValue("Class","elixir.validator.pps.MISDataValidation","N");
			SetValue("Method","AddCourtCaseSettlementData","L");
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
		      <legend>Court Case Identifier</legend> 
		      
		      	<div class="row">
					<div class="col-15">
						<label for="BranchCode">Office Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="BranchCode" name="BranchCode" read only>
					</div>
					<div class="col-15">
						<label for="EntyDate"> Entry Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="EntyDate" value="" onkeypress="EntryDateValidation(event)" >
					</div>										
			  </div>
			  
		      
				<div class="col-80"></div>
				<div class="row">
					<input type="submit" id="fetchData" value="Fetch Data" onclick="fetchData(event)" >
				</div>
				
		            				
				</fieldset>	
				<br><br>	
				<fieldset>	
				<legend>Court Case Settlement</legend>
																			
				<div class="row">	
					<div class="col-20">
						<label for="ExecutiveCase">No of Executive Cases </label>
					</div>
					<div class="col-20">
						<input type="text" id="ExecutiveCase" name="ExecutiveCase" onkeypress="ExecutiveCaseValidation(event)">
					</div>									  														
				</div>
												
				<div class="row">
						<div class="col-20">
						<label for="MiscCase">No of Misc. Cases </label>
					</div>
					<div class="col-20">
						<input type="text" id="MiscCase" name="MiscCase" onkeypress="MiscCaseValidation(event)">
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
					<input type="submit" id="submit" value="Submit" onclick="saveData(event)" >
					</div>
				</div>
			 </div>
			</div>
	</center>
</body>
</html>