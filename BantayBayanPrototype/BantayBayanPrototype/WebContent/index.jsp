<!-- This .jsp file is the homepage of the website, here first shows the navigation, recent posts, and trending posts -->
<%@ page import="java.sql.*"%>
<%@ page import="com.bbp.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.Instant"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%!
	printHtml printHtmlObj = new printHtml();
	bbpDate bbpDateObj = new bbpDate();
%>

<!DOCTYPE html>
<html>
<head>
<% out.print(printHtmlObj.printHead("BantayBayan Prototype")); %>
</head>
<body>
	<div class="container" id="bbp-content-wrapper">
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

		<div class="jumbotron mb-3" id="bbp-custom-card">
			<h1 class="display-4">Welcome to BantayBayan!</h1>
			<p class="lead">BantayBayan lets you share your public concerns
				to the community, which includes you, other citizens, and respective
				district authorities.</p>
			<p class="lead">
				<a class="btn btn-primary btn-lg" href="viewInformation.jsp" role="button">Learn
					more</a>
			</p>
		</div>

		<% 
			// (Array length is 3, as we will only display 3 concerns)
			// String arrays for Recent Posts
			String[] pConcernID = new String[3];
			String[] pUsername = new String[3];
			String[] pDate = new String[3];
			String[] pSub = new String[3];
			// Initialize Local Date and Local Time
			LocalDate[] ldObj = new LocalDate[3];
			LocalTime[] ltObj = new LocalTime[3];
			// String arrays for Trending Posts
			String[] pConcernID2 = new String[3];
			String[] pUsername2 = new String[3];
			String[] pDate2 = new String[3];
			String[] pSub2 = new String[3];
			LocalDate[] ldObj2 = new LocalDate[3];
			LocalTime[] ltObj2 = new LocalTime[3];
			
			// Try block for getting Recent Posts
			try{
				// 1. Register new jdbc driver
				DriverManager.registerDriver(new com.mysql.jdbc.Driver());
				// 2. Get a connection to database
				Connection conObj = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbp?autoReconnect=true&useSSL=false", "root", "33sqltestpass33");
				// 3. Create a prepared statement (select 3 values from tblConcerns that is descendingly ordered by its concernID)
				PreparedStatement psObj = conObj.prepareStatement("SELECT * FROM tblConcerns ORDER BY concernID DESC LIMIT 3;");
				// 4. Execute and pass it to a result set
				ResultSet myRs = psObj.executeQuery();
				// 5. Pass the values of the result set into an array
				int i = 0;
				while (myRs.next() || i <= 2){
					pConcernID[i] = myRs.getString("concernID");
					pUsername[i] = myRs.getString("username");
					pSub[i] = myRs.getString("sub");
					ldObj[i] = myRs.getDate("postdate").toLocalDate();
					ltObj[i] = myRs.getTime("postdate").toLocalTime();
					i++;
				}
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception exc){
				exc.printStackTrace();
			}
			
			// Try block for getting Trending Posts
			try{
				// 1. Register new driver
				DriverManager.registerDriver(new com.mysql.jdbc.Driver());
				// 2. Get a connection to database
				Connection conObj = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbp?autoReconnect=true&useSSL=false", "root", "33sqltestpass33");
				// 3. Create a prepared statement (select 3 values from tblConcerns that is descendingly ordered by its views)
				PreparedStatement psObj = conObj.prepareStatement("SELECT * FROM tblConcerns ORDER BY views DESC LIMIT 3");
				// 4. Execute and pass it to a result set
				ResultSet myRs = psObj.executeQuery();
				// 5. Pass the values of the result set into an array
				int i = 0;
				while (myRs.next() || i <= 2){
					pConcernID2[i] = myRs.getString("concernID");
					pUsername2[i] = myRs.getString("username");
					pSub2[i] = myRs.getString("sub");
					ldObj2[i] = myRs.getDate("postdate").toLocalDate();
					ltObj2[i] = myRs.getTime("postdate").toLocalTime();
					i++;
				}	
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception exc){
				exc.printStackTrace();
			}
			%>



			<% 
			// Shows recent and trending posts (Subject, date, and a button link) if there is already 3 or more concerns in tblConcerns
			if(ltObj[2] != null) { 
			%>
		<div class="card mb-3">
			<div class="card-body">
				<h2 class="card-title">Recent posts</h2>
				<form action="viewConcern.jsp" method="get">
					<div class="card-group">
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub[0]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj[0].getMonth() + " " + ldObj[0].getDayOfMonth() + ", " + ldObj[0].getYear() + " | "
														+ bbpDateObj.addZero(ltObj[0].getHour()) + ":" + bbpDateObj.addZero(ltObj[0].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<%out.print("?concernID=" + pConcernID[0]);%>"
									class="btn btn-primary">View</a>
							</div>
						</div>
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub[1]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj[1].getMonth() + " " + ldObj[1].getDayOfMonth() + ", " + ldObj[1].getYear() + " | "
														+ bbpDateObj.addZero(ltObj[1].getHour()) + ":" + bbpDateObj.addZero(ltObj[1].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<%out.print("?concernID=" + pConcernID[1]);%>"
									class="btn btn-primary">View</a>
							</div>
						</div>
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub[2]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj[2].getMonth() + " " + ldObj[2].getDayOfMonth() + ", " + ldObj[2].getYear() + " | "
														+ bbpDateObj.addZero(ltObj[2].getHour()) + ":" + bbpDateObj.addZero(ltObj[2].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<% out.print("?concernID=" + pConcernID[2]); %>"
									class="btn btn-primary">View</a>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="card mb-3">
			<div class="card-body">
				<h2 class="card-title">Trending posts</h2>
				<form action="viewConcern.jsp" method="get">
					<div class="card-group">
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub2[0]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj2[0].getMonth() + " " + ldObj2[0].getDayOfMonth() + ", " + ldObj2[0].getYear() + " | "
														+ bbpDateObj.addZero(ltObj2[0].getHour()) + ":" + bbpDateObj.addZero(ltObj2[0].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<%out.print("?concernID=" + pConcernID[0]);%>"
									class="btn btn-primary">View</a>
							</div>
						</div>
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub2[1]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj2[1].getMonth() + " " + ldObj2[1].getDayOfMonth() + ", " + ldObj2[1].getYear() + " | "
														+ bbpDateObj.addZero(ltObj2[1].getHour()) + ":" + bbpDateObj.addZero(ltObj2[1].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<%out.print("?concernID=" + pConcernID2[1]);%>"
									class="btn btn-primary">View</a>
							</div>
						</div>
						<div class="card">
							<div class="card-body">
								<p class="card-text">
									<%
										out.print(pSub2[2]);
									%>
								</p>
								<p class="card-text">
									<small class="text-muted"> <%
											out.print(ldObj2[2].getMonth() + " " + ldObj2[2].getDayOfMonth() + ", " + ldObj2[2].getYear() + " | "
														+ bbpDateObj.addZero(ltObj2[2].getHour()) + ":" + bbpDateObj.addZero(ltObj2[2].getMinute()));
										%>
									</small>
								</p>
							</div>
							<div class="card-footer" id="bbp-custom-card">
								<a
									href="viewConcern.jsp<% out.print("?concernID=" + pConcernID2[2]); %>"
									class="btn btn-primary">View</a>
							</div>
						</div>
					</div>

				</form>
			</div>
		</div>
		<% } %>

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

