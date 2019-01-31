<!-- This .jsp file gets all district accounts and its data, and displays it in an html page -->
<%@page import="java.sql.*"%>
<%@page import="com.bbp.*"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>

<%
	int districtCount = 0;
	String[] districtTitlesArr = new String[100];
	
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	
	try{
		// 1. Register new jdbc driver
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 2. Get a connection to database
		Connection myConn = DriverManager.getConnection(sqlurl, sqluser, sqlpass);
		// 3. Create a prepared statement (Select total district accounts)
		PreparedStatement ps = myConn.prepareStatement("SELECT COUNT(title) FROM tblAccounts WHERE accountType=\"D\";");
		// 4. Execute and pass it to a result set
		ResultSet rs = ps.executeQuery(); 
		while (rs.next()){
			districtCount = rs.getInt("COUNT(title)");
		}
		
		// 5. Create a prepared statement (Select all district accounts data)
		PreparedStatement ps2 = myConn.prepareStatement("SELECT * FROM tblAccounts WHERE accountType=\"D\" ORDER BY title;");
		// 6. Execute and pass it to a result set
		rs = ps2.executeQuery(); 
		int i1 = 0;
		while (rs.next()){
			districtTitlesArr[i1] = rs.getString("title");
			i1++;
		}
	}
	catch (Exception exc){
		exc.printStackTrace();
		
	}
%>

<!DOCTYPE html>

<html lang="en">
<head>
<% out.print(printHtmlObj.printHead("All Districts")); %>
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
		<div class="card" style="margin-bottom: 2rem;">
			<div class="card-body">
				<h2 class="card-title">All Districts</h2>
				<table class="table">
					<thead class="thead-light">
						<tr>
							<th scope="col">District</th>
							<th scope="col">Average Reply Time</th>
							<%
				      	
				      %>
							<th scope="col">Average Rating</th>
						</tr>
					</thead>
					<tbody>
						<%
				  	for(int i = 0; i < districtCount; i++){
				  %>
						<tr>
							<td><a
								href="viewDistrict.jsp?title=<% out.println(districtTitlesArr[i]); %>">
									<% out.print(districtTitlesArr[i]); %>
							</a></td>
							<td>
								<% 
							try{
								String district = districtTitlesArr[i];
								String finalTime = null;
								TypicallyReplies tr = new TypicallyReplies();
								out.print(tr.typical(districtTitlesArr[i]));
							}
							catch(Exception exc){
								exc.printStackTrace();
								out.print("(not enough data)");
							}
						%>
							</td>
							<td>
								<% 
							try{
								double finalRating = 0;
								Rating r = new Rating();
								finalRating = r.getAverageRatings(districtTitlesArr[i]);
								out.print(finalRating + "/5");
							}
							catch(Exception exc){
								exc.printStackTrace();
								out.print("(not enough ratings)");
							}
							
						%>
							</td>
						</tr>
						<%
				  	}
				  %>
					</tbody>
				</table>
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


