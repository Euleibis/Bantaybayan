package com.bbp;

public class printHtml {
	public String printNavCitizen(String paramUser) {
		String navString = "" +
		 		"<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">" +
		 		"<img class=\"navbar-brand\" src=\"css\\bblogohandshake1CUTWHITE.png\" href=\"#\" width=\"15%\" height=\"15%\"></img>" +
				  "<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">" +
				    "<span class=\"navbar-toggler-icon\"></span>" +
				  "</button>" +
				  "<div class=\"collapse navbar-collapse\" id=\"navbarNav\">" +
				    "<ul class=\"navbar-nav\">" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"index.jsp\">Home</a>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"concernForm2.jsp\">Report/Post</a>" +
				      "</li>" +
				      "<li class=\"nav-item dropdown\">" +
				        "<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" +
				          "Community" +
				        "</a>" +
				        "<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">" +
				          "<a class=\"dropdown-item\" href=\"allDistricts.jsp\">All Districts</a>" +
				        "</div>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"viewCitizen.jsp\">" + paramUser + "</a>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"logoutSession.jsp\">Logout</a>" +
				      "</li>" +
				    "</ul>" +
				  "</div>" +
				"</nav>";
		return navString;
	}
	
	public String printNavDistrict(String paramUser, String paramTitle) {
		String navString = "" +
		 		"<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">" +
		 		"<img class=\"navbar-brand\" src=\"css\\bblogohandshake1CUTWHITE.png\" href=\"#\" width=\"15%\" height=\"15%\"></img>" +
				  "<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">" +
				    "<span class=\"navbar-toggler-icon\"></span>" +
				  "</button>" +
				  "<div class=\"collapse navbar-collapse\" id=\"navbarNav\">" +
				    "<ul class=\"navbar-nav\">" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"index.jsp\">Home</a>" +
				      "</li>" +
				      "<li class=\"nav-item dropdown\">" +
				        "<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" +
				          "Community" +
				        "</a>" +
				        "<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">" +
				          "<a class=\"dropdown-item\" href=\"allDistricts.jsp\">All Districts</a>" +
				        "</div>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"viewDistrict.jsp?title=" + paramTitle + "\">" + paramUser + "</a>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"logoutSession.jsp\">Logout</a>" +
				      "</li>" +
				    "</ul>" +
				  "</div>" +
				"</nav>";
		return navString;
	}
	
	public String printNavNotLoggedIn() {
		String navString = "" +
		 		"<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">" +
				  "<img class=\"navbar-brand\" src=\"css\\bblogohandshake1CUTWHITE.png\" href=\"#\" width=\"15%\" height=\"15%\"></img>" +
				  "<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">" +
				    "<span class=\"navbar-toggler-icon\"></span>" +
				  "</button>" +
				  "<div class=\"collapse navbar-collapse\" id=\"navbarNav\">" +
				    "<ul class=\"navbar-nav\">" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"index.jsp\">Home</a>" +
				      "</li>" +
				      "<li class=\"nav-item dropdown\">" +
				        "<a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" +
				          "Community" +
				        "</a>" +
				        "<div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">" +
				          "<a class=\"dropdown-item\" href=\"allDistricts.jsp\">All Districts</a>" +
				        "</div>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"sign-upForm.jsp\">Sign up</a>" +
				      "</li>" +
				      "<li class=\"nav-item\">" +
				        "<a class=\"nav-link\" href=\"loginForm.jsp\">Login</a>" +
				      "</li>" +
				    "</ul>" +
				  "</div>" +
				"</nav>";
		return navString;
	}
	
	public String printEmailContent(String paramUser, String paramPass) {
		String emailContentString = "" +
							"<body style=\"margin-left:auto;margin-right:auto;\">" +
							"<table style=\"width:640px;\" >" +
							"<tbody>" +
								"<tr style=\"background-color:#DAA520\">" +
									"<td align=\"left\" height=\"48\" style=\"height:48px;padding:24px 0px 24px 16px\" valign=\"middle\">" +
									"<p style=\"Margin:0rem!important;Margin-bottom:0rem!important;font-size:1.8rem;color:#ffffff;line-height:100%;font-family:HelveticaNeue-Light,Helvetica Neue Light,Segoe UI Light,Helvetica Neue,Segoe UI,Helvetica,Arial,sans-serif;\">Automatic notification from BantayBayan</p>" +
									"</td>" +
								"</tr>" +
								"<tr style=\"background-color:#fdfdfd\">" +
									"<td align=\"left\" valign=\"top\">" +
									"<p>&nbsp;</p>" +
									"<p style=\"text-align: center; font-family:HelveticaNeue-Light,Helvetica Neue Light,Segoe UI Light,Helvetica Neue,Segoe UI,Helvetica,Arial,sans-serif;;\">A citizen has directed a concern to your municipality, please head over to this <a href=\"http://localhost:8080/BantayBayanPrototype/loginSession.jsp?username=" + paramUser + "&password=" + paramPass + "\">link</a> to view the concern.</p>" +
									"<p>&nbsp;</p>" +
									"<p>&nbsp;</p>" +
									"</td>" +
								"</tr>" +
							"</tbody>" +
						"</table>" +
					"<table style=\"width:640px\" >" +
							"<tbody>" +
								"<tr>" +
									"<td align=\"left\" valign=\"middle\">" +
									"<p style=\"text-align: center; font-family:HelveticaNeue-Light,Helvetica Neue Light,Segoe UI Light,Helvetica Neue,Segoe UI,Helvetica,Arial,sans-serif;\"><small>This is an automatic notification from BantayBayan.ph. Do not reply. </small></p>" +
									"<p style=\"text-align: center; font-family:HelveticaNeue-Light,Helvetica Neue Light,Segoe UI Light,Helvetica Neue,Segoe UI,Helvetica,Arial,sans-serif;\"><small>BantayBayan Prototype Project. 2017</small></p>" +
									"</td>" +
								"</tr>" +
							"</tbody>" +
						"</table>"+
						"</body>" ;

		return emailContentString;
	}
	
	public String printHead(String pageTitle) {
		String headString = "" +
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
				"<meta name=\"viewport\" content=\"width=device-width\">" +
				"<meta name=\"viewport\" content=\"width=device-width\">" +
				"<meta name=\"description\" content=\"Intermediary public concern sharing website.\">" +
				"<meta name=\"keywords\" content=\"government, community, public concern\">" +
				"<meta name=\"author\" content=\"bb group\">" +
				
				"<title>" + pageTitle + "</title>" +
				
				"<link rel=\"stylesheet\" href=\".//css//bootstrap.css\">" +
				"<link rel=\"stylesheet\" href=\".//css//bootstrap.min.css\">" +
				"<link rel=\"stylesheet\" href=\".//css//styles.css\">" +
				"<link rel=\"stylesheet\" href=\".//css//modal.css\">" ;
		
		return headString;
	}
	
	public String printScripts() {
		String scriptsString = "" +
				"<script src=\"jquery-3.2.1.slim.min.js\"></script>" +
				"<script src=\"popper.min.js\"></script>" +
				"<script src=\"bootstrap.min.js\"></script>" ;
		
		return scriptsString;
	}
}





