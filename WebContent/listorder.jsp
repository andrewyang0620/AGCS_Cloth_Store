	<%@ page import="java.sql.*" %>
	<%@ page import="java.text.NumberFormat" %>
	<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
	<!DOCTYPE html>
	<html>
<head>
	<title>Your order list</title>
	<link rel="stylesheet" href="styles.css">
</head>
	<body>
	<%@ include file="header.jsp" %>

	<h1>Order List</h1>

	<%
	//Note: Forces loading of SQL Server driver
	
	String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";
try
{	// Load driver class
	Class.forName("com.mysql.cj.jdbc.Driver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
	
	



	// Useful code for formatting currency values:
	// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	// out.println(currFormat.format(5.0);  // Prints $5.00

	// Make connection

	try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();)
	{	// Load driver class
		
		ResultSet rst = stmt.executeQuery("SELECT O.orderId, C.customerId, C.firstName, C.lastName, O.totalAmount, O.orderDate FROM customer C join ordersummary O on C.customerId = O.customerId");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		PreparedStatement pst = con.prepareStatement("select productId, quantity, price from orderproduct where orderId = ?");
	
		out.println("<table border=\"1\"><tbody><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
		while (rst.next())
			{
        // Print out the order summary information
       out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getDate(6)+"</td>"+ "<td>"+ rst.getString(2) +"</td>"+"<td>"+rst.getString(4) + " " + rst.getString(3)+"</td>" + "<td>"+ currFormat.format(rst.getDouble(5))+"</td></tr>");
			out.println("<tr align = \"right\"><td colspan= \"4\"><table border=\"1\"><tbody><tr><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
			pst.setString(1, rst.getString(1));
			ResultSet result = pst.executeQuery();
			while(result.next())
			out.println("<tr><td>"+result.getString(1)+"</td>"+"<td>"+result.getString(2)+"</td>"+ "<td>"+ currFormat.format(result.getDouble(3)) + "</td></tr>");
			out.println("</tr></td></table>");

			}
	}


	//try{

	//}catch(SQLException ex)

	// Write query to retrieve all order summary records

	// For each order in the ResultSet

		// Print out the order summary information
		// Write a query to retrieve the products in the order
		//   - Use a PreparedStatement as will repeat this query many times
		// For each product in the order
			// Write out product information 

	// Close connection
	%>

	</body>
	</html>

