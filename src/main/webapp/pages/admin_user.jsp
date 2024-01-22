<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<style type="text/css">
	label[required]::before {
           content: '* ';
           color: red; /* Màu sắc của biểu tượng '*' */
       }
</style>
</head>

<body>
	<c:set var="page" value="${empty param.page ? 1: param.page }"></c:set>
	<c:set var="totalUser" value="${totalUser }"></c:set>
	<c:set var="result" value="${result }"></c:set>
	<c:set var="totalNewUser" value="${totalNewUser }"></c:set>
	<c:set var="revenueOfMonth" value="${revenueOfMonth }"></c:set>
	<c:set var="revenueOfQuarter" value="${revenueOfQuarter }"></c:set>
	<c:set var="status" value="${status}" />
	<c:set var="firstName" value="${firstName}" />
	<c:set var="lastName" value="${lastName}" />
	<c:set var="email" value="${email}" />
	<c:set var="phone" value="${phone}" />
	<c:set var="date" value="${date}" />
	<c:set var="pass" value="${pass}" />
	<c:set var="re_pass" value="${re_pass}" />
	<c:set var="roles" value="${roles }" />

	<input required type="hidden" id="status"
		value="${requestScope.status}" />

	<!-- Dashboard -->
	<div
		class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
		<!-- Vertical Navbar -->
		<jsp:include page="../components/sidebar_admin.jsp"></jsp:include>
		<!-- Main content -->
		<div class="h-screen flex-grow-1 overflow-y-lg-auto">
			<!-- Header -->
			<jsp:include page="../components/header_admin.jsp">
				<jsp:param value="createItem" name="createItem" />
			</jsp:include>
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
												users</span> <span class="h3 font-bold mb-0">${fn:length(totalUser) }</span>
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
												users</span> <span class="h3 font-bold mb-0">${fn:length(totalNewUser) }</span>
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
												class="h6 font-semibold text-muted text-sm d-block mb-2">Monthly
												Revenue </span> <span class="h3 font-bold mb-0"><fmt:formatNumber
													value="${revenueOfMonth }" pattern="#,###.###" /></span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-info text-white text-lg rounded-circle">
												<i class="fa-solid fa-hand-holding-dollar"></i>
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
												class="h6 font-semibold text-muted text-sm d-block mb-2">Quarterly
												Revenue </span> <span class="h3 font-bold mb-0"><fmt:formatNumber
													value="${revenueOfQuarter }" pattern="#,###.###" /></span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-warning text-white text-lg rounded-circle">
												<i class="fa-solid fa-square-poll-vertical"></i>
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

					<!-- Start user addition form -->
					<div class="card shadow border-0 mb-7" id="createItem"
						style="display: none;">
						<form class="row"
							action="${pageContext.servletContext.contextPath}/admin/users"
							method="post" id="create-user-form">
							<input type="hidden" name="action" value="insert_user">
							<div class="my-2 ms-5">
								<h5 class="mb-0">Create a new user</h5>
							</div>
							<div class="my-2 px-5">
								<div class="row">
									<div class="form-group col-md-6">
										<label class="control-label" required>First name:</label> <input
											class="form-control" placeholder="Enter first name"
											onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
											required type="text" name="firstName" id="firstName"
											value="${firstName }">
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Last name:</label> <input
											class="form-control" placeholder="Enter last name"
											onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
											required type="text" name="lastName" id="lastName"
											value="${lastName }">
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Email:</label> <input
											class="form-control" placeholder="Enter email"
											onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
											required type="email" name="email" id="email"
											value="${email }">
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Phone:</label> <input
											class="form-control" placeholder="Enter phone"
											onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
											required type="text" name="contact" id="contact"
											value="${phone }">
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Date of birthday:</label> <input
											class="form-control" onblur="handleOnBlur(this)"
											onfocus="handleOnFocus(this)" required type="date"
											placeholder="MM/DD/YYYY" onfocus="(this.type='date')"
											onblur="(this.type='text')" name="dob" id="dob"
											value="${date}">
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Do you want to create an
											admin account or a customer account?</label>
										<div class="radio">
											<label><input type="radio" name="roles" value="0"
												required ${(u.roles==0)?'selected':'' }>Admin</label>
										</div>
										<div class="radio">
											<label><input type="radio" name="roles" value="1"
												required ${(u.roles==0)?'selected':'' }>Customer</label>
										</div>
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Password:</label> <input
											class="form-control" placeholder="Enter password"
											onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
											required type="password" name="pass" id="pass"
											value="${pass}" />
									</div>
									<div class="form-group col-md-6">
										<label class="control-label" required>Repeat your password:</label> <input
											class="form-control" type="password"
											placeholder="Enter repeat your password" required
											type="password" name="re_pass" id="re_pass"
											value="${re_pass }">
									</div>
								</div>
								<div class="d-flex justify-content-end">
									<button type="submit"
										class="submit btn btn-success w-auto my-2 px-5 d-flex justify-content-end">Submit</button>
								</div>
							</div>
						</form>
					</div>
					<!-- End user addition form -->

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
									<c:forEach var="u" items="${result}">
										<tr>
											<td><img alt="..."
												src="${pageContext.servletContext.contextPath}/assets/images/user-avatar.png"
												class="avatar avatar-sm rounded-circle me-2"> <a
												class="text-heading font-semibold" href="#"
												data-bs-target="#showProfile_u${u.id }"
												data-bs-toggle="modal"> ${u.lastName} ${u.firstName} </a></td>
											<td><fmt:formatDate pattern="dd-MM-yyyy"
													value="${u.dob}" /></td>
											<td>${u.email}</td>
											<td>${u.phone}</td>
											<td>${u.roles !=1 ? 'Admin':'User'}</td>

											<td class="text-end"><c:choose>

													<c:when
														test="${sessionScope.user.id == u.id and u.roles != 1}">
													</c:when>

													<c:otherwise>
														<a data-bs-toggle="modal"
															data-bs-target="#showProfile_u${u.id }"
															data-user="${u.id}"
															class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
															<span class=" pe-2"> <i class="bi bi-pencil"></i>
														</span> <span>Edit</span>
														</a>
														<button type="button" onclick="showDeleteConfirmation('delete_user','delete_input',this)"
															data-id="${u.id}"
															class="btn btn-sm btn-square btn-neutral text-danger-hover">
															<i class="bi bi-trash"></i>
														</button>
													</c:otherwise>

												</c:choose> <!-- Start Product dialog box -->
												<div class="modal " id="showProfile_u${u.id }">
													<div class="modal-dialog modal-lg " style="max-width: 50%;">
														<div class="modal-content">

															<!-- Modal Header -->
															<div class="modal-header">
																<h4 class="modal-title">Edit user</h4>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal"></button>
															</div>
															<!-- Modal body -->
															<form
																action="${pageContext.servletContext.contextPath}/admin/users"
																method="post">
																<input type="hidden" value="edit_role" name="action">
																<input type="hidden" value="${u.id }" name="user_id">
																<input type="text" class="d-none" value="${p.id }"
																	name="product_id">
																<div class="modal-body row" style="overflow-x: hidden;">
																	<h3 class="text-center text-dark">Customer
																		Information</h3>
																	<div class="row mt-5 ">
																		<div class="col-md-3">
																			<img alt="..."
																				src="${pageContext.servletContext.contextPath}/assets/images/user-avatar.png"
																				class="avatar avatar-sm rounded-circle me-2"
																				style="width: 100px; height: auto">
																		</div>
																		<div class="col-md-8 text-start">
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Id:</strong>
																				</p>
																				<p class="col-md-4 text-dark">${u.id}</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Name:</strong>
																				</p>
																				<p class="col-md-4 text-dark">${u.lastName }${u.firstName }</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Date of birthday:</strong>
																				</p>
																				<p class="col-md-4 text-dark">${u.dob}</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Email:</strong>
																				</p>
																				<p class="col-md-4 text-dark">${u.email }</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Phone:</strong>
																				</p>
																				<p class="col-md-4 text-dark">${u.phone }</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Create date:</strong>
																				</p>
																				<p class="col-md-4 text-dark">
																					<fmt:formatDate pattern="dd-MM-yyyy"
																						value="${u.createDate}" />
																				</p>
																			</div>
																			<div class="row">
																				<p class="col-md-4 text-dark">
																					<strong>Role:</strong>
																				</p>
																				<div class="form-group col-md-6 ">
																					<select class="form-select" name="role">
																						<option class="text-capitalize" value="${0 }"
																							${(u.roles==0)?'selected':'' }>Admin</option>
																						<option class="text-capitalize" value="${1 }"
																							${(u.roles==1)?'selected':''}
																							${sessionScope.user.id == u.id ? 'disabled' : '' }>User</option>
																					</select>
																				</div>
																			</div>
																		</div>
																	</div>
																	<c:if test="${u.roles == 1 }">
																		<h3 class="text-center text-dark mt-5">Purchase
																			History</h3>
																		<button id="see-more-button-${u.id }" type="button"
																			data-customer-id="${u.id}"
																			data-url="${pageContext.servletContext.contextPath }/admin/users"
																			class="btn btn-primary w-auto justify-content-center align-items-center">See
																			More</button>
																		<div class="row mt-5 " id="purchaseHistory${u.id }"></div>
																	</c:if>
																</div>
																<!-- Modal footer -->
																<div class="modal-footer">
																	<button type="submit"
																		class="submit btn btn-success w-auto my-2 px-5">Submit</button>
																	<button type="button" class="btn btn-danger"
																		data-bs-dismiss="modal">Close</button>
																</div>
															</form>
														</div>
													</div>
												</div> <!-- End Product dialog box --></td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<div class="card-footer border-0 py-5">
							<span class="text-muted text-sm">Showing
								${fn:length(result)} users out of ${fn:length(totalUser)}
								results found</span>
							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(totalUser),DynamicPagination.totalUserOfPage)}"
									name="totalPage" />
								<jsp:param value="${param.page}" name="currentPage" />
							</jsp:include>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- Start delete user -->
	<form id="delete_user"
		action="${pageContext.servletContext.contextPath}/admin/users"
		method="post">
		<input type="hidden" name="action" value="delete" /> <input
			type="hidden" name="user_id" id="delete_input" />

	</form>
	<!-- End delete user -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/admin.js"></script>

</body>
</html>
