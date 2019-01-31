<!-- This .jsp file displays the information of a concern, where the citizen and district account can interact -->
<%@ page import="java.sql.*"%>
<%@ page import="com.bbp.*"%>

<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalTime"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>
<%
	bbpDate bbpDateObj = new bbpDate();
	
	int pConcernID = 0;
	String pUser = null;
	LocalDate pPostdate = null;
	LocalTime pPosttime = null;
	String pStatus = null;
	String pReplystatus = null;
	String pCategory = null;
	String pRecipient = null;
	String pDistrict = null;
	String pSub = null;
	String pBody = null;
	String pAttachment = null;
	String pViews = null;
	
	// arrays are 100 in length for temporary non-dynamic purpose
	int[] commentIDArr = new int[100];
	String[] usernameArr = new String[100];
	String[] commentTextArr = new String[100];
	LocalDate[] dateCommentedArr = new LocalDate[100];
	LocalTime[] timeCommentedArr = new LocalTime[100];
	int[] upvotesArr = new int[100];
	int[] downvotesArr = new int[100];
	String[] titleArr = new String[100];
	int tblCommentsIndex = 0;
	
	LocalDate[] ldObj = new LocalDate[100];
	LocalTime[] ltObj = new LocalTime[100];
	
	// get value passed from index.jsp
	String getConcernID = request.getParameter("concernID");
	
	try{
		
		//******SHOWING
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		// 1. Get a connection to database
		Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbp?useUnicode=yes&characterEncoding=UTF-8", "root", "33sqltestpass33");
		// 2. Create a statement
		Statement myStmt = myConn.createStatement();
		// 3. Execute SQL Query
		
		// query 1 for concern
		ResultSet myRs = myStmt.executeQuery("SELECT * FROM tblConcerns WHERE concernID=" + getConcernID);
		// 4. Process the result set
		int i1 = 0;
		int i2 = 0;

		while (myRs.next()){
			
			//pSub[i] = myRs.getString("sub");
			
			pConcernID = myRs.getInt("concernID");
			pUser = myRs.getString("username");
			pPostdate = myRs.getDate("postdate").toLocalDate();
			pPosttime = myRs.getTime("postdate").toLocalTime();
			pStatus = myRs.getString("concernStatus");
			pReplystatus = myRs.getString("replyStatus");
			pCategory = myRs.getString("category");
			pRecipient = myRs.getString("recipient");
			pDistrict = myRs.getString("district");
			pSub = myRs.getString("sub");
			pBody = myRs.getString("body");
			pAttachment = myRs.getString("attachment");
			pViews = myRs.getString("views");
			i1++;
		}
		
		
		
		
		
		myRs = myStmt.executeQuery("SELECT COUNT(commentID) FROM tblComments WHERE concernID=" + pConcernID + ";");
		while (myRs.next()){
			tblCommentsIndex = myRs.getInt("COUNT(commentID)");
		}
		
		
		// query 2 for comments
		myRs = myStmt.executeQuery("SELECT * FROM tblComments WHERE concernID=" + pConcernID +  ";");
		while (myRs.next()){
			commentIDArr[i2] = myRs.getInt("commentID");
			usernameArr[i2] = myRs.getString("username");
			commentTextArr[i2] = myRs.getString("commentText");
			dateCommentedArr[i2] = myRs.getDate("dateCommented").toLocalDate();
			timeCommentedArr[i2] = myRs.getTime("dateCommented").toLocalTime();
			upvotesArr[i2] = myRs.getInt("upvotes");
			downvotesArr[i2] = myRs.getInt("downvotes");
			titleArr[i2] = myRs.getString("title");
			i2++;
					
		}
		
		//increment views
		PreparedStatement ps = myConn.prepareStatement("UPDATE tblConcerns SET views=views+1 WHERE concernID=?");
		ps.setInt(1, pConcernID);
		ps.executeUpdate();
	}
	catch (Exception exc){
		exc.printStackTrace();
	}
	
		
%>

<html>
<head>
<% out.print(printHtmlObj.printHead("View Concern")); %>
</head>

