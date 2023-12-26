<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="lang" value="${lang}" scope="session"></c:set>
<fmt:setLocale value="${lang}" />
<fmt:setBundle basename="Utils.text" />
<!DOCTYPE html>
<html lang="${lang}">
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
				<a href="${pageContext.servletContext.contextPath}/products?page=1"
					class="btn btn-secondary me-2"><fmt:message key="button.shop"></fmt:message></a><a href="#"
					class="btn btn-white-outline"><fmt:message key="button.explore"></fmt:message></a>
			</p>
		</div>
	</div>
</body>
</html>