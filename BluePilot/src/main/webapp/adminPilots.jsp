
<%@page import="com.aman.dao.DAO"%>
<%@page import="java.util.*"%>
<%
String name = (String) session.getAttribute("name");
if (name == null) {
	session.setAttribute("message", "Please Login First!");
	response.sendRedirect("index.jsp");
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

	<header>
		<nav class="navbar navbar-expand-sm">
			<a class="c-logo navbar-brand" href="adminHome.jsp"> <img
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
					<li class="nav-item"><a href="adminHome.jsp" class="nav-link">Home</a>
					</li>
					<li class="nav-item"><a href="adminCourses.jsp"
						class="nav-link">Courses</a></li>
					<li class="nav-item"><a href="adminPilots.jsp"
						class="nav-link">Pilots</a></li>
					<!-- <li class="nav-item"><a href="Logout" class="nav-link">Logout</a></li> -->
				</ul>
				<span> <a href="Logout" class="btn btn-dark"><b>Logout</b></a>
				</span>
			</div>
		</nav>
		<div class="px-2 py-5 c-heading">
			<h1>
				<b>Welcome <br><%=name%></b>
			</h1>
		</div>
	</header>

	<section id="enquiries">
		<h2 class="py-4 px-4">
			<b>All Pilots</b>
		</h2>
		<%
		DAO database = new DAO();
		ArrayList<HashMap> pilots = database.getAllPilots();
		database.disconnect();

		for (HashMap pilot : pilots) {
		%>
		<div class="py-3 px-3 my-1">
			<p>
				<img src="GetPhoto?emailid=<%=pilot.get("emailid")%>&userType=pilot"
					style="height: 50px; width: 50px; border-radius: 10px; object-fit: cover; object-position: center;">&nbsp;
				<b><%=pilot.get("name")%></b>, Phone No:&nbsp;<%=pilot.get("phone")%>,&nbsp;
				Experience:&nbsp;<%=pilot.get("experience")%>
				Years,&nbsp; Gender:&nbsp;<%=pilot.get("gender")%>&nbsp; [<%=pilot.get("status")%>]
				<%
				if (pilot.get("status").equals("pending")) {
				%>
				<a class="btn btn-success mx-1"
					href="PilotStatusUpdate?emailid=<%=pilot.get("emailid")%>&status=accepted">Accept</a>
				<a class="btn btn-danger mx-1"
					href="PilotStatusUpdate?emailid=<%=pilot.get("emailid")%>&status=rejected">Reject</a>
				<%
				}
				%>
			</p>
		</div>

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