<body>
	<div class="container" id="bbp-content-wrapper"
		style="margin-bottom: 2rem;">
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
				<div class="text-right mb-3">
					<a class="btn btn-primary btn-lg" href=# role=button><small>Upvote</small></a>
					<span> 0 </span> <a class="btn btn-danger btn-lg" href=#
						role=button><small>Downvote</small></a> <span> 0 </span>
				</div>
				<hr>

				<% if(pStatus.equals("Unresolved")){
		  %>
				<div class="alert alert-danger" role="alert">This concern is
					not yet resolved.</div>
				<% }
		  	else if(pStatus.equals("Resolved")){%>
				<div class="alert alert-success" role="alert">This concern is
					marked as resolved by the author.</div>
				<%} %>

				<% if(pReplystatus.equals("Not Replied")){
		  %>
				<div class="alert alert-danger" role="alert">
					This concern is awaiting for reply from <a
						href="viewDistrict.jsp?title=<% out.println(pDistrict); %>">
						<% out.println(pDistrict); %> municipal authority
					</a>
				</div>
				<% }
		  	else if(pReplystatus.equals("Replied")){%>
				<div class="alert alert-success" role="alert">
					The <a href="viewDistrict.jsp?title=<% out.println(pDistrict); %>">
						<% out.println(pDistrict); %> municipal authority
					</a> replied to this concern
				</div>
				<%} %>
				<h4 class="card-title">
					<% out.println(pSub); %>
				</h4>
				<h6 class="card-subtitle mb-2 text-muted">
					<small class="text-muted">Posted and sent on <% out.print(pPostdate.getMonth() + " " + pPostdate.getDayOfMonth() + ", " + pPostdate.getYear()  + " | " + bbpDateObj.addZero(pPosttime.getHour())  + ":" + bbpDateObj.addZero(pPosttime.getMinute())); %>
						by <% out.println(pUser); %> <br>Category: <% out.print(pCategory); %></small>
				</h6>
				<!--  <p class="card-text"><small class="text-muted"></small></p> -->
				<p class="card-text">
					<% out.println(pBody); %>
				</p>

				<% if (pAttachment != null){ %>
				<!-- Trigger the Modal -->
				<img id="myImg"
					src="<% out.println("data:image/png;base64, " + pAttachment); %>"
					width="300" height="200">

				<!-- The Modal -->
				<div id="myModal" class="modal">

					<!-- The Close Button -->
					<span class="close">&times;</span>

					<!-- Modal Content (The Image) -->
					<img class="modal-content" id="img01">

					<!-- Modal Caption (Image Text) -->
					<div id="caption"></div>
				</div>
				<% } %>

				<%
		    	if(pUser.equals(session.getAttribute("sessionUsername")) && pStatus.equals("Unresolved")){
		    %>

				<p>
					<a class="btn btn-success" data-toggle="collapse"
						href="#multiCollapseExample1" aria-expanded="false"
						aria-controls="multiCollapseExample1" id="bbp-resolve-button">Mark
						as resolved</a>
				</p>
				<form class="rating-form" action="submitRating.jsp" method="post">
					<div class="row">
						<div class="col">
							<div class="collapse multi-collapse" id="multiCollapseExample1">
								<div class="card card-body">
									<p class="card-text">How satisfied are you with their
										service?</p>
									<div class="btn-group" data-toggle="buttons">
										<label class="btn btn-warning"> <input type="radio"
											name="pRating" id="option1" autocomplete="off" value=1
											required>1
										</label> <label class="btn btn-warning"> <input type="radio"
											name="pRating" id="option2" autocomplete="off" value=2
											required>2
										</label> <label class="btn btn-warning"> <input type="radio"
											name="pRating" id="option3" autocomplete="off" value=3
											required>3
										</label> <label class="btn btn-warning"> <input type="radio"
											name="pRating" id="option4" autocomplete="off" value=4
											required>4
										</label> <label class="btn btn-warning"> <input type="radio"
											name="pRating" id="option5" autocomplete="off" value=5
											required>5
										</label>
									</div>
									<div class="form-group">
										<input type="hidden" name="pConcernID"
											value="<% out.print(pConcernID); %>" />
										<button type="submit" class="btn btn-success">Submit</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>

				<% } %>

			</div>

		</div>



		<div class="card">
			<div class="card-body">


				<h2 class="card-title">Comments</h2>

				<%
			    	if(session.getAttribute("sessionUsername") != null){
				%>

				<form action="addComment.jsp">
					<div class="card mb-3">
						<div class="card-body">
							<h4 class="card-title">Add a comment</h4>
							<div class="form-group">
								<input type="hidden" name="pConcernID"
									value="<% out.print(pConcernID); %>" /> <input type="hidden"
									name="pDistrict" value="<% out.print(pDistrict); %>" />
								<textarea class="form-control" id="exampleFormControlTextarea2"
									rows="2" name="pCommentText" required></textarea>
							</div>
							<button type="submit" class="btn btn-primary"
								id="bbp-button-float-right">Comment</button>
						</div>
					</div>
				</form>

				<% } %>



				<% 
		    	for (int i = 0; i < tblCommentsIndex; i++){
		    	if(titleArr[i] == null){
		    		out.print("" +
			    			"<div class=\"card border-dark mb-3\">" +
							  "<div class=\"card-header\" >" + usernameArr[i] + "<span class=\"text-muted\"> says:</span>" + "</div>" +	
							  "<div class=\"card-body text-dark\">" + 
							    "<p class=\"card-text\">" + commentTextArr[i] + "</p>" +
							    "<h6 class=\"card-subtitle mb-2 text-muted\"><small class=\"text-muted\">" + dateCommentedArr[i].getMonth() + " " + dateCommentedArr[i].getDayOfMonth() + " " + dateCommentedArr[i].getYear()  + " | " + timeCommentedArr[i].getHour()  + ":" + timeCommentedArr[i].getMinute() + "</small></h6>" +
							    "<a class=\"btn btn-primary btn-sm\" href=\"upvote.jsp?concernID=" + getConcernID + "&commentID=" + commentIDArr[i] + "\" role=\"button\"><small>Upvote</small></a>" +
					    		"<span class=\"text-primary\"> " + upvotesArr[i] + " </span>" +
								"<a class=\"btn btn-danger btn-sm\" href=\"downvote.jsp?concernID=" + getConcernID + "&commentID=" + commentIDArr[i] + "\" role=\"button\"><small>Downvote</small></a>" +
								"<span class=\"text-danger\"> " + downvotesArr[i] + " </span>" +
							   "</div>" +
							"</div>");
		    	}
		    	else{
		    		out.print("" +
			    			"<div class=\"card border-success mb-3\">" +
							  "<div class=\"card-header text-success\" >" + "<a href=\"viewDistrict.jsp?title=" + pDistrict + "\">" + pDistrict + " municipal authority</a>" + "<span class=\"text-muted\"> says:</span>" + "</div>" +	
							  "<div class=\"card-body text-dark\">" + 
							    "<p class=\"card-text\">" + commentTextArr[i] + "</p>" +
							    "<h6 class=\"card-subtitle mb-2 text-muted\"><small class=\"text-muted\">" + dateCommentedArr[i].getMonth() + " " + dateCommentedArr[i].getDayOfMonth() + " " + dateCommentedArr[i].getYear()  + " | " + timeCommentedArr[i].getHour()  + ":" + timeCommentedArr[i].getMinute() + "</small></h6>" +
					    		"<a class=\"btn btn-primary btn-sm\" href=\"upvote.jsp?concernID=" + getConcernID + "&commentID=" + commentIDArr[i] + "\" role=\"button\"><small>Upvote</small></a>" +
					    		"<span class=\"text-primary\"> " + upvotesArr[i] + " </span>" +
								"<a class=\"btn btn-danger btn-sm\" href=\"downvote.jsp?concernID=" + getConcernID + "&commentID=" + commentIDArr[i] + "\" role=\"button\"><small>Downvote</small></a>" +
								"<span class=\"text-danger\"> " + downvotesArr[i] + " </span>" +
							    "</div>" +
							"</div>");
		    	}
		    	
		    	}
		    	
		    	
		    	%>


			</div>

		</div>
		<footer id="bbp-footer">
			<hr>
			<p class="mb-0" id="bbp-footer-text">
				<small>BantayBayan Prototype Project. 2017</small>
			</p>
		</footer>
	</div>



	<br />

	<% out.print(printHtmlObj.printScripts()); %>

	<script>
    	// Get the modal
		var modal = document.getElementById('myModal');
		
		// Get the image and insert it inside the modal - use its "alt" text as a caption
		var img = document.getElementById('myImg');
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		img.onclick = function(){
		    modal.style.display = "block";
		    modalImg.src = this.src;
		    captionText.innerHTML = this.alt;
		}
		
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() { 
		  modal.style.display = "none";
		}
		</script>
</body>
</html>
