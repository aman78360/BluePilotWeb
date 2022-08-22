<%@page import="com.aman.dao.DAO"%>
<%@page import="java.util.*"%>

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
		<%
		String name = (String) session.getAttribute("name");
		String emailid = (String) session.getAttribute("emailid");
		if (name == null) {
		%>

		<nav class="navbar navbar-expand-sm">
			<a class="c-logo navbar-brand" href="index.jsp"> <img
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
					<li class="nav-item"><a href="index.jsp" class="nav-link">Home</a>
					</li>
					<li class="nav-item"><a href="" class="nav-link"
						data-toggle="modal" data-target="#adminModal">Admin</a></li>
					<li class="nav-item"><a href="user.jsp" class="nav-link">User</a></li>
					<li class="nav-item"><a href="pilot.jsp" class="nav-link">Pilot</a></li>
				</ul>
				<span> <a href="tel: 78XXXXXXXX" class="nav-link">Call
						Us: +91-78XXXXXXXX</a>
				</span>
			</div>
		</nav>

		<%
		} else {
		%>

		<nav class="navbar navbar-expand-sm">
			<a class="c-logo navbar-brand" href="userHome.jsp"> <img
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
					<li class="nav-item"><a href="userHome.jsp" class="nav-link">Home</a>
					</li>
					<li class="nav-item"><a href="allCourses.jsp" class="nav-link">Courses</a></li>
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
			<img src="GetPhoto?emailid=<%=emailid%>&userType=user" height="150px"
				style="border-radius: 10px;">
		</div>
		<%
		}
		%>
	</header>

	<section>

		<%
		String courseName = request.getParameter("courseName");
		DAO database = new DAO();
		HashMap course = database.getCourseByName(courseName);
		TreeSet<String> assignedPilotEmails = database.getAllPilotsEmailByCourse(courseName);
		database.disconnect();
		%>

		<div class="row">
			<div class="col p-4 bg-white">
				<div class="text-center">
					<img alt="" src="GetCourseImage?courseName=<%=course.get("name")%>"
						style="width: 250px;"><br> <br>
					<h3 style="border-top: 1px solid gray">
						<b><%=course.get("name")%></b>
					</h3>
					<p>
						&#8377;
						<%=course.get("fee")%>
						[
						<%=course.get("duration")%>
						]
					</p>
					<p>
						<b><%=course.get("content")%></b>
					</p>

					<div class="p-3">
						<h5>
							<b>Assigned Pilots</b>
						</h5>
						<%
						for (String assignedPilotEmail : assignedPilotEmails) {
						%>

						<img src="GetPhoto?emailid=<%=assignedPilotEmail%>&userType=pilot"
							height="40px" style="border-radius: 10px;">&nbsp;<%=assignedPilotEmail%>
							<a class = "btn btn-info" href = "userConversation.jsp?pilot_email=<%=assignedPilotEmail%>">Ask Questions</a>

						<%
						}
						%>

					</div>
					<%
					if (emailid != null) {
						database = new DAO();
						boolean isRegistered = database.checkCoursesByUser(emailid, courseName);
						if (isRegistered) {

						} else {
					%>
					<form action="UserEnroll" method="post">
						<input type="hidden" name="name" value="<%=course.get("name")%>">
						<button class="btn btn-success">Enroll Now!</button>
					</form>
					<%
					}
					} else {
					%>
					<form action="UserEnroll" method="post">
						<input type="hidden" name="name" value="<%=course.get("name")%>">
						<button class="btn btn-success">Enroll Now!</button>
					</form>
					<%
					}
					%>

				</div>
			</div>
		</div>
	</section>

	<a id="c-top-button" href="#"><i
		class="fa-solid fa-circle-chevron-up fa-2x"></i></a>
</body>

<!-- Admin Modal -->
<div class="modal fade" id="adminModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-light">
				<h5 class="modal-title" id="exampleModalLabel">Admin Login</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="AdminLogin" method="post" class="form-inline">
					<div class="form-group m-1">
						<input type="text" name="adminid" maxlength="20"
							class="form-control" placeholder="Admin ID" required />
					</div>
					<div class="form-group m-1">
						<input type="password" name="password" maxlength="100"
							class="form-control" placeholder="Password" required />
					</div>
					<div class="form-group m-1">
						<button type="submit" class="form-control btn">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- Admin Modal End-->

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

