<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Product Info</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        table th {
            background-color: #f2f2f2;
        }

        img {
            max-width: 100%;
            height: auto;
            margin-top: 20px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-54 {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-54:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container">

    <%
        String productId = request.getParameter("id");
        int id = 0;
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        try {
            // Load driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (java.lang.ClassNotFoundException e) {
            out.println("ClassNotFoundException: " + e);
        }

    String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";

        try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();) {
            
           
            stmt.execute("USE orders");
            String sql = "select productId, productPrice, productName, productImageURL, productImage,productDesc from product where productId = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            id = Integer.parseInt(productId);
            pstmt.setInt(1, id);
            ResultSet rst = pstmt.executeQuery();

            while (rst.next()) {
    %>

    <h1><%= rst.getString(3) %></h1>

    <%
                String aurl = rst.getString(4);
                if (aurl != null) {
    %>
    <img src="<%= aurl %>" alt="<%= rst.getString(3) %>">

    <%
                }
    %>

    <table>
        <tr>
            <th>Id:</th>
            <td><%= rst.getInt(1) %></td>
        </tr>
        <tr>
            <th>Price:</th>
            <td><%= currFormat.format(rst.getDouble(2)) %></td>
        </tr>
        <tr>
            <th>Description:</th>
            <td><%= rst.getString(6) %></td>
        </tr>
    </table>

    <div class="button-container">
        <a href="addcart.jsp?id=<%= rst.getInt(1) %>&name=<%= rst.getString(3) %>&price=<%= rst.getString(2) %>"
           class="button-54" role="button">Add To Cart</a>
    </div>
	


    <%
            }
        } catch (SQLException ex) {
            out.println(ex);
        }
        // TODO: If there is a productImageURL, display using IMG tag
        // TODO: Retrieve any image stored directly in the database. Note: Call displayImage.jsp with the product id as a parameter.
        // TODO: Add links to Add to Cart and Continue Shopping
    %>

    <div class="button-container">
        <a href="listprod.jsp" class="button-54" role="button">Continue Shopping</a>
    </div>
	<div class="button-container">
        <a href="review.jsp" class="button-54" role="button">Rate the product</a>
    </div>


</div>

	
</body>
</html>
