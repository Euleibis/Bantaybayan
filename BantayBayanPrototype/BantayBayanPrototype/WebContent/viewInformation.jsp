<!-- This .jsp file displays an information page about the website -->
<%@ page import="com.bbp.*" %>
<%!
	printHtml printHtmlObj = new printHtml();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% out.print(printHtmlObj.printHead("ABOUT")); %>
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
		    <h1 class="mb-4" align=center>ABOUT BANTAYBAYAN</h1>
		    <div class="page-break"></div>
		  	<p class="text-muted">BantayBayan is a way to interact with your local authorities and fellow citizens for
		  	 problems within your community that you wish to discuss.Instead of waiting to reach an actual representative
		  	 through the hotline or filling up a lengthy form,BantayBayan makes the process easier in just a few clicks: </p>
			<div class="page-break"></div>
			<p class="text-info"><b>What happens after I report? </b></p>
			<p class="text-muted">After reporting the problem,you can still play a role in ensuring that the problem is detailed and discussed.
			You can interact with other citizens and the government publicly through commenting.You are also in charge of updating the status of
			your reported problem and changing it to resolved. </p>
			<div class="page-break"></div>
			<p class="text-info"><b>How  can i ensure that the contents of my report is addressed? </b></p>
			<p class="text-muted">Local authorities have their own page that will reflect on their ability to handle the influx of reports.If yours is unaddressed you could leave a rating  
			and comment though it is suggested that you do so only if your attempts to contact the local authority responsible in your area through the app has been ignored for a week or so.
		    You could also view their page to gain insight on the nature of the problems discussed and focused on by the authorities in your area.</p>
			
			
		  </div>
	</div>
</div>
</body>
</html>