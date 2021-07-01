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
	text-align: left;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
	text-align: left;
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
.colt-20 {
	float: left;
	width: 75%;
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

function initValues(){
	loadgitem();
	document.getElementById("entryDate").value= "";
	document.getElementById("AccRemarks").value= "";	
	document.getElementById("BranchCode").value="<%= session.getAttribute("BranchCode")%>";
	document.getElementById("GLName").focus();
}

function loadgitem(){
	clear();	
	SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
	SetValue("Method", "FetchGLListBranch","L");	
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
				var item_srting=obj.GL_LIST;					
				var select = document.getElementById("glcode");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");		
					 
				    var item_keyValue = item_arrayList[i].split(':');
				    var option = document.createElement("option");
				    option.value=item_keyValue[0] ;
				    option.text=item_keyValue[1]+":"+item_keyValue[0];	
				    select.add(option, null);				   				   
				 }
			}				
	}); 		
}

function GLnameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("entryDate").focus();
	}
}
function GLEntyDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("AccRemarks").focus();
	}
}

function RemarksValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("AccountOpenId").focus();
	}
}

function BranchGLOpening(event)
{
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		    clear();		    
		    if(document.getElementById("AccRemarks").value==""){
		    	document.getElementById("AccRemarks").value="N/A";
		    }		    
		    var User_Id ="<%= session.getAttribute("User_Id")%>";
		    var usr_brn ="<%= session.getAttribute("BranchCode")%>";			    
		    
		    SetValue("loggedBranch",usr_brn,"N");
		    SetValue("User_Id",User_Id,"N");
		    SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		    SetValue("glcode",document.getElementById("glcode").value,"N");
		    SetValue("GLName",document.getElementById("GLName").value,"N");
		    SetValue("AccRemarks",document.getElementById("AccRemarks").value,"N");
		    SetValue("entryDate",document.getElementById("entryDate").value,"N");
			SetValue("Class", "elixir.validator.pps.AccontingParameterSetup","N");
			SetValue("Method","BranchGLOpening","L");
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
		  document.getElementById("AccountOpenId").focus();
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
						<label for="">GL Head</label>
					</div>
					<div class="col-25">
					<select id="glcode" name="glcode">						
					</select>
				</div>
				</div>
				
				<div class="row">
					<div class="col-15">
						<label for="GLName">GL Name</label>
					</div>
					<div class="col-15">
						<input type="text" id="GLName" name="GLName" onkeypress="GLnameValidation(event)">
					</div>
				</div>
				
										
				<div class="row">
					<div class="col-15">
						<label for="entryDate">Opening Date</label>
					</div>
					<div class="col-15">
						<input type="text" id="entryDate" name="entryDate" onkeypress="GLEntyDateValidation(event)">
					</div>
				</div>
								
				<div class="row">						
				  <div class="col-15">
						<label for="AccRemarks">Remarks</label>
					</div>
					<div class="col-80">
						<input type="text" id="AccRemarks" name="AccRemarks" onkeypress="RemarksValidation(event)">
					</div>														
				</div>
				
				<div class="row">
				
					<div class="col-15">
					</div>
					<div class="col-75">
						<input type="submit" id="AccountOpenId" value="Submit" onclick="BranchGLOpening(event)" > 
					</div>									
			   </div>																					
	</div>
	</center>
</body>
</html>