<%@page import="Utils.MathUtils"%>
<%@page import="java.util.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css?version=3"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css?version=3"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css?version=6"
	rel="stylesheet">
</head>
<body>


	<div class="col-12 col-md-4 mb-5 mb-md-0" style="padding-bottom: 24px;">
		<a class="product-item"
			href="${pageContext.servletContext.contextPath}/products?id=${param.id}&comment_page=1">
			<img
			src="data:image/gif;base64, ${param.src}"
			class="img-fluid product-thumbnail">
			<h3 class="product-title"
				style="text-align: center; text-transform: capitalize;">${param.des }</h3>
			<strong class="product-price">$${param.price }</strong>
		</a>
	</div>

</body>
</html>