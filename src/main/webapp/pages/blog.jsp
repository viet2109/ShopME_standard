<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="author" content="Untree.co">
<link rel="shortcut icon"
	href="${pageContext.servletContext.contextPath}/assets/images/favicon.png">

<meta name="description" content="" />
<meta name="keywords" content="bootstrap, bootstrap4" />

<!-- Bootstrap CSS -->
<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css/?version=1"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css/?version=1"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css/?version=1"
	rel="stylesheet">
<title>Furni Free Bootstrap 5 Template for Furniture and
	Interior Design Websites by Untree.co</title>
</head>

<body>

	<!-- Start Header/Navigation -->
	<jsp:include page="../components/header.jsp"></jsp:include>

	<!-- End Header/Navigation -->

	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">

				<jsp:include page="../components/text_banner.jsp">

					<jsp:param value="Blog" name="title" />
					<jsp:param value="" name="title_sub" />
					<jsp:param
						value="Donec vitae odio quis nisl dapibus malesuada.
							Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor
							tempor tristique."
						name="des" />
				</jsp:include>

				<div class="col-lg-7">
					<div class="hero-img-wrap">
						<img
							src="${pageContext.servletContext.contextPath}/assets/images/couch.png"
							class="img-fluid">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->



	<!-- Start Blog Section -->
	<div class="blog-section">
		<div class="container">

			<div class="row">

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-1.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">First Time Home Owner Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 19, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-2.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">How To Keep Your Furniture Clean</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Robert Fox</a></span> <span>on <a
									href="#">Dec 15, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-3.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">Small Space Furniture Apartment Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 12, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-1.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">First Time Home Owner Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 19, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-2.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">How To Keep Your Furniture Clean</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Robert Fox</a></span> <span>on <a
									href="#">Dec 15, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-3.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">Small Space Furniture Apartment Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 12, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-1.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">First Time Home Owner Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 19, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-2.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">How To Keep Your Furniture Clean</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Robert Fox</a></span> <span>on <a
									href="#">Dec 15, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-sm-6 col-md-4 mb-5">
					<div class="post-entry">
						<a href="#" class="post-thumbnail"><img
							src="${pageContext.servletContext.contextPath}/assets/images/post-3.jpg"
							alt="Image" class="img-fluid"></a>
						<div class="post-content-entry">
							<h3>
								<a href="#">Small Space Furniture Apartment Ideas</a>
							</h3>
							<div class="meta">
								<span>by <a href="#">Kristin Watson</a></span> <span>on <a
									href="#">Dec 12, 2021</a></span>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- End Blog Section -->



	<!-- Start Testimonial Slider -->
	<div class="testimonial-section before-footer-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 mx-auto text-center">
					<h2 class="section-title">Testimonials</h2>
				</div>
			</div>

			<div class="row justify-content-center">
				<div class="col-lg-12">
					<div class="testimonial-slider-wrap text-center">

						<div id="testimonial-nav">
							<span class="prev" data-controls="prev"><span
								class="fa fa-chevron-left"></span></span> <span class="next"
								data-controls="next"><span class="fa fa-chevron-right"></span></span>
						</div>

						<div class="testimonial-slider">

							<div class="item">
								<div class="row justify-content-center">
									<div class="col-lg-8 mx-auto">

										<div class="testimonial-block text-center">
											<blockquote class="mb-5">
												<p>&ldquo;Donec facilisis quam ut purus rutrum lobortis.
													Donec vitae odio quis nisl dapibus malesuada. Nullam ac
													aliquet velit. Aliquam vulputate velit imperdiet dolor
													tempor tristique. Pellentesque habitant morbi tristique
													senectus et netus et malesuada fames ac turpis egestas.
													Integer convallis volutpat dui quis scelerisque.&rdquo;</p>
											</blockquote>

											<div class="author-info">
												<div class="author-pic">
													<img
														src="${pageContext.servletContext.contextPath}/assets/images/person-1.png"
														alt="Maria Jones" class="img-fluid">
												</div>
												<h3 class="font-weight-bold">Maria Jones</h3>
												<span class="position d-block mb-3">CEO, Co-Founder,
													XYZ Inc.</span>
											</div>
										</div>

									</div>
								</div>
							</div>
							<!-- END item -->

							<div class="item">
								<div class="row justify-content-center">
									<div class="col-lg-8 mx-auto">

										<div class="testimonial-block text-center">
											<blockquote class="mb-5">
												<p>&ldquo;Donec facilisis quam ut purus rutrum lobortis.
													Donec vitae odio quis nisl dapibus malesuada. Nullam ac
													aliquet velit. Aliquam vulputate velit imperdiet dolor
													tempor tristique. Pellentesque habitant morbi tristique
													senectus et netus et malesuada fames ac turpis egestas.
													Integer convallis volutpat dui quis scelerisque.&rdquo;</p>
											</blockquote>

											<div class="author-info">
												<div class="author-pic">
													<img
														src="${pageContext.servletContext.contextPath}/assets/images/person-1.png"
														alt="Maria Jones" class="img-fluid">
												</div>
												<h3 class="font-weight-bold">Maria Jones</h3>
												<span class="position d-block mb-3">CEO, Co-Founder,
													XYZ Inc.</span>
											</div>
										</div>

									</div>
								</div>
							</div>
							<!-- END item -->

							<div class="item">
								<div class="row justify-content-center">
									<div class="col-lg-8 mx-auto">

										<div class="testimonial-block text-center">
											<blockquote class="mb-5">
												<p>&ldquo;Donec facilisis quam ut purus rutrum lobortis.
													Donec vitae odio quis nisl dapibus malesuada. Nullam ac
													aliquet velit. Aliquam vulputate velit imperdiet dolor
													tempor tristique. Pellentesque habitant morbi tristique
													senectus et netus et malesuada fames ac turpis egestas.
													Integer convallis volutpat dui quis scelerisque.&rdquo;</p>
											</blockquote>

											<div class="author-info">
												<div class="author-pic">
													<img
														src="${pageContext.servletContext.contextPath}/assets/images/person-1.png"
														alt="Maria Jones" class="img-fluid">
												</div>
												<h3 class="font-weight-bold">Maria Jones</h3>
												<span class="position d-block mb-3">CEO, Co-Founder,
													XYZ Inc.</span>
											</div>
										</div>

									</div>
								</div>
							</div>
							<!-- END item -->

						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Testimonial Slider -->



	<!-- Start Footer Section -->
	<jsp:include page="../components/footer.jsp"></jsp:include>
	<!-- End Footer Section -->


	<script
		src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/tiny-slider.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/custom.js"></script>
</body>
</html>