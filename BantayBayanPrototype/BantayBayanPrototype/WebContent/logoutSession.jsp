<!-- This .jsp file logs out the user who's currently logged in -->
<%@ page import="java.sql.*"%>
<%@ page import="com.bbp.*" %>

<%
	try{
		request.getSession().invalidate();
		response.sendRedirect("index.jsp");
	}
	catch (Exception exc){
		exc.printStackTrace();
		response.sendRedirect("errorPage.jsp");
	}
	
%>

