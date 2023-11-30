<%@page import="Database.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">
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
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css"
	rel="stylesheet">
<title>Furni Free Bootstrap 5 Template for Furniture and
	Interior Design Websites by Untree.co</title>
</head>

<body>


	<sql:setDataSource var="products" driver="com.mysql.cj.jdbc.Driver"
		url="${DBConnection.dbUri}" user="${DBConnection.dbUserName}"
		password="${DBConnection.dbUserPassWord}" />

	<sql:query var="results" dataSource="${products}">
		
			SELECT * FROM products
			ORDER BY rate
			limit 3
		
		</sql:query>

	<!-- Start Header/Navigation -->
	<jsp:include page="../components/header.jsp"></jsp:include>
	<!-- End Header/Navigation -->

	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<jsp:include page="../components/text_banner.jsp">

					<jsp:param value="Modern Interior " name="title" />
					<jsp:param value="Monitor" name="title_sub" />
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

	<!-- Start Product Section -->
	<div class="product-section">
		<div class="container">
			<div class="row">



				<!-- Start Column 1 -->
				<div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
					<h2 class="mb-4 section-title">Crafted with excellent
						material.</h2>
					<p class="mb-4">Donec vitae odio quis nisl dapibus malesuada.
						Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor
						tempor tristique.</p>
					<p>
						<a href="shop.html" class="btn">Explore</a>
					</p>
				</div>
				<!-- End Column 1 -->

				<div class="row col-md-12 col-lg-9">

					<c:forEach var="product" items="${results.rows}">

						<jsp:include page="../components/cardProduct.jsp">
							<jsp:param value="${product.id }" name="id" />
							<jsp:param value="${product.image}" name="src" />
							<jsp:param value="${product.product_name }" name="des" />
							<jsp:param value="${product.price }" name="price" />
						</jsp:include>

					</c:forEach>
				</div>



			</div>
		</div>
	</div>
	<!-- End Product Section -->

	<!-- Start Why Choose Us Section -->
	<div class="why-choose-section">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-6">
					<h2 class="section-title">Why Choose Us</h2>
					<p>Donec vitae odio quis nisl dapibus malesuada. Nullam ac
						aliquet velit. Aliquam vulputate velit imperdiet dolor tempor
						tristique.</p>

					<div class="row my-5">
						<div class="col-6 col-md-6">
							<div class="feature">
								<div class="icon">
									<img
										src="${pageContext.servletContext.contextPath}/assets/images/truck.svg"
										alt="Image" class="imf-fluid">
								</div>
								<h3>Fast &amp; Free Shipping</h3>
								<p>Donec vitae odio quis nisl dapibus malesuada. Nullam ac
									aliquet velit. Aliquam vulputate.</p>
							</div>
						</div>

						<div class="col-6 col-md-6">
							<div class="feature">
								<div class="icon">
									<img
										src="${pageContext.servletContext.contextPath}/assets/images/bag.svg"
										alt="Image" class="imf-fluid">
								</div>
								<h3>Easy to Shop</h3>
								<p>Donec vitae odio quis nisl dapibus malesuada. Nullam ac
									aliquet velit. Aliquam vulputate.</p>
							</div>
						</div>

						<div class="col-6 col-md-6">
							<div class="feature">
								<div class="icon">
									<img
										src="${pageContext.servletContext.contextPath}/assets/images/support.svg"
										alt="Image" class="imf-fluid">
								</div>
								<h3>24/7 Support</h3>
								<p>Donec vitae odio quis nisl dapibus malesuada. Nullam ac
									aliquet velit. Aliquam vulputate.</p>
							</div>
						</div>

						<div class="col-6 col-md-6">
							<div class="feature">
								<div class="icon">
									<img
										src="${pageContext.servletContext.contextPath}/assets/images/return.svg"
										alt="Image" class="imf-fluid">
								</div>
								<h3>Hassle Free Returns</h3>
								<p>Donec vitae odio quis nisl dapibus malesuada. Nullam ac
									aliquet velit. Aliquam vulputate.</p>
							</div>
						</div>

					</div>
				</div>

				<div class="col-lg-5">
					<div class="img-wrap">
						<img
							src="${pageContext.servletContext.contextPath}/assets/images/why-choose-us-img.jpg"
							alt="Image" class="img-fluid">
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- End Why Choose Us Section -->

	<!-- Start We Help Section -->
	<div class="we-help-section">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-7 mb-5 mb-lg-0">
					<div class="imgs-grid">
						<div class="grid grid-1">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/img-grid-1.jpg"
								alt="Untree.co">
						</div>
						<div class="grid grid-2">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/img-grid-2.jpg"
								alt="Untree.co">
						</div>
						<div class="grid grid-3">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/img-grid-3.jpg"
								alt="Untree.co">
						</div>
					</div>
				</div>
				<div class="col-lg-5 ps-lg-5">
					<h2 class="section-title mb-4">We Help You Make Modern
						Interior Design</h2>
					<p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae
						odio quis nisl dapibus malesuada. Nullam ac aliquet velit. Aliquam
						vulputate velit imperdiet dolor tempor tristique. Pellentesque
						habitant morbi tristique senectus et netus et malesuada</p>

					<ul class="list-unstyled custom-list my-4">
						<li>Donec vitae odio quis nisl dapibus malesuada</li>
						<li>Donec vitae odio quis nisl dapibus malesuada</li>
						<li>Donec vitae odio quis nisl dapibus malesuada</li>
						<li>Donec vitae odio quis nisl dapibus malesuada</li>
					</ul>
					<p>
						<a herf="#" class="btn">Explore</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- End We Help Section -->

	<!-- Start Popular Product -->
	<div class="popular-product">
		<div class="container">
			<div class="row">

				<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
					<div class="product-item-sm d-flex">
						<div class="thumbnail">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/product-1.png"
								alt="Image" class="img-fluid">
						</div>
						<div class="pt-3">
							<h3>Nordic Chair</h3>
							<p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae
								odio</p>
							<p>
								<a href="#">Read More</a>
							</p>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
					<div class="product-item-sm d-flex">
						<div class="thumbnail">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/product-2.png"
								alt="Image" class="img-fluid">
						</div>
						<div class="pt-3">
							<h3>Kruzo Aero Chair</h3>
							<p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae
								odio</p>
							<p>
								<a href="#">Read More</a>
							</p>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
					<div class="product-item-sm d-flex">
						<div class="thumbnail">
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/product-3.png"
								alt="Image" class="img-fluid">
						</div>
						<div class="pt-3">
							<h3>Ergonomic Chair</h3>
							<p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae
								odio</p>
							<p>
								<a href="#">Read More</a>
							</p>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- End Popular Product -->

	<!-- Start Testimonial Slider -->
	<div class="testimonial-section">
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

	<!-- Start Blog Section -->
	<div class="blog-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-6">
					<h2 class="section-title">Recent Blog</h2>
				</div>
				<div class="col-md-6 text-start text-md-end">
					<a href="#" class="more">View All Posts</a>
				</div>
			</div>

			<div class="row">

				<div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
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

				<div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
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

				<div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
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
