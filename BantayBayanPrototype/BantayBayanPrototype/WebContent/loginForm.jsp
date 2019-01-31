<!-- This .jsp file displays an html login form that submits its input to loginSession.jsp -->
<%@ page import="com.bbp.*"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>
<!DOCTYPE html>

<html lang="en">
<head>
<% out.print(printHtmlObj.printHead("Login Form")); %>
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
		<form class="loginform" action="loginSession.jsp" method="post">
			<%
				String pUsernameFormControl = "form-control";
				String pPasswordFormControl = "form-control";
				String result = "";

				if (request.getAttribute("pLoginIsValid") == "2"){
					pUsernameFormControl = "form-control is-invalid";
					pPasswordFormControl = "form-control is-invalid";
					
					result = "<div class=\"alert alert-danger\" role=\"alert\">" +
		    		  		" &bull; Username and Password combination does not exist." +
		    		  		"</div>";
				}
				else {
					pUsernameFormControl = "form-control";
					pPasswordFormControl = "form-control";
				}
				%>

			<div class="card mb-3">
				<div class="card-body">
					<h2 class="card-title">Login</h2>
					<div class="form-group">
						<% out.print(result); %>
						<label class="col-form-label">Username</label> <input type="text"
							class="<% out.print(pUsernameFormControl); %>" name="username"
							id="bbp-login-form-username" placeholder="Enter Username"
							required maxlength="12">
					</div>

					<div class="form-group">
						<label class="col-form-label">Password</label> <input
							type="password" class="<% out.print(pPasswordFormControl); %>"
							name="password" id="bbp-login-form-password"
							placeholder="Enter Password" required>
					</div>
					<button type="submit" class="btn btn-primary">Login</button>
				</div>
			</div>
		</form>
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