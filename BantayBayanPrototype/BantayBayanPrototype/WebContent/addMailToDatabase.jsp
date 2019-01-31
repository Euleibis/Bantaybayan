<!-- This .jsp file gets the input from concern form and process it with the database -->
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Base64"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="javax.mail.internet.*,javax.activation.*"%>
<%@page import="java.io.*,java.util.*,javax.mail.*"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.util.ByteArrayDataSource"%>
<%@page import="com.bbp.*"%>
<%!Signup signupObj = new Signup();
	printHtml printHtmlObj = new printHtml();%>

<%
	// Data for concern
	String pUser = String.valueOf(session.getAttribute("sessionUsername"));
	LocalDate ldObj = LocalDate.now();
	LocalTime ltObj = LocalTime.now();
	String pStatus = "Unresolved";
	String pReplystatus = "Not Replied";
	String pCategory = request.getParameter("category");
	String pRecipient = "desesportesting33@gmail.com";
	String pDistrict = request.getParameter("district");
	String pSub = request.getParameter("sub");
	String pBody = request.getParameter("mess");
	String pAttachment = null;
	String pRating = null;
	String pReplyDate = null;

	// Data for automatic creation of district account
	//[1/2]this is the string for checking if the district already exists in db
	String dbDistrictTitle = null;
	//[2/2]this is the string to equal district title from signup form
	String districtTitle = request.getParameter("district");
	int districtAccountID = 0;
	LocalDate districtDateCreated = LocalDate.now();
	LocalTime districtTimeCreated = LocalTime.now();
	String districtAccountType = "D";
	String districtUsername = signupObj.generateAccount();
	String districtPassword = signupObj.generatePassword();
	String districtEmail = "desesportesting33@gmail.com";

	// Passer for appending district credentials
	String dbDistrictUsername = null;
	String dbDistrictPassword = null;

	// Gmail User Credential
	String gmailusername = "parasapagsubok33@gmail.com";
	String gmailpassword = "testsuboklang22";
	String recipient = "desesportesting33@gmail.com";
	String sendResult = "";

	// Converts image attachment to Base64 value
	File f = new File(request.getParameter("pic"));
	String encodedfile = null;
	try {
		FileInputStream fileInputStreamReader = new FileInputStream(f);
		byte[] bytes = new byte[(int) f.length()];
		fileInputStreamReader.read(bytes);
		encodedfile = new String(Base64.getEncoder().encode(bytes), "UTF-8");

		pAttachment = encodedfile;
		System.out.println(pAttachment);

		fileInputStreamReader.close();
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}

	int totalConcerns = 0;
	String addMailResult = "";

	// I. Storing, Altering, and Retrieving from database (Query Connection)
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	try {
		// 1. Register new jdbc driver
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 2. Get a connection to database
		Connection conObj = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		// 3. Create a prepared statement (select total concerns from tblConcerns)
		PreparedStatement ps1 = conObj.prepareStatement("SELECT COUNT(concernID) FROM tblConcerns;");
		// 4. Execute and pass it to a result set
		ResultSet myRs = ps1.executeQuery();
		while (myRs.next()) {
			totalConcerns = myRs.getInt("COUNT(concernID)");
		}

		// 5. Prepared Statement2 for Inserting Concern data
		PreparedStatement ps2 = conObj
				.prepareStatement("INSERT INTO tblConcerns VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		ps2.setInt(1, totalConcerns + 1);
		ps2.setString(2, pUser);
		ps2.setString(3, ldObj + " " + ltObj);
		ps2.setString(4, pStatus);
		ps2.setString(5, pReplystatus);
		ps2.setString(6, pCategory);
		ps2.setString(7, pRecipient);
		ps2.setString(8, pDistrict);
		ps2.setString(9, pSub);
		ps2.setString(10, pBody);
		ps2.setString(11, pAttachment);
		ps2.setString(12, pRating);
		ps2.setString(13, pReplyDate);
		ps2.setInt(14, 0);

		ps2.executeUpdate();

		// 6. Prepared Statement3 for Selecting district account in tblAccounts
		PreparedStatement ps3 = conObj
				.prepareStatement("SELECT title FROM tblAccounts WHERE accountType='D' AND title=?");
		ps3.setString(1, districtTitle);
		// 7. Execute ps3 and pass it to a result set
		myRs = ps3.executeQuery();
		while (myRs.next()) {
			dbDistrictTitle = myRs.getString("title");
		}

		// (If there is no such district name in the database, it creates a district account)
		if (dbDistrictTitle == null) {
			// 8. Prepared Statement4 for getting total number of accounts, increments it for new accountID
			PreparedStatement ps4 = conObj.prepareStatement("SELECT COUNT(accountID) FROM tblAccounts");
			// 9. Execute ps4 and pass it to a result set
			myRs = ps4.executeQuery();
			while (myRs.next()) {
				districtAccountID = myRs.getInt("COUNT(accountID)") + 1;
			}

			// 10. Prepared Statement5 for inserting data to new district account
			PreparedStatement ps5 = conObj
					.prepareStatement("INSERT INTO tblAccounts VALUES(?, ?, ?, ?, ?, ?, ?)");
			ps5.setInt(1, districtAccountID);
			ps5.setString(2, districtDateCreated + " " + districtTimeCreated);
			ps5.setString(3, districtAccountType);
			ps5.setString(4, districtUsername);
			ps5.setString(5, districtPassword);
			ps5.setString(6, districtEmail);
			ps5.setString(7, districtTitle);

			ps5.executeUpdate();

			// CLOSE PREPARED STATEMENTS
			ps4.close();
			ps5.close();
		}

		// 11. Prepared Statement6 FOR SELECTING USER AND PASS OF THE DISTRICT WHICH WILL APPEND TO THE LINK IN THE MAIL SENT
		PreparedStatement ps6 = conObj.prepareStatement(
				"SELECT username, password FROM tblAccounts WHERE title=? AND accountType='D';");
		ps6.setString(1, pDistrict);
		// 12. Execute ps6 and pass it to a result set
		myRs = ps6.executeQuery();
		while (myRs.next()) {
			dbDistrictUsername = myRs.getString("username");
			dbDistrictPassword = myRs.getString("password");
		}

		// II. Sending Mail

		//(Declaring basic properties in mail properties)
		Properties props = System.getProperties();

		//(Setting the mailing transport protocol to "smtp" [Simple Mail Transfer Protocol], which is just another type of Transfer Protocol
		// this is chosen as it is the most simplest Transfer Protocol for basic functionality)
		props.setProperty("mail.transport.protocol", "smtp");

		//(Setting the host to Gmail. Gmail provides free mail hosting connection. Again it is just another type of host connection
		// It is chosen for basic functionality)
		props.setProperty("mail.host", "smtp.gmail.com");

		props.put("mail.smtp.auth", "true");
		//(Setting the SMTP port number)
		props.put("mail.smtp.port", "465");
		props.put("mail.debug", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session emailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("gmailusername", "gmailpassword");
			}

		});

		emailSession.setDebug(true);
		Message message = new MimeMessage(emailSession);
		// Set sender
		message.setFrom(new InternetAddress("parasapagsubok33@gmail.com"));
		// Set recipient
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
		// Set the subject of the mail to the subject parameter in concern form
		message.setSubject(pSub);

		// Prepare for transport
		message.setContent(printHtmlObj.printEmailContent(dbDistrictUsername, dbDistrictPassword),
				"text/html; charset=utf-8");
		Transport transport = emailSession.getTransport("smtp");
		// Connect to smtp.gmail.com
		transport.connect("smtp.gmail.com", gmailusername, gmailpassword);

		// Transport the mail
		transport.sendMessage(message, message.getAllRecipients());

		// CLOSE PREPARED STATEMENTS AND RESULT SET
		ps1.close();
		ps2.close();
		ps3.close();
		ps6.close();
		myRs.close();
		conObj.close();

	} catch (MessagingException e) {
		sendResult = "<div class=\"alert alert-danger\" role=\"alert\">" + "Unable to send mail." + "</div>";
	} catch (Exception exc) {
		exc.printStackTrace();
		addMailResult = "<div class=\"alert alert-danger\" role=\"alert\">" + "Unable to process mail."
				+ "</div>";
	}
