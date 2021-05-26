<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<style> 
body {
  /* background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
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
	background-color: #ffffff;
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
	width: 30%;
	margin-top: 6px;
}

.col-50 {
	float: left;
	width: 50%;
	margin-top: 6px;
}
.colt-20 {
	float: left;
	width: 75%;
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


function RefreshValues(){
	
	document.getElementById("TransactionAmount").value= "0.00";
	document.getElementById("BranchCode").value="<%= session.getAttribute("BranchCode")%>";
	document.getElementById("TransactionAmount").focus();
}

function initValues(){
	loadgllist();
	//loadgitem();
	document.getElementById("TransactionAmount").value= "0.00";
	document.getElementById("BranchCode").value="<%= session.getAttribute("BranchCode")%>";
	document.getElementById("TransactionAmount").focus();
}


var availableTags=[];

function loadgllist(){
	var loggedBranch="<%=session.getAttribute("BranchCode")%>";
	clear();		
	SetValue("loggedBranch", loggedBranch,"N");
	SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
	SetValue("Method", "FetchGLData","L");	
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
					gl_srting=obj.GL_LIST;					
					 var gl_arrayList = gl_srting.split(',');
					 for(var i = 0; i < gl_arrayList.length; i++) {
						 gl_arrayList[i] = gl_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");				
					    var gl_keyValue = gl_arrayList[i].split(':');
					    availableTags.push(gl_keyValue[1]+":"+gl_keyValue[0]);
					 }
				}
		});				
}
$(function() {	 
	  $( "#glcode" ).autocomplete({
	    source: availableTags
	  });
	} 
);

function GLValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DrCrType").focus();		
	}
}

function TransactionAmountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {    		   		
		if(document.getElementById("TransactionAmount").value!=""){
			if(isNaN(document.getElementById("TransactionAmount").value)){
				alert("Transaction Amount is not number");
				document.getElementById("TransactionAmount").focus();
			}
			else{
				if(parseFloat(document.getElementById("TransactionAmount").value)<=0.00){
    				alert("Transaction Amount Should be Greater then Zero");
    				document.getElementById("TransactionAmount").focus();
    			}
    			else
    				{
    				document.getElementById("TransactionAmount").value=parseFloat(document.getElementById("TransactionAmount").value).toFixed(2);
    				document.getElementById("FinYear").focus();
    			}
			}        			
		}
		else
			{
			  alert("Should not blank");
			  document.getElementById("TransactionAmount").focus();
		}   
	}
}

function FinancialYearValidation(){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("FinYear").value==""){
			 alert("Should not blank");
		}else{
			document.getElementById("eventTransaction").focus();
		}
				
	}
}

function DataUpdate(event)
{
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		    clear();		    		    
		    var User_Id ="<%= session.getAttribute("User_Id")%>";
		    var usr_brn ="<%= session.getAttribute("BranchCode")%>";		    
		    SetValue("loggedBranch",usr_brn,"N");
		    SetValue("User_Id",User_Id,"N");
		    SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		    SetValue("glcode",document.getElementById("glcode").value,"N");
		    SetValue("DrCrType",document.getElementById("DrCrType").value,"N");
		    SetValue("TransactionAmount",document.getElementById("TransactionAmount").value,"N");
		    SetValue("FinYear",document.getElementById("FinYear").value,"N");
		    SetValue("Class","elixir.validator.pps.GeneralAccontingSystem","N");
			SetValue("Method","OpeningBalance","L");
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
	  } else {
		  document.getElementById("eventViewTransaction").focus();
	  }	
}

$(function() {
	$("#entryDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>
<body onload="initValues()">
	<center>
	
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3  style="color:white;"> General Accounting System </h3>
		
	<div class="container">
	
				<div class="row">
					<div class="col-15">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-15">
						<input type="text" id="BranchCode" name="BranchCode" >
					</div>
				</div>
				
	            <div class="row">
					<div class="col-15">
						<label for="glcode">GL Head</label>
					</div>
					<div class="col-50">
						<input type="text" id="glcode" name="glcode" onkeypress="GLValidation(event)">
					</div>
				</div>
				
								
								
				<div class="row">
				<div class="col-15">
					<label for="DrCrType">Dr/Cr Type </label>
				</div>
				<div class="col-25">
					<select id="DrCrType" name="DrCrType"
						onkeypress="TransationTypeValidation(event)" >
						<option value="D">D-Debit</option>
						<option value="C">C-Credit</option>
						
					</select>
					</div>
				</div>
	
				<div class="row">
					<div class="col-15">
						<label for="TransactionAmount">Closing Amount</label>
					</div>
					<div class="col-15">
						<input type="text" id="TransactionAmount" name="TransactionAmount" onkeypress="TransactionAmountValidation(event)">
					</div>
				</div>
								
				<div class="row">
					<div class="col-15">
						<label for="FinYear">Financial Year</label>
					</div>
					<div class="col-15">
						<input type="text" id="FinYear" name="FinYear"  onkeypress="FinancialYearValidation(event)">
					</div>
				</div>
								
				<br>
				
				<div class="row">
				<div class="col-75"></div>
				<div class="col-15">
				</div>
				<div class="col-15">
					<input type="submit" id="eventTransaction" value="Submit" onclick="DataUpdate(event)" > 
				</div>									
				</div>
				
																	
	</div>
	</center>
</body>
</html>