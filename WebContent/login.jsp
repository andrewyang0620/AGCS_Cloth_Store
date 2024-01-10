<!DOCTYPE html>
<html>
	<style>
		.button-54 {
                font-family: "Open Sans", sans-serif;
                font-size: 16px;
                letter-spacing: 2px;
                text-decoration: none;
                text-transform: uppercase;
                color: #000;
                cursor: pointer;
                border: 3px solid;
                padding: 0.25em 0.5em;
                box-shadow: 1px 1px 0px 0px, 2px 2px 0px 0px, 3px 3px 0px 0px, 4px 4px 0px 0px, 5px 5px 0px 0px;
                position: relative;
                user-select: none;
                -webkit-user-select: none;
                touch-action: manipulation;
                        }

                        .button-54:active {
                        box-shadow: 0px 0px 0px 0px;
                        top: 5px;
                        left: 5px;
                        }

                        @media (min-width: 768px) {
                        .button-54 {
                        padding: 0.25em 0.75em;
                        }
                        }

                        input[type=text] {
                        border: 2px solid black;
                        border-radius: 4px;
                        }
                        input[type=password] {
                        border: 2px solid black;
                        border-radius: 4px;
                        }   
                        p{
                                color: red;
                        }
	</style>
<head>
	<title>Login in</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null) {
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
        out.println("<p>"+"Please type a username that composed with letters"+"</p>");
}
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>
<h2 align = "center"><a href="index.jsp" class = "button-54" role="button">Return to Main Page</a></h2>
</body>
</html>

