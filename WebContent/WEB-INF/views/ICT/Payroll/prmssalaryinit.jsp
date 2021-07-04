<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">
var DataMap="";
function SetValue(key,value){
	var Node = key+"*"+value;
	if(DataMap!=""){
		DataMap=DataMap+"$"+Node;
	}
	else{
		DataMap="data="+Node;
	}
}
function clear(){
	DataMap="";
}

function initValues(){
	document.getElementById("User_Id").value= "<%= session.getAttribute("User_Id")%>";
	 var today = new Date();
	 document.getElementById("asonDate").value =('0' + today.getDate()).slice(-2)  + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + today.getFullYear();
	 document.getElementById("init").focus();
}

	function InitProcess(event) {
		var c = confirm("Are you sure ?");
		if (c == true) {
		 	clear();
		    SetValue("User_Id",document.getElementById("User_Id").value);		    
			SetValue("Class","SuperOperation");
			SetValue("Method","InitProcess");
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var obj = JSON.parse(this.responseText);
					if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
					} else {
						alert(obj.SUCCESS);
						initValues();
					}
				}
			};
			xhttp.open("POST", "HTTPValidator?" + DataMap, true);
			xhttp.send();
		} else {
			document.getElementById("init").focus();
		}
	}
</script>

<style>
body {
  /* background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
  
  background-color: #cccccc; 
}

{
box-sizing
:
 
border-box
;


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
	background-color: #85adad;
	padding: 20px;
}

.col-25 {
	float: left;
	width: 40%;
	margin-top: 6px;
}

.col-15 {
	float: left;
	width: 20%;
	margin-top: 6px;
}

.col-35 {
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

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}
</style>

</head>
<body onload="initValues()">
	
	<center>
	<br><br><br><br>
		<div class="alert">
			<span class="closebtn"
				onclick="this.parentElement.style.display='none';">&times;</span> <strong>Attention!</strong>
			Complete Initialization within 5th day of the month!
		</div>
		<div class="container">
			<div class="row">
				<div class="col-25">
					<label for="User_Id">User ID</label>
				</div>
				<div class="col-75">
					<input type="text" id="User_Id" name="User_Id" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col-25">
					<label for="asonDate">Date</label>
				</div>
				<div class="col-75">
					<input type="text" id="asonDate" name="asonDate" readonly>
				</div>
			</div>

			<div class="col-75"></div>
			<div class="row">
				<input type="submit" id="init" value="Execute!"
					onclick="InitProcess(event)">
			</div>
		</div>
	</center>

</body>
</html>