<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<title>Registration</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
		String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";
	try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();){
		
		
		stmt.execute("USE orders");
		// TODO: Get order id
		String orderId = request.getParameter("orderId");
		String desc = request.getParameter("shipmentDesc");
		
		// TODO: Check if valid order id
		int id = -1;
		try{
			id = Integer.parseInt(orderId);
		}
		catch(Exception e){
			out.println("<h1 style='color:red;'>Invalid order ID: " + orderId + "</h1>");
			out.println("<h1><a href='listShipment.jsp'><button style='float:center'>Retry</button></a></h1>");
		}
		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		
		// TODO: Retrieve all items in order with given id
		String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		ResultSet rs = pstmt.executeQuery();
		String sql_insert = "INSERT INTO shipment (shipmentDate, warehouseId, shipmentDesc) VALUES (?, 1, ?)";
		pstmt = con.prepareStatement(sql_insert);
		boolean success = false;
		int productId = -1;
		int productQty = -1;
		out.println("<h1>PROCESSING SHIPMENT FOR ORDER ID: "+orderId+"</h1>");
		while(rs.next()){
			productId = rs.getInt("productId");
			productQty = rs.getInt("quantity");
			// TODO: Create a new shipment record.
			pstmt = con.prepareStatement(sql_insert, Statement.RETURN_GENERATED_KEYS);
			java.util.Date utilDate = new java.util.Date();
    		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			pstmt.setDate(1, sqlDate);
			pstmt.setString(2, desc);
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int shipmentId = keys.getInt(1);
			// TODO: For each item verify sufficient quantity available in warehouse.
			sql = "SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = 1";
			PreparedStatement pstmt1 = con.prepareStatement(sql);
			pstmt1.setInt(1, productId);
			ResultSet rs1 = pstmt1.executeQuery();
			int inven_qty = 0;
			if(rs1.next())
				inven_qty = rs1.getInt("quantity");
			
			if(inven_qty >= productQty){
				int newInvenQty = inven_qty - productQty;
				pstmt = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = 1");
				pstmt.setInt(1, newInvenQty);
				pstmt.setInt(2, productId);
				pstmt.executeUpdate();
				// print out productinventory summary
				out.println("<h1>Ordered product: "+productId + "<br>Quantity: " + productQty);
				ResultSet qtyRs = stmt.executeQuery("SELECT quantity FROM productinventory WHERE productId = "+productId+" AND warehouseId = 1");
				qtyRs.next();
				int newQty = qtyRs.getInt("quantity");
				out.print("<br>Old inventory: "+ inven_qty);
				out.println("<span class='tab'> New inventory: " + newQty + "</span></p>");
				success = true;
			}
			else{
				// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
				success = false;
				break;
			}
		}
		if(success){
			con.commit();
			out.println("<h1>Shipment successfully processed.</h1>");
			out.println("<h1><a href='listShipment.jsp'><button style='float:center'>Back</button></a></h1>");
		}
		else{
			con.rollback();
			out.println("<h1 >Shipment not done.Insufficient inventory for product ID: "+productId+"</h1>");
		
		}
		// TODO: Auto-commit should be turned back on
		con.setAutoCommit(true);
	}
	catch(SQLException e){
		out.print("<h1 style='color:red'>"+e+"</h1>");
		con.rollback();
	}
	finally
	{
		try
		{
			if (con != null)
				con.close();
		}
		catch (SQLException e)
		{
			out.print("<h1 style='color:red'>"+e+"</h1>");
		}
	} 




	
	

	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
