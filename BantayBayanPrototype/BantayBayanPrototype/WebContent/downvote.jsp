<!-- This .jsp file gets input from viewConcern.jsp and process it with the database -->
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.ServletContext"%>

<%@ page import="com.bbp.*"%>



<% 
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	String addResult = null;
	
	int getCommentID = Integer.valueOf(request.getParameter("commentID"));
	int getConcernID = Integer.valueOf(request.getParameter("concernID"));
	
	
		
	try{
		// 1. Register new jdbc driver
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 2. Get a connection to database
		Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		// 3. Create a prepared statement (Increment downvotes)
		PreparedStatement ps = myConn.prepareStatement("UPDATE tblComments SET downvotes=downvotes+1 WHERE commentID=?;");
		ps.setInt(1, getCommentID);
		// 4. Execute Update
		ps.executeUpdate(); 
		
		// 5. Redirect to viewing the concern
		response.sendRedirect("viewConcern.jsp?concernID=" + getConcernID);
	}
	catch (Exception exc){
		exc.printStackTrace();
		response.sendRedirect("errorPage.jsp");
	}
%>
