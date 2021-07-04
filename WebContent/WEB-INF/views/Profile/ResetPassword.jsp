<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bangladesh House Building Finance Corporation</title>

<style>

.datepicker
{ 
    width: 26em;
    height: 2.5em;
}

body {
  /* background-image: url('../Media/bg6.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ;  */
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
input[type=password],select,textarea {
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
	width: 50%;
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

var UserId="<%=session.getAttribute("User_Id")%>";
	function initValues() {
		document.getElementById("oldPassword").value="";
		document.getElementById("newPassword").value="";
		document.getElementById("conPassword").value="";
		document.getElementById("oldPassword").focus();
	}
	function OldPasswordValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {			
			if (document.getElementById("oldPassword").value == ""|| document.getElementById("oldPassword").value == null) {
				alert("Password should not be null");
				document.getElementById("oldPassword").focus();
			}else {
					clear();
					SetValue("UserId",UserId,"N");
					SetValue("currPassword",document.getElementById("oldPassword").value,"N");
					SetValue("Class","elixir.validator.pps.LoginValidation","N");
					SetValue("Method","ValidateOldPassword","L");
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
								document.getElementById("newPassword").focus();
							}				
					}); 		
			}								
		}
	}
	function NewPasswordValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			if (document.getElementById("newPassword").value == ""|| document.getElementById("newPassword").value == null) {
				alert("New password can not be null");
				document.getElementById("conPassword").focus();
			} else if (document.getElementById("newPassword").value == document.getElementById("oldPassword").value) {
				alert("New password should not match with current password!");
				document.getElementById("newPassword").focus();
			} else {
				document.getElementById("conPassword").focus();
			}								
		}
	}
	function ConfirmPasswordValidation(event) {
			if (event.keyCode == 13 || event.which == 13) {
			if (document.getElementById("conPassword").value == ""|| document.getElementById("conPassword").value == null) {
				alert("Confirm password can not be null");
				document.getElementById("conPassword").focus();
			} else if (document.getElementById("conPassword").value != document.getElementById("newPassword").value) {
				alert("Password does not match with New password");
				document.getElementById("conPassword").focus();
			} else {
				document.getElementById("submit").focus();
			}					
	    }
	}
	
	function UpdatePassword(event) {
		var c = confirm("Are you sure ?");
		if (c == true) {
			clear();
			SetValue("UserId",UserId,"N");
			SetValue("newPassword",document.getElementById("conPassword").value,"N");
			SetValue("Class","elixir.validator.pps.LoginValidation","N");
			SetValue("Method","ResetPassword","L");
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
			document.getElementById("submit").focus();
		}		
	}
</script>

</head>
<body onload="initValues()">
	<center>
	<h1 style="color:green;">Bangladesh House Building Finance Corporation</h1>
		<h3  style="color:green;"> Password Reset Form </h3>
		<fieldset>
		<div class="container">								
			<div class="row">
				<div class="col-25">
					<label for="oldPassword">Current Password:</label>
				</div>
				<div class="col-75">
					<input type="password" id="oldPassword" name="oldPassword" onkeypress="OldPasswordValidation(event)">
				</div>
			   </div>	
			   <div class="row">
				<div class="col-25">
					<label for="newPassword">New Password:</label>
				</div>
				<div class="col-75">
					<input type="password" id="newPassword" name="newPassword" onkeypress="NewPasswordValidation(event)">
				</div>
				</div>
				<div class="row">
				<div class="col-25">
					<label for="conPassword">Confirm Password:</label>
				</div>
				<div class="col-75">
					<input type="password" id="conPassword" name="conPassword" onkeypress="ConfirmPasswordValidation(event)">
				</div>
			   </div>
				
			<div class="row">
				<div class="col-25">	</div>
					<div class="col-15">					
						<form action="currentUserHomePage.do" method="post">
						<input type="submit" id="submit" value="Home"  > 
						</form>
						
					</div>
					<div class="col-25">
						<input type="submit" id="Submit" value="Submit" onclick="UpdatePassword(event)" > 
					</div>									
			   </div>		
															
			
			
		</div>
		</fieldset>
	</center>
</body>
</html>
