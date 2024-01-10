<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
%>

<div class="container">
    <h3>Customer Profile</h3>

    <%
        String sql = "";
        String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";
        try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();){
         
           
            stmt.execute("USE orders");
            sql = "select customerId, firstName, lastName,email,phonenum, address,city,state,postalcode,country,userid from customer where userid = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userName);
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
    %>

    <table class="customer-table">
        <tr>
            <th>ID</th>
            <td><%= rst.getInt(1) %></td>
        </tr>
        <tr>
            <th>First Name</th>
            <td><%= rst.getString(2) %></td>
        </tr>
        <tr>
            <th>Last Name</th>
            <td><%= rst.getString(3) %></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><%= rst.getString(4) %></td>
        </tr>
        <tr>
            <th>Phone</th>
            <td><%= rst.getString(5) %></td>
        </tr>
        <!-- Add other rows as needed -->
    </table>

    <%
        }
    } catch (SQLException ex) {
        out.println(ex);
    }
    // Make sure to close connection
    %>

</div>

</body>
</html>
