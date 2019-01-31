<!-- This .jsp file gets the input from viewConcern.jsp and process it with the database  -->
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>

<%@page import="javax.servlet.ServletContext"%>

<%@ page import="com.bbp.*"%>
<%!
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
%>


<% 
	boolean goRegister = true;
	
	//passers from viewConcern form
	int commentIDCount = 0;
	int concernID = Integer.valueOf(request.getParameter("pConcernID"));
	String sessionUsername = String.valueOf(session.getAttribute("sessionUsername"));
	String commentText = request.getParameter("pCommentText");
	LocalDate ldObj = LocalDate.now();
	LocalTime ltObj = LocalTime.now();
	int upvotes = 0;
	int downvotes = 0;
	String districtTitle = request.getParameter("pDistrict");
	
	
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	String addResult = null;
	
	// Inserting the comment in the database
	try{
		// 1. Register new driver
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 2. Get a connection to database
		Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		// 3. Create a prepared statement
		PreparedStatement ps = myConn.prepareStatement("SELECT COUNT(commentID) FROM tblComments");
		// 4. Execute and pass it to a result set
		ResultSet rs = ps.executeQuery(); 
		// 5. Pass the values of the result set into an array
		while (rs.next()){
			commentIDCount = rs.getInt("COUNT(commentID)");
		}
		
		// 6. Prepare the PreparedStatement, and set the comment's data
		ps = myConn.prepareStatement("INSERT INTO tblComments VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
		ps.setInt(1, commentIDCount + 1);
		ps.setInt(2, concernID);
		ps.setString(3, sessionUsername);
		ps.setString(4, commentText);
		ps.setString(5, ldObj + " " + ltObj);
		ps.setInt(6, upvotes);
		ps.setInt(7, downvotes);
		if(session.getAttribute("sessionAccountType").equals("D")){
			ps.setString(8, districtTitle);
		}
		else{
			ps.setString(8, null);
		}
		
		// 7. Execute Insert
		ps.executeUpdate();
		
		if(session.getAttribute("sessionAccountType").equals("D")){
			ps.clearBatch();
			ps.clearParameters();
			
			ps = myConn.prepareStatement("UPDATE tblConcerns SET replyStatus='Replied' WHERE concernID=?");
			ps.setInt(1, concernID);
			ps.executeUpdate();
		}
		
		response.sendRedirect("viewConcern.jsp?concernID=" + concernID);
	}
	catch (Exception exc){
		exc.printStackTrace();
		response.sendRedirect("errorPage.jsp");
	}
%>