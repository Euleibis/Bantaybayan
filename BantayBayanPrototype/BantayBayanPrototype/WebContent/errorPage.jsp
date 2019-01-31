<!-- This .jsp file displays an error page with a redirect link to the homepage whenever this jsp file is redirected to. -->
<%@ page import="com.bbp.*"%>
<%!
	printHtml printHtmlObj = new printHtml();
%>
<!DOCTYPE html>

<html lang="en">
<head>
<% out.print(printHtmlObj.printHead("Error Occurred")); %>
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
				<div class="alert alert-danger" role="alert">An error occured.
				</div>
				<a href="index.jsp">Back to homepage.</a>
			</div>
		</div>
	</div>
	<% out.print(printHtmlObj.printScripts()); %>
</body>
</html>