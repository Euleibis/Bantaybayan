<!-- This .jsp file prints the concern form -->
<%@ page import="com.bbp.*"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>
<!DOCTYPE html>
<html>
<head>
<% out.print(printHtmlObj.printHead("Concern Form")); %>
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

		<div class="card mb-3">
			<div class="card-body">
				<h2 class="card-title">Report/Post a concern</h2>
				<!-- Creates a form that submits to addMailToDatabase.jsp -->
				<form action="addMailToDatabase.jsp">
					<div class="form-group">
						<label for="exampleFormControlSelect1">District</label> <select
							class="form-control" id="exampleFormControlSelect1"
							name="district" required>
							<option disabled selected value="">- SELECT -</option>
							<option value="Abra">Abra</option>
							<option value="Agusan del Norte">Agusan del Norte</option>
							<option value="Agusan del Sur">Agusan del Sur</option>

						</select>
					</div>

					<div class="form-group">
						<label for="exampleFormControlSelect1">Category</label> <select
							class="form-control" id="exampleFormControlSelect1"
							name="category" required>
							<option disabled selected value="">- SELECT -</option>
							<option value="Education">Education</option>
							<option value="Health">Health</option>
							<option value="Infrastructure/Roads">Infrastructure/Roads</option>
							<option value="Other">Other</option>
						</select>
					</div>

					<div class="form-group">
						<label for="exampleFormControlTextarea1">Subject</label>
						<textarea class="form-control" id="exampleFormControlTextarea1"
							rows="1" name="sub" required maxlength="100"></textarea>
					</div>

					<div class="form-group">
						<label for="exampleFormControlTextarea2">Body</label>
						<textarea class="form-control" id="exampleFormControlTextarea2"
							rows="3" name="mess" required></textarea>
					</div>


					<div class="form-group">
						<label for="exampleFormControlFile1">Add a picture</label> <input
							type="file" class="form-control-file"
							id="exampleFormControlFile1" accept="image/*" name="pic">
					</div>

					<br>
					<button type="submit" class="btn btn-primary"
						id="bbp-button-float-right">Report/Post</button>
				</form>
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