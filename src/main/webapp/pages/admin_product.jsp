<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="Database.DBConnection"%>
<%@ page import="Utils.DynamicPagination"%>
<%@ page import="Utils.MathUtils"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Responsive Bootstrap Dashboard and Admin Template -
	ByteWebster</title>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/admin.css?version=2">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
</head>

<body>

	<sql:setDataSource var="products" driver="${DBConnection.driver}"
		user="${DBConnection.dbUserName}"
		password="${DBConnection.dbUserPassWord}" url="${DBConnection.dbUri}" />

	<sql:query var="results" dataSource="${products}">
	select * from products
	</sql:query>
	<sql:query var="prd" dataSource="${products}">
	select * from products
	limit ${DynamicPagination.totalProductOfPage}
	offset ${MathUtils.roundUp( (param.page-1) * DynamicPagination.totalProductOfPage, 1)}
	</sql:query>
	<!-- Dashboard -->
	<div
		class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
		<jsp:include page="../components/sidebar_admin.jsp"></jsp:include>
		<!-- Main content -->
		<div class="h-screen flex-grow-1 overflow-y-lg-auto">
			<!-- Header -->
			<jsp:include page="../components/header_admin.jsp"></jsp:include>
			<!-- Main -->
			<main class="py-6 bg-surface-secondary">
				<div class="container-fluid">
					<!-- Card stats -->
					<div class="row g-6 mb-6">
						<div class="col-xl-3 col-sm-6 col-12">
							<div class="card shadow border-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<span
												class="h6 font-semibold text-muted text-sm d-block mb-2">Total
												products</span> <span class="h3 font-bold mb-0">250</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-tertiary text-white text-lg rounded-circle">
												<svg style="fill: #fff" xmlns="http://www.w3.org/2000/svg"
													height="1em" viewBox="0 0 640 512">
													<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
													<path
														d="M64 160C64 89.3 121.3 32 192 32H448c70.7 0 128 57.3 128 128v33.6c-36.5 7.4-64 39.7-64 78.4v48H128V272c0-38.7-27.5-71-64-78.4V160zM544 272c0-20.9 13.4-38.7 32-45.3c5-1.8 10.4-2.7 16-2.7c26.5 0 48 21.5 48 48V448c0 17.7-14.3 32-32 32H576c-17.7 0-32-14.3-32-32H96c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V272c0-26.5 21.5-48 48-48c5.6 0 11 1 16 2.7c18.6 6.6 32 24.4 32 45.3v48 32h32H512h32V320 272z" /></svg>
											</div>
										</div>
									</div>
									<div class="mt-2 mb-0 text-sm">
										<span
											class="badge badge-pill bg-soft-success text-success me-2">
											<i class="bi bi-arrow-up me-1"></i>37%
										</span> <span class="text-nowrap text-xs text-muted">Since
											last month</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6 col-12">
							<div class="card shadow border-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<span
												class="h6 font-semibold text-muted text-sm d-block mb-2">New
												products</span> <span class="h3 font-bold mb-0">320</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-primary text-white text-lg rounded-circle">
												<i class="bi bi-bag-plus"></i>
											</div>
										</div>
									</div>
									<div class="mt-2 mb-0 text-sm">
										<span
											class="badge badge-pill bg-soft-success text-success me-2">
											<i class="bi bi-arrow-up me-1"></i>80%
										</span> <span class="text-nowrap text-xs text-muted">Since
											last month</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6 col-12">
							<div class="card shadow border-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<span
												class="h6 font-semibold text-muted text-sm d-block mb-2">Total
												hours</span> <span class="h3 font-bold mb-0">4.100</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-info text-white text-lg rounded-circle">
												<i class="bi bi-clock-history"></i>
											</div>
										</div>
									</div>
									<div class="mt-2 mb-0 text-sm">
										<span class="badge badge-pill bg-soft-danger text-danger me-2">
											<i class="bi bi-arrow-down me-1"></i>-5%
										</span> <span class="text-nowrap text-xs text-muted">Since
											last month</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6 col-12">
							<div class="card shadow border-0">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<span
												class="h6 font-semibold text-muted text-sm d-block mb-2">Work
												load</span> <span class="h3 font-bold mb-0">88%</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-warning text-white text-lg rounded-circle">
												<i class="bi bi-minecart-loaded"></i>
											</div>
										</div>
									</div>
									<div class="mt-2 mb-0 text-sm">
										<span
											class="badge badge-pill bg-soft-success text-success me-2">
											<i class="bi bi-arrow-up me-1"></i>10%
										</span> <span class="text-nowrap text-xs text-muted">Since
											last month</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card shadow border-0 mb-7">
						<div class="card-header">
							<h5 class="mb-0">Applications</h5>
						</div>
						<div class="table-responsive">
							<table class="table table-hover table-nowrap">
								<thead class="thead-light">
									<tr>
										<th class="txt-cet" scope="col">Name</th>
										<th class="txt-cet" scope="col">Description</th>
										<th class="txt-cet" scope="col">Price</th>
										<th class="txt-cet" scope="col">Percent Sale</th>
										<th class="txt-cet" scope="col">Final Price</th>
										<th class="txt-cet" scope="col">Rate</th>
										<th></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="p" items="${prd.rows}">
										<tr>
											<td><img alt="..." src="${p.image}"
												class="avatar avatar-sm rounded-circle me-2">
												<div class="text-heading font-semibold"
													style="text-transform: capitalize; display: inline-block;">
													${ p.product_name }</div></td>
											<td
												style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">${p.des }</td>
											<td><fmt:setLocale value="en_US" /> <fmt:formatNumber
													maxFractionDigits="2" type="currency" value="${p.price}"></fmt:formatNumber>
											</td>
											<td class="txt-cet"><fmt:formatNumber type="percent"
													value="${(1 - p.percent_sale) }"></fmt:formatNumber></td>
											<td class="txt-cet"><fmt:setLocale value="en_US" /> <fmt:formatNumber
													maxFractionDigits="2" type="currency"
													value="${p.price * (p.percent_sale)}"></fmt:formatNumber></td>
											<td class="txt-cet">${p.rate}</td>

											<td class="text-end"><a href="#"
												class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
													<span class=" pe-2"> <i class="bi bi-pencil"></i>
												</span> <span>Edit</span>
											</a>
												<button type="button" onclick="showSweetAlert()"
													class="btn btn-sm btn-square btn-neutral text-danger-hover">
													<i class="bi bi-trash"></i>
												</button></td>

										</tr>

									</c:forEach>

								</tbody>
							</table>
						</div>
						<div class="card-footer border-0 py-5">
							<span class="text-muted text-sm">Showing
								${fn:length(prd.rows)} products out of
								${fn:length(results.rows)} results found</span>
							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(results.rows),DynamicPagination.totalProductOfPage)}"
									name="totalPage" />
								<jsp:param value="${param.page}" name="currentPage" />
							</jsp:include>

						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
  function showSweetAlert() {
	  Swal.fire({
	    title: 'Are you sure?',
	    text: "You won't be able to revert this!",
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: 'Yes, delete it!'
	  }).then((result) => {
	    if (result.isConfirmed) {
	      Swal.fire(
	        'Deleted!',
	        'Record has been successfully deleted.',
	        'success'
	      )
	    }
	  })
	}</script>
</body>
</html>