%>
<!-- HTML Display -->
<!DOCTYPE html>

<html lang="en">
<head>
<%
	out.print(printHtmlObj.printHead("Send/Post Result"));
%>
</head>

<body>
	<div id="bbp-content-wrapper">
		<header>
			<%
				String pSessionUsername = String.valueOf(session.getAttribute("sessionUsername"));
				String pSessionPassword = String.valueOf(session.getAttribute("sessionPassword"));
				String pSessionAccountType = String.valueOf(session.getAttribute("sessionAccountType"));
				String pSessionTitle = String.valueOf(session.getAttribute("sessionTitle"));

				if (pSessionAccountType.equals("D")) {
					out.print(printHtmlObj.printNavDistrict(pSessionUsername, pSessionTitle));
				} else if (pSessionAccountType.equals("C")) {
					out.print(printHtmlObj.printNavCitizen(pSessionUsername));
				} else {
					out.print(printHtmlObj.printNavNotLoggedIn());
				}
			%>
		</header>

		<div class="card mb-3">
			<div class="card-body">
				<%
					if ((sendResult == "" || sendResult == null) && (addMailResult == "" || addMailResult == null)) {
				%>
				<div class="alert alert-success" role="alert">
					Mail sent to <a
						href="viewDistrict.jsp?title=<%out.print(pDistrict);%>"> <%
					 	out.print(pDistrict);
					 %> municipal authority
					</a>
				</div>
				<%
					} else {
						out.print(sendResult);
						out.print(addMailResult);
					}
				%>

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
	<%
		out.print(printHtmlObj.printScripts());
	%>
</body>
</html>


