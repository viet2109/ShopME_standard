<%@page import="java.util.Date"%>
<%@page import="Model.Address"%>
<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css?version=5"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css?version=9"
	rel="stylesheet">

</head>
<body>
	
	
	<c:set var="user" value="${sessionScope.user}"></c:set>
	<c:set var="path"
		value="${fn:split(pageContext.request.requestURI, '/')}"></c:set>
	<c:set var="currentPage" value="${path[fn:length(path) - 1]}"></c:set>


	<nav
		class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark"
		style="position: fixed; top: 0; left: 0; right: 0; height: 84px; z-index: 5"
		aria-label="Furni navigation bar">

		<div class="container">
			<a class="navbar-brand"
				href="${pageContext.servletContext.contextPath}/pages/index.jsp">Furni<span>.</span></a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
				aria-controls="navbarsFurni" aria-expanded="false"
				aria-label="Toggle navigation"
				onclick="document.getElementById(navbarsFurni)?.classList.toggle('show')">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarsFurni" style="">
				<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
					<li class="nav-item ${currentPage eq 'index.jsp' ? 'active' : ''} "><a
						class="nav-link"
						href="${pageContext.servletContext.contextPath}/home">Home</a></li>
					<li class="nav-item ${currentPage eq 'shop.jsp' ? 'active' : ''}"><a
						class="nav-link"
						href="${pageContext.servletContext.contextPath}/products?page=1">Shop</a></li>
					<li class="nav-item ${currentPage eq 'about.jsp' ? 'active' : ''}"><a
						class="nav-link"
						href="${pageContext.servletContext.contextPath}/introduce">About
							us</a></li>
					<li
						class="nav-item ${currentPage eq 'services.jsp' ? 'active' : ''}"><a
						class="nav-link" href="service">Services</a></li>
					<li class="nav-item ${currentPage eq 'blog.jsp' ? 'active' : ''}"><a
						class="nav-link"
						href="${pageContext.servletContext.contextPath}/blog">Blog</a></li>
					<li
						class="nav-item ${currentPage eq 'contact.jsp' ? 'active' : ''}"><a
						class="nav-link"
						href="${pageContext.servletContext.contextPath}/contact">Contact
							us</a></li>
				</ul>

				<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5"
					style="align-items: center;">
					<c:if test="${user != null}">
						<span style="margin-right: 6px; color: #fff">Welcome,
							${user.firstName}</span>
					</c:if>
					<li id="auth"><a class="nav-link" href="#"><img
							src="${pageContext.servletContext.contextPath}/assets/images/user.svg"></a></li>

					<c:if test="${user!=null}">
						<li id="cart-list" style="margin-left: 24px"><a
							class="nav-link"
							href="${pageContext.servletContext.contextPath}/pages/cart.jsp"><img
								src="${pageContext.servletContext.contextPath}/assets/images/cart.svg"></a></li>
					</c:if>

				</ul>
			</div>
		</div>

	</nav>

	<div id="auth-box" style="display: none">

		<div
			style="border-radius: 4px; border-width: 1px; border-color: #E5E7EB; width: 12rem; margin: -5px -9px; overflow: hidden;">

			<c:choose>
				<c:when test="${user==null}">
					<a href="${pageContext.servletContext.contextPath}/login"
						style="display: inline-flex; position: relative; padding-top: 0.5rem; padding-bottom: 0.5rem; padding-left: 1rem; padding-right: 1rem; align-items: center; border-bottom-width: 1px; border-color: #E5E7EB; width: 100%; font-size: 0.875rem; line-height: 1.25rem; font-weight: 500; text-decoration: none; color: #fff; height: 50px"
						onmouseover="this.style.backgroundColor = 'gray'"
						onmouseout="this.style.backgroundColor = 'transparent'"> <!-- style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;"> -->
						<svg xmlns="http://www.w3.org/2000/svg" height="2em"
							viewBox="0 0 512 512"
							style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;">
					<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
					<style>
svg {
	fill: #ffffff
}
</style>
					<path
								d="M217.9 105.9L340.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L217.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1L32 320c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM352 416l64 0c17.7 0 32-14.3 32-32l0-256c0-17.7-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l64 0c53 0 96 43 96 96l0 256c0 53-43 96-96 96l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32z" /></svg>
						Sign in
					</a>
					<a href="${pageContext.servletContext.contextPath}/register"
						style="display: inline-flex; position: relative; padding-top: 0.5rem; padding-bottom: 0.5rem; padding-left: 1rem; padding-right: 1rem; align-items: center; border-bottom-width: 1px; border-color: #E5E7EB; width: 100%; font-size: 0.875rem; line-height: 1.25rem; font-weight: 500; text-decoration: none; color: #fff; height: 50px"
						onmouseover="this.style.backgroundColor = 'gray'"
						onmouseout="this.style.backgroundColor = 'transparent'"> <!-- style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;"> -->
						<svg xmlns="http://www.w3.org/2000/svg" height="2em"
							viewBox="0 0 640 512"
							style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;">
					<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
					<style>
