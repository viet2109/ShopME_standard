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
	href="${pageContext.servletContext.contextPath}/assets/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
</head>

<body>
	<sql:setDataSource var="users" driver="${DBConnection.driver}"
		user="${DBConnection.dbUserName}"
		password="${DBConnection.dbUserPassWord}" url="${DBConnection.dbUri}" />

	<sql:query var="results" dataSource="${users}">
	select * from customers
	</sql:query>
	<sql:query var="us" dataSource="${users}">
	select * from customers
	limit ${DynamicPagination.totalUserOfPage}
	offset ${MathUtils.roundUp( (param.page-1) * DynamicPagination.totalUserOfPage, 1)}
	</sql:query>
	<!-- Dashboard -->
	<div
		class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
		<!-- Vertical Navbar -->
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
												users</span> <span class="h3 font-bold mb-0">11590</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-tertiary text-white text-lg rounded-circle">
												<i class="bi bi-people"></i>
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
												users</span> <span class="h3 font-bold mb-0">320</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-primary text-white text-lg rounded-circle">
												<i class="bi bi-person-add"></i>
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
										<th scope="col">Name</th>
										<th scope="col">Date</th>
										<th scope="col">Email</th>
										<th scope="col">Phone</th>
										<th scope="col">Role</th>
										<th></th>
									</tr>
								</thead>
								<tbody>


									<c:forEach var="u" items="${us.rows}">
										<tr>
											<td><img alt="..."
												src="${pageContext.servletContext.contextPath}/assets/images/user-avatar.png"
												class="avatar avatar-sm rounded-circle me-2"> <a
												class="text-heading font-semibold" href="#">
													${u.last_name} ${u.first_name} </a></td>
											<td><fmt:formatDate pattern="dd-MM-yyyy"
													value="${u.dob}" /></td>
											<td>${u.email}</td>
											<td>${u.phone}</td>
											<td>${not u.roles eq true?'Admin':'User' }</td>

											<td class="text-end"><c:choose>

													<c:when test="${sessionScope.user.id != u.id and not u.roles eq true}">
													</c:when>

													<c:otherwise>
														<a href="#"
															class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
															<span class=" pe-2"> <i class="bi bi-pencil"></i>
														</span> <span>Edit</span>
														</a>
														<button type="button" onclick="showSweetAlert()"
															class="btn btn-sm btn-square btn-neutral text-danger-hover">
															<i class="bi bi-trash"></i>
														</button>
													</c:otherwise>

												</c:choose></td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<div class="card-footer border-0 py-5">
							<span class="text-muted text-sm">Showing ${fn:length(us.rows)} users out of
								${fn:length(results.rows)} results found</span>
							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(results.rows),DynamicPagination.totalUserOfPage)}"
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
