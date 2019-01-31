
<%@page import="java.sql.*"%>
<%@ page import="com.bbp.*" %>
<%!
	printHtml printHtmlObj = new printHtml();
%>

<%
	String sqlurl = "jdbc:mysql://localhost:3306/bbp";
	String sqluser = "root";
	String sqlpass = "33sqltestpass33";
	
	int districtCount = 0;
	String[] districtTitlesArr = new String[100];
	
	try{
			
		
	}
	catch (Exception exc){
		exc.printStackTrace();
		
	}

%>

<!DOCTYPE html>

<html lang="en">
	<head>
		<% out.print(printHtmlObj.printHead("All Concerns")); %>
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
			
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item disabled">
			      <a class="page-link" href="#" tabindex="-1">Previous</a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>
		<footer id="bbp-footer">
				  <hr>
				  <p class="mb-0" id="bbp-footer-text"><small>BantayBayan Prototype Project. 2017</small></p>
			</footer>	
		</div>
		<% out.print(printHtmlObj.printScripts()); %>
	</body>
</html>


