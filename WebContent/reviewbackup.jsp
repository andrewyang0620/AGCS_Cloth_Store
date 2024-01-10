<%@ page import="java.io.IOException" %>
<%@ page import="java.util.stream.IntStream" %>

<html lang="en">

<%@ include file="header.jsp" %>

<h3>Rate This Product From 1-5: </h3>

<html>
<head>
    <title>Product Information</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <form>
        <% int numberOfStars = 5; %>
        <% for (int i = 1; i <= numberOfStars; i++) { %>
            <input type="radio" name="rating" value="<%= i %>" class="star">
        <% } %>
    </form>

    <button type="button" name="Back To Product" onclick="history.back()">Back To Product</button>

    <h2 align="center"><a href="listprod.jsp">Back To Shopping</a></h2>
</body>
</html>
