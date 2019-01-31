<!-- This .jsp file displays an html sign up form that submits its input to addUserToDatabase.jsp -->
<%@ page import="com.bbp.*" %>
<%!
	printHtml printHtmlObj = new printHtml();
	regChecker regCheckerObj = new regChecker();
%>
<!DOCTYPE html>

<html lang="en">
	<head>
		<% out.print(printHtmlObj.printHead("Sign up Form")); %>
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
			<form class="signupform" action="addUserToDatabase.jsp" method="post">
				<%
					boolean isDefault = true;
					boolean isValid = false;
					boolean isError = false;
					
					String usernameAutofill = "";
					String emailAutofill = "";
					
					boolean UsernameIsDefault = true;
					String UsernameisValid = "0";

					boolean PasswordIsDefault = true;
					String PasswordIsValid = "0";

					boolean ConfirmPasswordIsDefault = true;
					String ConfirmPasswordisValid = "0";

					boolean EmailIsDefault = true;
					String EmailisValid =  "0";
					
					
					String pUsernameFormControl = "form-control";
					String pPasswordFormControl = "form-control";
					String pConfirmPasswordFormControl = "form-control";
					String pEmailFormControl = "form-control";
					
					String usernameError = "";
					String usernameError2 = "";
					String passwordError = "";
					String confirmPasswordError = "";
					String emailError = "";
					String emailError2 = "";
					
					
					String result = "";
					
					// AUTO FILL
					//		USERNAME
					if (request.getAttribute("pUsernameAutofill") == null || String.valueOf(request.getAttribute("pUsernameIsValid")).equals("2") || String.valueOf(request.getAttribute("pUsernameIsValid2")).equals("2")){
						usernameAutofill = "";
					}
					else{
						usernameAutofill = String.valueOf(request.getAttribute("pUsernameAutofill"));
					}
					
					//		EMAIL
					if (request.getAttribute("pEmailAutofill") == null || String.valueOf(request.getAttribute("pEmailIsValid")).equals("2") || String.valueOf(request.getAttribute("pEmailIsValid2")).equals("2")){
						emailAutofill = "";
					}
					else{
						emailAutofill = String.valueOf(request.getAttribute("pEmailAutofill"));
					}
					
					// INPUT BOX
					//		USERNAME
					if (String.valueOf(request.getAttribute("pUsernameIsValid")).equals("2") || String.valueOf(request.getAttribute("pUsernameIsValid2")).equals("2")){
						pUsernameFormControl = "form-control is-invalid";
						usernameError = " &bull; Username invalid/taken.<br>";
					}
					else if (String.valueOf(request.getAttribute("pUsernameIsValid")).equals("1") && String.valueOf(request.getAttribute("pUsernameIsValid2")).equals("1")){
						pUsernameFormControl = "form-control is-valid";
					}	
					
					//		PASSWORD
					if (String.valueOf(request.getAttribute("pPasswordIsValid")).equals("2")){
						pPasswordFormControl = "form-control is-invalid";
						passwordError = " &bull; Password must be at least 6 characters long.<br>";
					}
					else if (String.valueOf(request.getAttribute("pPasswordIsValid")).equals("1")){
						pPasswordFormControl = "form-control";
					}
					
					//		CONFIRM PASSWORD
					if (String.valueOf(request.getAttribute("pConfirmPasswordIsValid")).equals("2")){
						pConfirmPasswordFormControl = "form-control is-invalid";
						confirmPasswordError = " &bull; Passwords did not match.<br>";
					}
					else if (String.valueOf(request.getAttribute("pConfirmPasswordIsValid")).equals("1")){
						pConfirmPasswordFormControl = "form-control";
					}
					
					//		EMAIL
					if (String.valueOf(request.getAttribute("pEmailIsValid")).equals("2") || String.valueOf(request.getAttribute("pEmailIsValid2")).equals("2")){
						pEmailFormControl = "form-control is-invalid";
						emailError = " &bull; E-mail is invalid/taken.<br>";
					}
					else if (String.valueOf(request.getAttribute("pEmailIsValid")).equals("1") && String.valueOf(request.getAttribute("pEmailIsValid2")).equals("1")){
						pEmailFormControl = "form-control is-valid";
					}
					
					
					// If there's error/s, it creates an alert box with the errors specified
					if(usernameError.equals("") == false || usernameError2.equals("") == false || passwordError.equals("") == false || confirmPasswordError.equals("") == false || emailError.equals("") == false || emailError2.equals("") == false){
						result = "<div class=\"alert alert-danger\" role=\"alert\">" +
								usernameError +
								passwordError +
								confirmPasswordError +
								emailError +
			    		  		"</div>";
					}
		    		  		
				%>
				<div class="card mb-3">
				  <div class="card-body">
				    <h2 class="card-title">Sign up</h2>
				    <% out.print(result); %>
					<div class="form-group">
						<label class="col-form-label">Username</label>
						<input type="text" class="<% out.print(pUsernameFormControl); %>" name="username" id="bbp-signup-form-username" placeholder="Enter username" value="<% out.print(usernameAutofill); %>" maxlength="12" required>
					</div>
					
					<div class="form-group">
						<label class="col-form-label">Password</label>
						<input type="password" class="<% out.print(pPasswordFormControl); %>" name="password" id="bbp-signup-form-password" placeholder="Enter password" required>
					</div>
					
					<div class="form-group">
						<label class="col-form-label">Confirm Password</label>
						<input type="password" class="<% out.print(pConfirmPasswordFormControl); %>" name="confirmpassword" id="bbp-signup-form-confPassword" placeholder="Repeat password" required>
					</div>
					
					<div class="form-group mb-4">
						<label class="col-form-label">Email</label>
						<input type="text" class="<% out.print(pEmailFormControl); %>" name="email" id="bbp-signup-form-email" placeholder="Enter email address" value="<% out.print(emailAutofill); %>" maxlength="256" required>
					</div>
					
					<button type="submit" class="btn btn-primary">Sign up</button>
				  </div>
				</div>
				
				
			</form>
			<footer id="bbp-footer">
				  <hr>
				  <p class="mb-0" id="bbp-footer-text"><small>BantayBayan Prototype Project. 2017</small></p>
		</footer>
		</div>
		<% out.print(printHtmlObj.printScripts()); %>
	</body>
</html>