<!DOCTYPE html>
<html>
<head>
        <title>Home Page</title>
        <link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>

<h1 align="center">Welcome AIGC Store</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>
        
<h2 align="center"><a href="register.jsp">Register</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
/*
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null)
        out.println("<h3 algin =\"center\"> Signed in as: "+userName+"</h3>");
*/        
%>
</body>
</head>