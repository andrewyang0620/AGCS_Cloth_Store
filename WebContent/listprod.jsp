<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>product list</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="header.jsp" %>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
	<p align="left">
		<select size="1" name="categoryName">
		<option>All</option>
		<option>Women Tank Tops & Camis</option>
		<option>Women T-Shirt</option>
		<option>Women Sweatshirts</option>  
		</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> 
</form>

<% // Get product name to search for
String pName = request.getParameter("productName");
String cName = request.getParameter("categoryName");
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

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();){

	stmt.execute("USE orders");
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    String sql = "Select productName,productPrice, productId, categoryName from product P join category C on P.categoryId = C.categoryId";

    boolean hasPro = pName != null && !pName.equals("");

    PreparedStatement psmt = null;
    ResultSet rs = null;

    if(!hasPro ){ // before user enter anyting, we show this. 
		psmt = con.prepareStatement(sql);
		rs = psmt.executeQuery();
		out.println("<h2><font face=\"Times New Roman\">All Products</font></h2>");
		out.println("<font face=\"Times New Roman\" size=\"5\"><table class = \"table\" border = \"1\"><tr><th class= \"col-md-1\"></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			while(rs.next()) {
				out.println("<tr><td class= \"col-md-1\"><a href=\"addcart.jsp?id=" + rs.getInt(3) + "&name=" + rs.getString(1) + "&price=" + rs.getString(2) + "\">Add To Cart&nbsp;</a>" + "</td>"  + "<td><a href = \"product.jsp?id=" + rs.getInt(3) + "\">" + rs.getString(1) + "</a></td>" + "<td>"
					+ rs.getString(4) + "</td><td>" + currFormat.format(rs.getDouble(2)) + "</td></tr>");
			}
			out.println("</table></font>");
    }else{ // once user enter,we show this. 
		out.println("<h2>Products Containing " + "'" + pName + "'" + "</h2>");
        pName = "%" + pName + "%";
		if(cName.equals("All")){
		sql += " WHERE productName LIKE ?";
		psmt = con.prepareStatement(sql);
		}else {
		sql += " WHERE productName LIKE ? AND categoryName = ?";
		psmt = con.prepareStatement(sql);
		psmt.setString(2, cName);
		}
        psmt.setString(1, pName);
        rs = psmt.executeQuery();
		out.print("<table><tr><td></td><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			while(rs.next()) {
				out.println("<tr><td><a href=\"addcart.jsp?id=" + rs.getInt(3) + "&name=" + rs.getString(1) + "&price=" + rs.getString(2) + "\">Add To Cart&nbsp;</a></td><td align=\"center\">" + rs.getString(1) + "</td>" + "<td>"
					+ rs.getString(4) + "</td><td>" + currFormat.format(rs.getDouble(2)) + "</td></tr>");
				}
			out.println("</table>");

			if (con !=null){
				con.close();
			}
	}

    
	// Print out the ResultSet
	//sql = psmt.toString();
	
	// For each product create a link of the form
	// addcart.jsp?id=productId&name=productName&price=productPrice
	
	//out.println("<h2><a href=\"index.jsp\" >Back to Main Page</a></h2>");
	// Close connection



}catch (SQLException ex) {
	out.println(ex);
} 

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>