<%@ page import="java.io.IOException" %>
<%@ page import="java.util.stream.IntStream" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Product Information</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function submitRating() {
            var rating = document.querySelector('input[name="rating"]:checked').value;
            alert('You rated ' + rating + ' star(s)');
            // TODO: Send this rating value to the server for processing
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <h3>Rate This Product From 1-5: </h3>
    <form id="ratingForm">
        <% int numberOfStars = 5; %>
        <% for (int i = 1; i <= numberOfStars; i++) { %>
            <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>" class="star">
            <label for="star<%= i %>"><%= i %> Star</label><br>
        <% } %>
        <button type="button" onclick="submitRating()">Submit Rating</button>
    </form>

    <button type="button" onclick="history.back()">Back To Product</button>
</body>
</html>