svg {
	fill: #ffffff
}
</style>
					<path
								d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM504 312V248H440c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V136c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H552v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z" /></svg>
						Sign up
					</a>

				</c:when>

				<c:when test="${user!=null}">

					<a href="${pageContext.servletContext.contextPath}/logout"
						style="display: inline-flex; position: relative; padding-top: 0.5rem; padding-bottom: 0.5rem; padding-left: 1rem; padding-right: 1rem; align-items: center; border-bottom-width: 1px; border-color: #E5E7EB; width: 100%; font-size: 0.875rem; line-height: 1.25rem; font-weight: 500; text-decoration: none; color: #fff; height: 50px"
						onmouseover="this.style.backgroundColor = 'gray'"
						onmouseout="this.style.backgroundColor = 'transparent'"> <!-- style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;"> -->
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
							style="fill: #fff; width: 0.75rem; height: 0.75rem; margin-right: 0.625rem">
							<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
							<path
								d="M495.9 166.6c3.2 8.7 .5 18.4-6.4 24.6l-43.3 39.4c1.1 8.3 1.7 16.8 1.7 25.4s-.6 17.1-1.7 25.4l43.3 39.4c6.9 6.2 9.6 15.9 6.4 24.6c-4.4 11.9-9.7 23.3-15.8 34.3l-4.7 8.1c-6.6 11-14 21.4-22.1 31.2c-5.9 7.2-15.7 9.6-24.5 6.8l-55.7-17.7c-13.4 10.3-28.2 18.9-44 25.4l-12.5 57.1c-2 9.1-9 16.3-18.2 17.8c-13.8 2.3-28 3.5-42.5 3.5s-28.7-1.2-42.5-3.5c-9.2-1.5-16.2-8.7-18.2-17.8l-12.5-57.1c-15.8-6.5-30.6-15.1-44-25.4L83.1 425.9c-8.8 2.8-18.6 .3-24.5-6.8c-8.1-9.8-15.5-20.2-22.1-31.2l-4.7-8.1c-6.1-11-11.4-22.4-15.8-34.3c-3.2-8.7-.5-18.4 6.4-24.6l43.3-39.4C64.6 273.1 64 264.6 64 256s.6-17.1 1.7-25.4L22.4 191.2c-6.9-6.2-9.6-15.9-6.4-24.6c4.4-11.9 9.7-23.3 15.8-34.3l4.7-8.1c6.6-11 14-21.4 22.1-31.2c5.9-7.2 15.7-9.6 24.5-6.8l55.7 17.7c13.4-10.3 28.2-18.9 44-25.4l12.5-57.1c2-9.1 9-16.3 18.2-17.8C227.3 1.2 241.5 0 256 0s28.7 1.2 42.5 3.5c9.2 1.5 16.2 8.7 18.2 17.8l12.5 57.1c15.8 6.5 30.6 15.1 44 25.4l55.7-17.7c8.8-2.8 18.6-.3 24.5 6.8c8.1 9.8 15.5 20.2 22.1 31.2l4.7 8.1c6.1 11 11.4 22.4 15.8 34.3zM256 336a80 80 0 1 0 0-160 80 80 0 1 0 0 160z" /></svg>
						Setting account
					</a>

					<a href="${pageContext.servletContext.contextPath}/logout"
						style="display: inline-flex; position: relative; padding-top: 0.5rem; padding-bottom: 0.5rem; padding-left: 1rem; padding-right: 1rem; align-items: center; border-bottom-width: 1px; border-color: #E5E7EB; width: 100%; font-size: 0.875rem; line-height: 1.25rem; font-weight: 500; text-decoration: none; color: #fff; height: 50px"
						onmouseover="this.style.backgroundColor = 'gray'"
						onmouseout="this.style.backgroundColor = 'transparent'"> <!-- style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem;"> -->
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
							style="margin-right: 0.625rem; width: 0.75rem; height: 0.75rem; rotate: 180deg; fill: #fff">
					<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->

					<path
								d="M217.9 105.9L340.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L217.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1L32 320c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM352 416l64 0c17.7 0 32-14.3 32-32l0-256c0-17.7-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l64 0c53 0 96 43 96 96l0 256c0 53-43 96-96 96l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32z" /></svg>
						Log out
					</a>

				</c:when>
			</c:choose>

		</div>
	</div>


	<script
		src="${pageContext.servletContext.contextPath}/assets/js/tiny-slider.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/custom.js"></script>

	<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
	<script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>
	<script>
		// With the above scripts loaded, you can call `tippy()` with a CSS
		// selector and a `content` prop:
		
		tippy('#cart-list', {
			content : 'Cart list',
		});
		const auth = document.getElementById("auth-box");
		tippy('#auth', {
			content : auth.innerHTML,
			allowHTML : true,
			interactive : true
		});
	</script>
</body>
</html>