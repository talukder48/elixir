<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<script src="https://code.jquery.com/jquery-1.12.3.min.js"></script>

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

function ValidateUsername(){
	if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("user",document.getElementById("userName").value);
		SetValue("Class","LoginValidation");
		SetValue("Method","UserIdValidation");
		xmlFinal();
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					document.getElementById("password").focus();
				}
			}
		};
		xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
		xhttp.send();
	}
}


function ValidatePasword(){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("password").focus();
		clear();
		SetValue("user",document.getElementById("userName").value);
		SetValue("password",document.getElementById("password").value);
		SetValue("Class","LoginValidation");
		SetValue("Method","UserIdValidation");
		xmlFinal();
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					document.getElementById("logIn").focus();
				}
			}
		};
		xhttp.open("POST", "CommomAjaxCallHandler?" + DataMap, true);
		xhttp.send();				
	}
	
}
function ValidateLogIn(){

		clear();
		SetValue("user",document.getElementById("userName").value);
		SetValue("password",document.getElementById("password").value);
		SetValue("Class","LoginValidation");
		SetValue("Method","UserIdValidation");
		xmlFinal();
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					if (obj.USER_ROLE == "A") {
						//alert(window.location.href);
						
						//window.location.href = "AIS/UserMenu";
					}
				}
			}
		};
		xhttp.open("POST", "AjaxLoginHandler?" + DataMap, true);
		xhttp.send();				
	
	
}


</script>
</head>
<body>
<div align="center">
	<h1 style="color:green;">${Title}</h1>
	<h2>Please Login Here !!</h2>
	<P>The time on the server is ${serverTime}.</p>
	
	
	<P  style="color:red;"> ${Error}</p>
	<form action="UserHomePage.do" method ="post" onkeydown="return event.key != 'Enter';">
		<input id="userName" type="text" name="userName" onkeydown="ValidateUsername()"><br> 
		<input id="password" type="password" name="password" onkeydown="ValidatePasword()"><br> <br>
		<input id="logIn"	 type="submit" value="Login" >
	
    </form>
	</div>
</body>
</html>