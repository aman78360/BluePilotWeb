
<%@page import="com.aman.dao.DAO"%>
<%@page import="java.util.*"%>
<%
String name = (String) session.getAttribute("name");
String emailid = (String) session.getAttribute("emailid");
if (name == null) {
	session.setAttribute("message", "Please Login First!");
	response.sendRedirect("pilot.jsp");
} else {
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BluePilot</title>
<!-- AOS CDN -->
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- AOS CDN End -->

<!-- JQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- JQuery CDN End -->

<!-- BootStrap CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- BootStrap CDN End -->
<!-- Fav Icon -->
<link rel="icon" href="Resources/helicopter_23771.png">
<!-- Fav Icon End -->

<!-- font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js"
	integrity="sha512-6PM0qYu5KExuNcKt5bURAoT6KCThUmHRewN3zUFNaoI6Di7XJPTMoT6K0nsagZKk2OB4L7E3q1uQKHNHd4stIQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Font Awesome End -->

<!-- Ligthbox  CSS & Script -->
<script src="Resources/lightbox/ekko-lightbox.js"></script>
<link rel="stylesheet" href="Resources/lightbox/ekko-lightbox.css">
<!-- Lightbox End -->



<!-- Custom CSS & JS  -->
<link rel="stylesheet" href="Resources/custom.css">
<script src="script.js"></script>
<!-- Custom CSS & JS End -->

<!--  Google Font-->
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans&display=swap"
	rel="stylesheet">
<!-- Google Font End -->

<meta name="author" content="Aman Gupta">
<meta name="description" content="Website for Pilot Courses">
<meta name="keywords" content="best pilot training in the world">
</head>
<body>
	<%
	String message = (String) session.getAttribute("message");
	if (message != null) {
	%>
	<p style="padding: 10px; background-color: bisque;">
		<%=message%></p>
	<%
	session.setAttribute("message", null);
	}
	%>

	<header>
		<nav class="navbar navbar-expand-sm">
			<a class="c-logo navbar-brand" href="pilotHome.jsp"> <img
				src="Resources/helicopter_23771.png" alt=""> <span>Blue
					<strong>Pilot</strong>
			</span>
			</a>
			<button class="navbar-toggler text-white" type="button"
				data-toggle="collapse" data-target="#my-navbar">
				<i class="fa-solid fa-bars"></i> Menu
			</button>

			<div class="collapse navbar-collapse text-white" id="my-navbar">
				<ul class="navbar-nav mx-auto">
					<li class="nav-item"><a href="pilotHome.jsp" class="nav-link">Home</a>
					</li>
				</ul>
				<span> <a href="Logout" class="btn btn-dark"><b>Logout</b></a>
				</span>
			</div>
		</nav>
		<div class="px-2 py-2 c-heading">
			<h1>
				<b>Welcome <br><%=name%></b>
			</h1>
		</div>
		<div class="px-2 py-2 c-heading">
			<img src="GetPhoto?emailid=<%=emailid%>&userType=pilot"
				height="150px" style="border-radius: 10px;">
		</div>
	</header>

	<section>
		<%
		DAO database = new DAO();
		String status = database.getPilotStatus(emailid);
		database.disconnect();
		%>
		<h5 class="p-2 bg-danger text-white">
			Status: <b><%=status%></b>
		</h5>

		<%
		if (status.equalsIgnoreCase("accepted")) {
		%>

		<section>

			<div class="row">
				<div class="col-4 p-4 bg-warning">
					<%
					database = new DAO();
					String user_email = request.getParameter("user_email");
					HashMap user = database.getUserByEmailid(user_email);
					%>
					<p>
						<img src="GetPhoto?emailid=<%=user_email%>&userType=user"
							style="height: 50px; width: 50px; border-radius: 10px; object-fit: cover; object-position: center;">
						<b>Name:</b>&nbsp;<%=user.get("name")%>
					<p>
						<b>Age:</b>&nbsp;<%=user.get("age")%></p>
					<p>
						<b>Phone:</b>&nbsp;<%=user.get("phone")%></p>
					<p>
						<b>Gender:</b>&nbsp;<%=user.get("gender")%></p>
					</p>
					<p>
						<b>Address:</b>&nbsp;<%=user.get("address")%>
					</p>
				</div>

				<div class="col-7 p-4 bg-light">

					<h4 class="text-center p-2">
						<b>Conversation</b>
					</h4>

					<%
					database = new DAO();
					ArrayList<HashMap> conversations = database.getConversation(emailid, user_email);
					database.disconnect();

					for (HashMap conversation : conversations) {
					%>
					<div
						class="py-3 px-3 my-1 bg-dark text-white border border-primary"
						style="border-radius: 20px">
						<p>
							<b>Question:</b>&nbsp;[<%=conversation.get("question_date")%>]<br>
							<%=conversation.get("question")%>
						</p>

						<%
						if (conversation.get("answer") == null) {
						%>

						<form action="Answer" method="post" class="form-group"
							enctype="multipart/form-data">
							<div class="form-group m-2">
								<label>Reply: </label>
								<textarea name="answer" rows="5" class="form-control"></textarea>
							</div>
							<input type="hidden" name="user_email" value="<%=user_email%>" />
							<input type="hidden" name="id" value="<%=conversation.get("id")%>" />
							<button type="submit" class="form-control btn btn-primary">Submit</button>
						</form>


						<%
						} else {
						%>
						<p>
							<b>Answer:</b>&nbsp;<br>
							<%=conversation.get("answer")%>
						</p>
						<%
						}
						%>
					</div>

					<%
					}
					%>

				</div>
			</div>
		</section>
		<%
		}
		%>
	</section>

	<a id="c-top-button" href="#"><i
		class="fa-solid fa-circle-chevron-up fa-2x"></i></a>
</body>

<script>
	// Script for Scroll Button Fading
	$(window).scroll(function() {
		if ($(this).scrollTop()) {
			$("#c-top-button").fadeIn()
		} else {
			$("#c-top-button").fadeOut()
		}
	})

	// Script for Scroll to Top
	$("#c-top-button").click(function() {
		$("html, body").animate({
			scrollTop : 0
		}, 2000)
	})

	//script for AOS
	AOS.init();
</script>
</html>
<%
}
%>