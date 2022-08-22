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
	<p style="padding: 10px; background-color: bisque;"><%=message%></p>
	<%
	session.setAttribute("message", null);
	}
	%>
	<header>
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

			<div class="collapse navbar-collapse" id="my-navbar">
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
		<div class="px-2 py-5 c-heading" data-aos="fade-right"
			data-aos-duration="1400">
			<h1>
				Welcome to <br>BluePilot
			</h1>
			<p>BluePilot Helicopter Flight School has been training all kinds
				of Helicopter pilot since 1999.</p>
			<button data-toggle="modal" data-target="#enquiryModal">Get
				In Touch</button>
		</div>
		<div>
			<h1><b>Something Went Wrong!!</b></h1>
		</div>
	</header>

	<Section id="more">
		<div class="container" data-aos="zoom-in" data-aos-duration="1000">
			<div class="row text-center">
				<div class="col-sm">
					<i class="fa-solid fa-people-group c-icon fa-2x"></i>
					<h5 class="my-2">
						<b>Best Instructor</b>
					</h5>
					<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ut
						ea suscipit natus. Cum, laborum magnam.</p>
				</div>
				<div class="col-sm">
					<i class="fa-solid fa-crosshairs c-icon fa-2x"></i>
					<h5 class="my-2">
						<b>Exciting Locations</b>
					</h5>
					<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
						Aliquid fuga repellendus explicabo, laborum deserunt libero.</p>
				</div>
				<div class="col-sm">
					<i class="fa-solid fa-helicopter c-icon fa-2x"></i>
					<h5 class="my-2">
						<b>Modern Helicpters</b>
					</h5>
					<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
						Aliquid fuga repellendus explicabo, laborum deserunt libero.</p>
				</div>
			</div>
		</div>
	</Section>
	<section id="courses" class="p-4">
		<h2>
			<b>Our Courses</b>
		</h2>
		<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit.
			Deleniti minus molestiae sint aspernatur et dolore?</p>
		<%
		DAO database = new DAO();
		ArrayList<HashMap> courses = database.getAllCourses();
		database.disconnect();

		for (HashMap course : courses) {
		%>
		<div>
			<img src="GetCourseImage?courseName=<%=course.get("name")%>" alt="">
			<p><%=course.get("name")%></p>
			<p><a href = "courseDetails.jsp?courseName=<%=course.get("name")%>" class = "btn btn-primary btn" >Details</a></p>
		</div>

		<%
		}
		%>
	</section>

	<section class="container-fluid text-center my-4" data-aos="fade-up"
		data-aos-duration="1400">
		<h2>
			<b>Gallery</b>
		</h2>
		<p class="px-5">Lorem ipsum dolor sit amet consectetur adipisicing
			elit. Nemo iusto sequi vero ratione fugit tenetur.</p>
		<div class="c-gallery my-4">
			<a href="Resources/hehe5.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe5.jpg" alt=""></a>
			<a href="Resources/hehe6.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe6.jpg" alt=""></a>
			<a href="Resources/hehe5.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe5.jpg" alt=""></a>
			<a href="Resources/hehe6.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe6.jpg" alt=""></a>
			<a href="Resources/hehe5.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe5.jpg" alt=""></a>
			<a href="Resources/hehe6.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="Resources/hehe6.jpg" alt=""></a>
		</div>
	</section>
	<section id="carousel" class="p-3">
		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0"
					class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="Resources/ffff1.jpg" class="d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
						<button id="getintouchbtn" class="btn" data-toggle="modal"
							data-target="#exampleModal">Get in Touch</button>
					</div>
				</div>
				<div class="carousel-item">
					<img src="Resources/ffff2.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="Resources/ffff3.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="Resources/ffff4.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="Resources/ffff5.jpg" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-target="#carouselExampleIndicators" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-target="#carouselExampleIndicators" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</button>
		</div>
	</section>
	<section id="team" class="text-center py-5 px-3">
		<h2>Our Team</h2>
		<p>
			<small>Lorem ipsum dolor sit amet consectetur adipisicing
				elit. Cum saepe neque voluptas tempora quae mollitia velit illo
				nostrum id vitae!</small>
		</p>
		<div class="container">
			<div class="row">
				<div class="col-sm py-3">
					<div class="c-card" data-aos="fade-up" data-aos-duration="1400">
						<img src="Resources/person1.jpg" alt="">
						<p>
							<small>Lorem ipsum dolor sit amet.</small>
						</p>
					</div>
				</div>
				<div class="col-sm py-3">
					<div class="c-card" data-aos="fade-up" data-aos-duration="1400"
						data-aos-delay="200">
						<img src="Resources/person2.jpg" alt="">
						<p>
							<small>Lorem ipsum dolor sit amet.</small>
						</p>
					</div>
				</div>
				<div class="col-sm py-3">
					<div class="c-card" data-aos="fade-up" data-aos-duration="1400"
						data-aos-delay="500">
						<img src="Resources/person3.jpg" alt="">
						<p>
							<small>Lorem ipsum dolor sit amet.</small>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section data-aos="zoom-in" data-aos-duration="1500">
		<iframe
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7016.174511586639!2d77.4986261232599!3d28.44678596342586!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390cc1c64a349f1d%3A0x89f0bdd62e6d8384!2sNSG%20Society%2C%20Greater%20Noida%2C%20Uttar%20Pradesh%20201310!5e0!3m2!1sen!2sin!4v1652767921790!5m2!1sen!2sin"
			height="450" style="border: 0;" allowfullscreen="" loading="lazy"
			referrerpolicy="no-referrer-when-downgrade"></iframe>
	</section>
	<footer class="p-5">
		<div class="container">
			<div class="row">
				<div class="col-sm-5">
					<a href="index.jsp" class="c-logo"> <img
						src="Resources/helicopter_23771.png" alt=""> <span
						id="c-footer-logo">Blue<strong>Pilot</strong></span>
					</a>
					<p>
						<small>ipsum, dolor sit amet consectetur adipisicing elit.
							Obcaecati similique ex impedit perferendis reprehenderit magnam
							perspiciatis dolor labore magni enim.</small>
					</p>
					<p>
						<small>&copy; 2022 Rights Reserved</small>
					</p>
				</div>
				<div class="col-sm-7">
					<h5>Enquiry Now!</h5>
					<form action="AddEnquiry" method="post" class="form-inline">
						<div class="form-group m-1">
							<input type="text" name="name" placeholder="Enter Your Name"
								class="form-control" pattern="[a-zA-Z ]+" maxlength="50"
								minlength="3" required>
						</div>
						<div class="form-group m-1">
							<input type="tel" name="phone"
								placeholder="Enter Your Phone Number" pattern="[0-9]+"
								maxlength="10" minlength="10" class="form-control" required>
						</div>
						<div class="form-group m-1">
							<button type="submit" class="btn form-control">Submit</button>
						</div>
					</form>
					<div class="row mt-5">
						<div class="col">
							<h5>Phone & Address</h5>
							<p>
								<i class="fa-solid fa-location-dot text-warning"></i> Plot-3
								Builders Area, P-6 Greater Noida
							</p>
							<p>
								<i class="fa-solid fa-phone text-warning"></i> 78XXXXXXXX,
								78XXXXXXXX
							</p>
						</div>
						<div class="col">
							<h5>Get Social</h5>
							<p id="c-social">
								<a
									href="https://www.facebook.com/profile.php?id=100008769579005"
									target="_blank"><i class="fa-brands fa-facebook fa-2x"></i></a>
								<a href="https://www.instagram.com/rampal_bhai_/"
									target="_blank"><i class="fa-brands fa-instagram fa-2x"></i></a>
								<a
									href="https://www.youtube.com/channel/UCq4w4pwBLcgTGcoC9KlROuQ"
									target="_blank"><i class="fa-brands fa-youtube fa-2x"></i></a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<a id="c-top-button" href="#"><i
		class="fa-solid fa-circle-chevron-up fa-2x"></i></a>
</body>

<!-- Enquiry Modal -->
<div class="modal fade" id="enquiryModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-light">
				<h5 class="modal-title" id="exampleModalLabel">Enquiry Now!</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="AddEnquiry" method="post" class="form-inline">
					<div class="form-group m-1">
						<input type="text" name="name" pattern="[a-zA-Z ]+" maxlength="50"
							class="form-control" placeholder="Your Name" required />
					</div>
					<div class="form-group m-1">
						<input type="tel" name="phone" pattern="[0-9]+" maxlength="10"
							minlength="10" class="form-control"
							placeholder="Your Phone Number" required />
					</div>
					<div class="form-group m-1">
						<button type="submit" class="form-control btn">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- Enquiry Modal End-->

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

	// Script for Lightbox
	// $(document).on('click', '[data-toggle = "lightbox"]', function(event){
	//     event.PreventDefault();
	//     $(this).ekkoLightbox();
	// });

	//script for AOS
	AOS.init();
</script>
</html>