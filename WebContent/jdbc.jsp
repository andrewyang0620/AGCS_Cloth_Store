<!--
A JSP file that encapsulates database connections.

Public methods:
- public void getConnection() throws SQLException
- public void closeConnection() throws SQLException  
-->

<%@ page import="java.sql.*"%>

<%!
	// User id, password, and server information
	//private String url = "jdbc:sqlserver://cosc304_sqlserver:1433;TrustServerCertificate=True";
	private String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	private String uid = "admin";
	private String pw = "123456zxc";
	
	// Do not modify this url
	private String urlForLoadData = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	
	// Connection
	private Connection con = null;
%>

<%!
	public void getConnection() throws SQLException 
	{
		try
		{	// Load driver class
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			throw new SQLException("ClassNotFoundException: " +e);
		}
	
		con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();
	}
   
	public void closeConnection() 
	{
		try {
			if (con != null)
				con.close();
			con = null;
		}
		catch (Exception e)
		{ }
	}
%>
