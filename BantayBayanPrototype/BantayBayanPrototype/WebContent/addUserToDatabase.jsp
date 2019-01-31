<!-- This .jsp file gets the input from sign up form and process it with the database -->
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="com.bbp.*"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>


<% 
	boolean goRegister = true;
	
	//passers from sign-up form
	int accountID = 0;
	LocalDate ldObj = LocalDate.now();
	LocalTime ltObj = LocalTime.now();
	String accountType = "C";
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmpassword");
	String email = request.getParameter("email");
	
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	String addResult = null;
	
	
	
	// Field Validation
	regChecker rc = new regChecker();
	
	// username
	//	if invalid username
	if (rc.isBlank(username) || rc.hasWhiteSpaces(username) || rc.hasMultipleWhiteSpaces(username) || !rc.hasMaxCharacters(username, 12)){
		request.setAttribute("pUsernameIsValid", "2");
		
		goRegister = false;
	}
	else{
		request.setAttribute("pUsernameIsValid", "1");
		request.setAttribute("pUsernameAutofill", username);
	}
	
	
	//password
	if (rc.isBlank(password) || !rc.hasMinCharacters(password, 6) ){
		request.setAttribute("pPasswordIsValid", "2");
	
		goRegister = false;
	}
	else{
		request.setAttribute("pPasswordIsValid", "1");
	}
	
	// confirm match
	if (rc.isEqual(password, confirmPassword)){
		request.setAttribute("pConfirmPasswordIsValid", "1");
	}
	else{
		request.setAttribute("pConfirmPasswordIsValid", "2");
		
		goRegister = false;
	}
	
	// is valid email
	if (rc.isValidEmail(email)){
		request.setAttribute("pEmailIsValid", "1");
		request.setAttribute("pEmailAutofill", email);
	}
	else{
		request.setAttribute("pEmailIsValid", "2");
		
		goRegister = false;
		
	}
	
	// Check if account credentials already exists
	String dbUsername = null;
	String dbEmail = null;
	try{
		// 1. Register new jdbc driver
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 2. Get a connection to database
		Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		// 3. Create a prepared statement (select username that matches the input)
		PreparedStatement ps = myConn.prepareStatement("SELECT username FROM tblAccounts WHERE username=?");
		ps.setString(1, username);
		// 4. Execute and pass it to a result set
		ResultSet rs = ps.executeQuery(); 
		while (rs.next()){
			dbUsername = rs.getString("username");
		}
		
		// 5. Create a prepared statement (select email that matches the input)
		PreparedStatement ps2 = myConn.prepareStatement("SELECT email FROM tblAccounts WHERE email=?");
		ps2.setString(1, email);
		// 6. Execute and pass it to a result set
		rs = ps2.executeQuery(); 
		while (rs.next()){
			dbEmail = rs.getString("email");
		}
		
		
		ps.close();
		ps2.close();
		rs.close();
		myConn.close();
	}
	catch (SQLException sqle){
		sqle.printStackTrace();
	}
	catch (Exception exc){
			exc.printStackTrace();
		}
	
	// sets a true/false session value regards to username uniqueness
	if(dbUsername != null){
		request.setAttribute("pUsernameIsValid2", "2");
		goRegister = false;
	}
	else{
		request.setAttribute("pUsernameIsValid2", "1");
		request.setAttribute("pUsernameAutofill", username);
	}
	
	//sets a true/false session value regards to email uniqueness
	if(dbEmail != null){
		request.setAttribute("pEmailIsValid2", "2");
		goRegister = false;
	}
	else{
		request.setAttribute("pEmailIsValid2", "1");
		request.setAttribute("pEmailAutofill", email);
	}
	
	// If user credentials are valid, proceed to add it in the database
	if (goRegister){
		try{
			// 1. Register new jdbc driver
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			// 2. Get a connection to database
			Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
			// 3. Create a prepared statement (select username that matches the input)
			PreparedStatement ps = myConn.prepareStatement("SELECT COUNT(accountID) FROM tblAccounts");
			// 4. Execute and pass it to a result set
			ResultSet rs = ps.executeQuery(); 
			while (rs.next()){
				accountID = rs.getInt("COUNT(accountID)");
			}
			
			// 5. Create a prepared statement (insert citizen account credentials and data)
			PreparedStatement ps2 = myConn.prepareStatement("INSERT INTO tblAccounts VALUES (?, ?, ?, ?, ?, ?, ?)");
			ps2.setInt(1, accountID+1);
			ps2.setString(2, ldObj + " " + ltObj);
			ps2.setString(3, accountType);
			ps2.setString(4, username);
			ps2.setString(5, password);
			ps2.setString(6, email);
			ps2.setString(7, null);
			// 6. Execute Insert
			ps2.executeUpdate();
			
			addResult = "<div class=\"alert alert-success\" role=\"alert\">" +
			  		"Your account has been created!" +
			  		"</div>";
			  		
			ps.close();
			ps2.close();
			rs.close();
			myConn.close();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch (Exception exc){
			exc.printStackTrace();
			addResult = "<div class=\"alert alert-danger\" role=\"alert\">" +
			  		"An error occurred." +
			  		"</div>";
		}
		
		
	}
	// If user credentials are invalid, go back to sign-up form and display errors
	else{
		RequestDispatcher dispatcher = request.getRequestDispatcher("sign-upForm.jsp");
		dispatcher.forward(request, response);
	}
	

%>
<!DOCTYPE html>

<html lang="en">
<head>
<% out.print(printHtmlObj.printHead("Sign up Result")); %>
</head>

<body>
	<div id="bbp-content-wrapper">
		<header>
			<% 
					String pSessionUsername = String.valueOf(session.getAttribute("sessionUsername"));
					String pSessionPassword = String.valueOf(session.getAttribute("sessionPassword"));
					String pSessionAccountType = String.valueOf(session.getAttribute("sessionAccountType"));
					String pSessionTitle = String.valueOf(session.getAttribute("sessionTitle"));
	
					if (pSessionAccountType.equals("D")){
						out.print(printHtmlObj.printNavDistrict(pSessionUsername, pSessionTitle));
					}
					else if (pSessionAccountType.equals("C")){
						out.print(printHtmlObj.printNavCitizen(pSessionUsername));
					}
					else {
						out.print(printHtmlObj.printNavNotLoggedIn());
					}
					
				%>
		</header>

		<div class="card mb-3">
			<div class="card-body">
				<% out.print(addResult); %>

				<a class="btn btn-primary" href="index.jsp" role="button">Back
					to homepage</a>
			</div>
		</div>

		<footer id="bbp-footer">
			<hr>
			<p class="mb-0" id="bbp-footer-text">
				<small>BantayBayan Prototype Project. 2017</small>
			</p>
		</footer>
	</div>
	<% out.print(printHtmlObj.printScripts()); %>
</body>
</html>
