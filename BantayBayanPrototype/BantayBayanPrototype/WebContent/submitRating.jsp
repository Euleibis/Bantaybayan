<!-- This .jsp file gets the input from viewConcern.jsp and process it with the database -->
<%@page import="java.sql.*"%>
<%@ page import="com.bbp.*" %>

<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%!
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
%>

<%
String sqlurl = "jdbc:mysql://localhost:3306/bbp";
String sqluser = "root";
String sqlpass = "33sqltestpass33";	


	try{
		DriverManager.registerDriver(new com.mysql.jdbc.Driver ());
		//****INSERTING
		// 1. Get a connection to database
		Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		
		PreparedStatement ps = myConn.prepareStatement("UPDATE tblConcerns SET concernStatus='Resolved', rating=? WHERE concernID=?");
		
		ps.setString(1, request.getParameter("pRating"));
		ps.setString(2, request.getParameter("pConcernID"));
		
		ps.executeUpdate();
		
		response.sendRedirect("viewConcern.jsp?concernID=" + request.getParameter("pConcernID"));
	}
	catch (Exception exc){
		exc.printStackTrace();
		response.sendRedirect("errorPage.jsp");
	}
	
%>

