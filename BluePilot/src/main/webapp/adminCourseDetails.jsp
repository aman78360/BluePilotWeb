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

	<section>

		<%
		String courseName = request.getParameter("courseName");
		DAO database = new DAO();
		HashMap course = database.getCourseByName(courseName);
		TreeSet<String> emailids = database.getAllPilotsEmail();
		TreeSet<String> assignedPilotEmails = database.getAllPilotsEmailByCourse(courseName);
		database.disconnect();
		%>

		<div class="row">
			<div class="col-4 p-4 bg-warning">
				<div class="text-center">
					<img alt="" src="GetCourseImage?courseName=<%=course.get("name")%>"
						style="width: 250px;"><br> <br>
					<p style="border-top: 1px solid gray">
						<b><%=course.get("name")%></b>
					</p>
					<p>
						&#8377;
						<%=course.get("fee")%>
						[
						<%=course.get("duration")%>
						]
					</p>
				</div>
				<div class="p-3">
					<h5>
						<b>Assigned Pilots</b>
					</h5>
					<%
					for (String assignedPilotEmail : assignedPilotEmails) {
					%>

					<img src="GetPhoto?emailid=<%=assignedPilotEmail%>&userType=pilot"
						height="40px" style="border-radius: 10px;">&nbsp;<%=assignedPilotEmail%><br>

					<%
					}
					%>

				</div>
				<div class="bg-light p-3">
					<h5>
						<b>Assign a New Pilots</b>
					</h5>
					<form action="AssignPilotCourse" method="post" class="form-group"
						enctype="multipart/form-data">
						<div class="form-group m-2">
							<select name="pilot_email" class="form-control">

								<%
								for (String emailid : emailids) {
								%>
								<option><%=emailid%></option>
								<%
								}
								%>
							</select>
						</div>

						<input type="hidden" name="course_name"
							value="<%=course.get("name")%>" />
						<button type="submit" class="form-control btn btn-primary">Assign
							Pilot</button>

					</form>
				</div>
			</div>

			<div class="col-5 p-4">
				<div class="py-3 text-center bg-white text-dark">
					<h4>
						<b>Update Course</b>
					</h4>
				</div>
				<form action="UpdateCourse" method="post" class="form-group"
					enctype="multipart/form-data">
					<div class="form-group m-2">
						<label>Course Name: </label> <input type="text" name="name"
							value="<%=course.get("name")%>" pattern="[a-zA-Z ]+"
							maxlength="50" class="form-control" placeholder="Course Name"
							required />
					</div>
					<div class="form-group m-2">
						<label>Course Fee: </label> <input type="number" name="fee"
							value="<%=course.get("fee")%>" pattern="[0-9]+" maxlength="10"
							minlength="0" class="form-control" placeholder="Course Fee"
							required />
					</div>
					<div class="form-group m-2">
						<label>Course Duration: </label> <input type="text"
							name="duration" value="<%=course.get("duration")%>"
							maxlength="50" class="form-control" placeholder="Course Duration"
							required />
					</div>
					<div class="form-group m-2">
						<label>Course Content: </label>
						<textarea rows="5" name="content" class="form-control"
							placeholder="Course Content" required><%=course.get("content")%></textarea>
					</div>
					<div class="form-group m-2">
						<label>Course Image: </label> <input type="file" name="image"
							class="form-control" />
					</div>
					<div class="form-group m-2">
						<input type="hidden" name="oldName"
							value="<%=course.get("name")%>" />
						<button type="submit" class="form-control btn btn-primary">Update
							Course</button>
					</div>
				</form>
			</div>
		</div>


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
