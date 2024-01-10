<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;
	String url = "jdbc:mysql://database-1.cmrusphijoyo.us-east-2.rds.amazonaws.com:3306/orders?useSSL=true&trustServerCertificate=true";
	String uid = "admin";	
	String pw = "123456zxc";
		try(Connection con = DriverManager.getConnection(url, uid, pw);
	       Statement stmt = con.createStatement();)
		{
		
			
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			
			stmt.execute("USE orders");
			String sql = "select userid,password from customer"; 
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
			if(username.equals(rst.getString(1)) && password.equals(rst.getString(2))) { 
			retStr = username;	
			}
			}
			


		} 
		catch (SQLException ex) {
			out.println(ex);

	
		}
		finally
		{
			try {
        if (con != null && !con.isClosed()) {
            con.close();
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately
    }
			
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
        
		return retStr;
	}
%>

