<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get the product ID to remove from the cart
    String productIdToRemove = request.getParameter("id");

    // Get the current list of products in the cart from the session
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    // Check if the cart is not empty
    if (productList != null) {
        // Remove the product with the specified ID from the cart
        productList.remove(productIdToRemove);

        // Update the cart in the session
        session.setAttribute("productList", productList);
    }

    // Redirect back to the shopping cart page
    response.sendRedirect("showcart.jsp");
%>
