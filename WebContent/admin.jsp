<!DOCTYPE html>
<html>
<head>
	<title>Administrator</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";

try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();)
{	
    
		stmt.execute("USE orders");
	ResultSet rst = con.createStatement().executeQuery(sql);
	
			out.println("<h1>Administrator Sales Report by Day:</h1>");
			out.println("<table>");
			out.println("<tr><td class='tableheader' style='border:1px solid #7E8193'>Order Date</td><td class='tableheader' style='border:1px solid #7E8193'>Total Order Amount</td>");	

			while (rst.next())
			{
				out.println("<tr><td style='border:1px solid #7E8193'>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td style='border:1px solid #7E8193'>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
			}
			out.println("</table>");
		out.println("</tr></td>");
	out.println("</table>");
}
catch (SQLException e)
{ 	
    out.print("<h3 style='color:red'>"+e+"</h3>");
}
finally
{	
	closeConnection();	
}
%>
</body>
</html>