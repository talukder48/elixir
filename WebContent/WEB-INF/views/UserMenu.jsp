<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>

<style type="">

body {
	margin: 0;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background: linear-gradient(to right bottom, gold, chocolate);
}

nav ul {
	list-style-type: none;
	padding: 0;
}

nav ul li {
	font-size: 40px;
	font-family: sans-serif;
	background-color: white;
	border: 2px solid black;
	letter-spacing: 0.1em;
	width: 5em;
	height: 1.5em;
	line-height: 1.5em;
	position: relative;
	overflow: hidden;
	margin: 0.5em;
	cursor: pointer;
}

nav ul li span {
	color: white;
	mix-blend-mode: difference;
}

nav ul li::before {
	content: '';
	position: absolute;
	width: 1.5em;
	height: inherit;
	background-color: black;
	border-radius: 50%;
	top: 0;
	left: -0.75em;
	transition: 0.5s ease-out;
}

nav ul li:hover::before {
	transform: scale(7);
}


</style>

</head>



<body >

<f:view>
<div align="center">
<h1>Bangladesh House building Finance Corporation</h1>
</div>

<nav>
  <ul>
    <li><span>Home</span></li>
    <li><span>Products</span></li>
    <li><span>Services</span></li>
    <li><span>Contact</span></li>
  </ul>
</nav>


</f:view>
</body>
</html>