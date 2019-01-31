<!-- This .jsp file gets the input from login form and process it with the database -->
<%@page import="java.sql.*"%>
<%@page import="com.bbp.*" %>

<% 
	Login loginObj = new Login();

	String gUsername = 	String.valueOf(request.getParameter("username"));
	String gPassword = String.valueOf(request.getParameter("password"));
	String gAccountType = null;
	String gTitle = null;
	
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";

	if (loginObj.isLoginValidate(gUsername, gPassword)){
		
		HttpSession httpSessionObj = request.getSession(true);
		session.setAttribute("sessionUsername", request.getParameter("username"));
		session.setAttribute("sessionPassword", request.getParameter("password"));
		
		try{
			// 1. Register new jdbc driver
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			// 2. Get a connection to database
			Connection con = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			// 3. Create a prepared statement (Select account that matches the user and pass input)
			PreparedStatement ps = con.prepareStatement("select * from tblAccounts where username=? and password=?");
			ps.setString(1, gUsername);
			ps.setString(2, gPassword);
			// 4. Execute and pass it to a result set
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				gAccountType = rs.getString("accounttype");
				gTitle = rs.getString("title");
			}
			
			// 
			session.setAttribute("sessionAccountType", gAccountType);
			session.setAttribute("sessionTitle", gTitle);
			
			response.sendRedirect("index.jsp");
		}
		catch(Exception exc){
			exc.printStackTrace();
		}
		
	}
	else{
		RequestDispatcher dispatcher = request.getRequestDispatcher("loginForm.jsp");
		
		request.setAttribute("pLoginIsValid", "2");
		
		request.setAttribute("pTestUsername", request.getParameter("username"));
		request.setAttribute("pTestPassword", request.getParameter("password"));
		
		
		dispatcher.forward(request, response);
		
	}



%>














