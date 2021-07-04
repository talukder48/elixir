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
	background-color: #ffffff;
	padding: 20px;
}

.col-15 {
	float: left;
	width: 15%;
}
.col-20 {
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
	width: 52%;
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


function initValues(){	
	loadgllist();
	document.getElementById("BranchCode").value= "<%= session.getAttribute("BranchCode")%>";
	document.getElementById("ItemCode").value = "";
	document.getElementById("ItemName").value = "";
	document.getElementById("DRglCode").value = "";
	document.getElementById("CRglCode").value = "";
	document.getElementById("ItemEntyDate").value = "";
	document.getElementById("itemremarks").value = "";
	
	document.getElementById("ItemCode").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}


$(function() {	 
	  $( "#DRglCode" ).autocomplete({
	    source: availableTags
	  });
	} 
);

$(function() {	 
	  $( "#CRglCode" ).autocomplete({
	    source: availableTags
	  });
	} 
);

function ItemCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
	clear();
	SetValue("ItemCode", document.getElementById("ItemCode").value,"N");
	SetValue("BranchCode", document.getElementById("BranchCode").value,"N");
	SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
	SetValue("Method", "FetchItemDetails","L");	
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
				if (obj.ITEM_DESC!=null) {
					var r = confirm("Item already exists!\nDo you want to update?");
					  if (r == true) {						  
						    document.getElementById("ItemName").value = obj.ITEM_DESC;
							document.getElementById("DRglCode").value = obj.DEBIT_GL;
							document.getElementById("CRglCode").value = obj.CREDIT_GL;
							document.getElementById("ItemEntyDate").value = obj.ENTY_DATE;
							document.getElementById("itemremarks").value = obj.REMARKS;
							document.getElementById("ItemName").focus();	
					  }
				}
				else{
					document.getElementById("ItemName").value = "";
					document.getElementById("DRglCode").value = "";
					document.getElementById("CRglCode").value = "";
					document.getElementById("ItemEntyDate").value = "";
					document.getElementById("itemremarks").value = "";
					document.getElementById("ItemName").focus();	
				}
				
			} 						
	}); 	
	}
}

function ItemNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DRglCode").focus();		
	}
}

function DebitGLValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("CRglCode").focus();		
	}
}

function CreditGLValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ItemEntyDate").focus();		
	}
}

function ItemDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('ItemEntyDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("itemremarks").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("ItemEntyDate").focus();
	    }
	}
}

function RemarksValidation(event){			
if (event.keyCode == 13 || event.which == 13) {
	  document.getElementById("submit").focus();
	}
}

function ItemCreationFunction(event)
{			
		clear();
		SetValue("User_Id",userId,"N");				
		SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		SetValue("ItemCode",document.getElementById("ItemCode").value,"N");
		SetValue("ItemName",document.getElementById("ItemName").value,"N");
		SetValue("DRglCode",document.getElementById("DRglCode").value,"N");
		SetValue("CRglCode",document.getElementById("CRglCode").value,"N");
		SetValue("ItemEntyDate",document.getElementById("ItemEntyDate").value,"N");
		SetValue("itemremarks",document.getElementById("itemremarks").value,"N");						
		SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
		SetValue("Method","AddItemDetailsParam","L");		
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
	$("#ItemEntyDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>

</head>
<body onload="initValues()">
	<center>
	
	<h1 style="color:white;">Bangladesh House Building Finance Corporation</h1>
		<h3  style="color:white;"> General Accounting System </h3>
		
		<div class="container">
		   		
		      <fieldset>
		      <legend>Item Identifier</legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="BranchCode" name="BranchCode" read only>
					</div>
				</div>
		      
		      
		       <div class="row">
					<div class="col-15">
						<label for="ItemCode">Item Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="ItemCode" name="ItemCode" onkeypress="ItemCodeValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="ItemName">Item Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="ItemName" name="ItemName" onkeypress="ItemNameValidation(event)" >
					</div>										
				 </div>		      				
				</fieldset>		
				<fieldset>	
				<legend>GL Mapping</legend>
															
				
				<div class="row">	
					<div class="col-15">
						<label for="DRglCode">Debit GL Code</label>
					</div>
					<div class="col-75">
						<input type="text" id="DRglCode" name="DRglCode" onkeypress="DebitGLValidation(event)">
					</div>									  
														
				</div>
				
				<br>
				
				<div class="row">
						<div class="col-15">
						<label for="CRglCode">Credit GL Code</label>
					</div>
					<div class="col-75">
						<input type="text" id="CRglCode" name="CRglCode" onkeypress="CreditGLValidation(event)">
					</div>							
				</div>	

			<br>
												
				<div class="row">
					<div class="col-15">
						<label for="ItemEntyDate">Item Entry Date</label>
					</div>
					<div class="col-20">
						<input  type="text" id="ItemEntyDate" value="" onkeypress="ItemDateValidation(event)" >
					</div>										
				</div>	

			<div class="row">	
					
				  <div class="col-15">
						<label for="itemremarks">Remarks for Item</label>
					</div>
					<div class="col-80">
						<input type="text" id="itemremarks" name="itemremarks" onkeypress="RemarksValidation(event)">
					</div>
														
				</div>
				</fieldset>	
			<div class="row">
				
					<div class="col-15">					
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
						
					</div>
					<div class="col-75">
						<input type="submit" id="AccountOpenId" value="Submit" onclick="ItemCreationFunction(event)" > 
					</div>									
			   </div>			
					
																						
			</div>
	</center>
</body>
</html>