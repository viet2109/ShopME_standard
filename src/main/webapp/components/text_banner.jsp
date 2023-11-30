<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css"
	rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>
	<div class="col-lg-5">
		<div class="intro-excerpt">
			<h1>
				${param.title} <span class="d-block">${param.title_sub}</span>
			</h1>
			<p class="mb-4">${param.des}</p>
			<p>
				<a href="${pageContext.servletContext.contextPath}/products?page=1" class="btn btn-secondary me-2">Shop Now</a><a href="#"
					class="btn btn-white-outline">Explore</a>
			</p>
		</div>
	</div>
</body>
</html>