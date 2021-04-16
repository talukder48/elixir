<!-- ***************************************************************************
|*			Project Name: 	Payroll Management System						  *|
|*			Developer	: 	1. Md. Rubel Talukder							  *|
|*					   		2. Mosharraf Hossain Talukder					  *|
|*					 		------------------------------					  *|
|*					      	ICT Department, HO BHBFC.						  *|
|*		    Supervised By	: 	Md Rokunuzzaman								  *|
|*																			  *|
*****************************************************************************-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="../../Media/bhbfc_icon.ico"> 
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bangladesh House Building Finance Corporation</title>

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
function InitValues(){
	//Redirect();
	
	alert(top.location);
}
function LogOut()
{
	clear();
	SetValue("Class","LoginValidation");
	SetValue("Method","LogOut");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			top.location = self.location.href = "../../";
		}
	};
	xhttp.open("POST", "HTTPValidator?" + DataMap, true);
	xhttp.send();
		
}
function Redirect(){
	var userRole = "<%= session.getAttribute("USER_ROLE")%>";
	if(userRole=="null"){
		top.location = self.location.href = "../../../";
	}
	else if(userRole!="S"){
		LogOut();	
	}
}
</script>
<style>
.header {
    position: relative;
    font-family: sans-serif;
    font-size: 12px;
}
.header > img {
    width: 100%;
}
.rectangle {  
    background-color: #85adad;
	overflow: auto;
	align: center;
	height: 100;
	width: 100%;
}
.topnav {
	overflow: hidden;
	background-color: #00b33c;
	overflow: auto;
	align: center;
	width: 100%;
}
.topnav a {
	float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 15px;
	width: 15%;
}
.topnav a:hover {
	background-color: #196619;
	color: white;
}
.topnav a.active {
	background-color: #196619;
	color: white;
}
.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: #196619;
	color: coral;
	height: 40px;
}
.dropdown {
  float: left;
  overflow: hidden;
}
.dropdown .dropbtn {
  font-size: 16px;  
  border: none;
  outline: none;
  color: white;
  padding: 18px 16px;
  background-color: inherit;
  font-family: inherit;
}
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #00b33c;
  min-width: 140px;
  z-index: 1;
}
.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  min-width: 89px;
}
.dropdown-content a:hover {
  background-color: #196619;
  height: 20px;
}
.dropdown:hover .dropdown-content {
  display: block;
}
</style>
</head>
<body onload="InitValues()">
	<center>
	<div class="header">
    <img src="../../Media/Header.png" alt=""/>
    
</div>
		<div class="topnav" style="align: center">
		
			<div class="dropdown">
				<button class="dropbtn">User Related <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">
					<a href="CreateUserByModule.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> &nbsp;  User Creation</a>
					<a href="ResetPassword.jsp" target="contents_1"> <i class="fa fa-user-plus"></i>&nbsp; Password Reset</a> 
				</div>
			</div>
		
								
			<div class="dropdown">
				<button class="dropbtn">PRMS -All <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">				
					<a href="Payroll/BackupPrms.jsp" target="contents_1"><i class="fa fa-cog fa-spin" ></i> &nbsp;  Data-Backup</a>				
					<a href="Payroll/Initialization.jsp" target="contents_1"><i class="fa fa-cog fa-spin" ></i> Salary Initialization</a>
					<a href="Payroll/Process.jsp" target="contents_1"> <i class="fa fa-cog fa-spin"></i>&nbsp; Salary Process</a> 
					<a href="Payroll/FractionProcess.jsp" target="contents_1"> <i class="fa fa-cog fa-spin"></i>&nbsp; Fraction Salary Process</a> 
					<a href="Payroll/BonusProcess.jsp" target="contents_1"><i class="fa fa-cogs fa-spin" style="font-size: 24px"></i> Bonus Process</a>
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">ELMS -All <i class="fa fa-caret-down"></i> </button>
				<div class="dropdown-content">
					<a href="AccrualProcess.jsp" target="contents_1"> <i class="fa fa-cog fa-spin"></i>&nbsp; Accrual Process</a> 
					<a href="InsertDataAuto.jsp" target="contents_1"><i class="fa fa-cogs fa-spin" style="font-size: 24px"></i> Data-Migration</a>
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">PENSION -All <i class="fa fa-caret-down"></i> </button>
				<div class="dropdown-content">
				    <a href="Pension/PensionBackup.jsp" target="contents_1"><i class="fa fa-cog fa-spin" ></i>Pension Data Backup</a>
					<a href="Pension/InitPension.jsp" target="contents_1"><i class="fa fa-cog fa-spin" ></i>Pension Initialization</a>
					<a href="Pension/PensionProcess.jsp" target="contents_1"> <i class="fa fa-cog fa-spin"></i>Pension Process</a> 
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">General Accounts <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">
				    <a href="AIS/BranchSetup.jsp" target="contents_1"><i class="fa fa-cog fa-spin"></i>Branch Ledger(Setup)</a>
				     <a href="AIS/ZeroBalanceOpening.jsp" target="contents_1"><i class="fa fa-cog fa-spin"></i>Zero Balance(Setup)</a>
				    <a href="AIS/BranchInit.jsp" target="contents_1"><i class="fa fa-cog fa-spin"></i>Branch Opening(Setup)</a>
				    <a href="AIS/DayBeginProcess.jsp" target="contents_1"><i class="fa fa-cog fa-spin"></i>Day Begin</a> 
					<a href="AIS/GLSetUp.jsp" target="contents_1"><i class="fa fa-user-plus"></i>GL SetUp</a>
					<a href="AIS/ItemsCreation.jsp" target="contents_1"><i class="fa fa-user-plus"></i>Items Setup</a>
					<a href="AIS/UserSetup.jsp" target="contents_1"><i class="fa fa-user-plus"></i>User SetUp</a>					
										 					  					
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">All Services <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">
				    <a href="MailService.jsp" target="contents_1"><i class="fa fa-cogs fa-spin" style="font-size: 24px"></i> Email </a>
				    <a href="SMSService.jsp" target="contents_1"><i class="fa fa-cogs fa-spin" style="font-size: 24px"></i> SMS </a>
				   								 					  					
				</div>
			</div>
						
			
			<a href="DataSearch.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 24px"></i> Search </a>
		</div>
		<div>
			<iframe height="800px" width="84.4%" src="../Welcome.jsp" name="contents_1" frameBorder="0" style="border: 1px solid green;"> </iframe>
			<iframe height="800px" width="15%" src="../Aside.jsp" name="contents_2" style="border: 1px solid green;"></iframe>
		</div>
		
	</center>
	<footer>
	<div style="text-align: center;">
            <p>Copyright &#xA9; 2019.
              <strong>Design & Developed By ICT Department, <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
              All Rights Reserved.</p>              
        </div>
    </footer>
    
</body>
</html>
