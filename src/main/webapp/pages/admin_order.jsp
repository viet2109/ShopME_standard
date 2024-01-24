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
</head>

<body>
	<c:set var="page" value="${requestScope.page }"></c:set>
	<c:set var="totalOrder" value="${totalOrder}"></c:set>
	<c:set var="result" value="${result }"></c:set>
	<c:set var="totalNewOrder" value="${totalNewOrder }"></c:set>
	<fmt:setLocale value="en_US"/>
	<c:set var="revenueOfMonth" value="${revenueOfMonth }"></c:set>
	<c:set var="revenueOfQuarter" value="${revenueOfQuarter }"></c:set>

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
				<jsp:param value="createItem" name="createItem"/>
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
												orders</span> <span class="h3 font-bold mb-0">${fn:length(totalOrder) }</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-tertiary text-white text-lg rounded-circle">
												<i class="fa-solid fa-clipboard-list"></i>
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
												orders</span> <span class="h3 font-bold mb-0">${fn:length(totalNewOrder) }</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-primary text-white text-lg rounded-circle">
												<i class="fa-solid fa-clipboard-check"></i>	
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
					<div class="card shadow border-0 mb-7">
						<div class="card-header">
							<h5 class="mb-0">Applications</h5>
						</div>
						<div class="table-responsive">
							<table class="table table-hover table-nowrap" id="emp-table">
								<thead class="thead-light">
									<tr>
										<th scope="col" col-index=2>Order ID</th>
										<th scope="col" col-index=3>Customer Name</th>
										<th scope="col" col-index=4>Date</th>
										<th scope="col" col-index=5 >Total</th>
										<th scope="col" col-index=6>Payment</th>
										<th col-index=7></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="o" items="${result}">
										<tr>
											<td style="position: relative;right: -1%;"><fmt:formatNumber value="${o.id }" /> </td>
											<td>${o.receiver.lastName } ${o.receiver.firstName }</td>
											<td><fmt:formatDate value="${o.orderDate }" pattern="dd-MM-yyyy"/></td>
											<td data-total="${o.totalOrder() }">$<fmt:formatNumber value="${not empty o.totalOrder() ? o.totalOrder() : 0 }" pattern="#,###.##"/></td>
											<td>${o.payment.name }</td>
											<td>
												<a data-bs-toggle="modal" data-bs-target="#myModal-${o.id }"
													class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
													<span class=" pe-2"> <i class="bi bi-list"></i>
												</span> <span>Detail</span>
												</a>
												<!-- <button type="button" onclick="showSweetAlert()"
													class="btn btn-sm btn-square btn-neutral text-danger-hover ">
													<i class="bi bi-trash"></i>
												</button> -->
												
												<!-- Start Order dialog box --> 
												<div class="modal " id="myModal-${o.id }">
												  <div class="modal-dialog modal-dialog-scrollable modal-lg " style="max-width: 50%; ">
												    <div class="modal-content">
												
												      <!-- Modal Header -->
												      <div class="modal-header">
												        <h4 class="modal-title">Order detail</h4>
												        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
												      </div>
												
												      <!-- Modal body -->
												      <div class="modal-body " style="overflow-x: hidden;">
												      		<div>
												      			<span><strong>Order id:</strong> ${o.id }</span><br>
													      		<span><strong>Orderer's name:</strong> ${o.sender.lastName } ${o.sender.firstName }</span><br>
													      		<span><strong>Email:</strong> ${o.sender.email }</span><br>
													      		<span><strong>Orderer's phone:</strong> ${o.sender.phone }</span><br>
													      		<span><strong>Date:</strong>${o.orderDate}</span><br>
													      		<span class="me-lg-5"><strong>Country: </strong>${o.orderAddress.country }</span>
													      		<span class="me-lg-5"><strong>City: </strong>${o.orderAddress.city }</span>
													      		<span class="me-lg-5"><strong>Ward: </strong>${o.orderAddress.ward }</span><br>
													      		<span class="me-lg-5" style="white-space: pre-wrap;"><strong>Address: </strong>${o.orderAddress.detailAddress }</span><br>
												      			<span><strong>Address phone:</strong> ${o.receiver.phone }</span><br>
												      			<span><strong>Consignee name:</strong> ${o.receiver.lastName } ${o.receiver.firstName }</span><br>
													      		<span><strong>Email:</strong> ${o.receiver.email }</span><br>
												      			<span class="me-lg-5" style="margin-right: 40px"><strong>Total: </strong>$<fmt:formatNumber value="${o.totalOrder() }" pattern="#,###.##" type="currency" currencySymbol="$"/></span>
												      			
												      		</div>
												       		<table class="table table-hover table-nowrap ">
													        	<thead class="thead-light">
													        		<tr>
													        			<th scope="col">STT</th>
													        			<th scope="col">Product Name</th>
													        			<th scope="col">Quantity</th>
													        			<th scope="col">Price</th>
													        			<th scope="col">Total</th>
													        			<th></th>
													        		</tr>
													        	</thead>
													        	<tbody>
													        		<c:forEach items="${o.productAndQuantityList.keySet() }" var="detail" varStatus="loopStatus">
													        			<c:set var="saleprice" value="${o.price.get(detail) }"></c:set> 
													        			<c:set var="quantity" value="${o.productAndQuantityList.get(detail) }"></c:set> 
														        			<tr>
													        				<td>${loopStatus.index + 1 }</td>
														        			<td class="text-capitalize" >${detail.name }</td>
														        			<td>${quantity }</td>
														        			<td>$<fmt:formatNumber value="${saleprice}" pattern="#,###.##" type="currency" currencySymbol="$"/></td>
														        			<td>$<fmt:formatNumber value="${saleprice * quantity }" pattern="#,###.##" type="currency" currencySymbol="$"/></td>
													        			</tr>
													        		</c:forEach>
													        	</tbody>
												        	</table>
												      </div>
												
												      <!-- Modal footer -->
												      <div class="modal-footer">
												        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
												      </div>
												
												    </div>
												  </div>
												</div>
												<!-- End Order dialog box -->
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<div class="card-footer border-0 py-5">
							<span class="text-muted text-sm">Showing ${fn:length(result)} orders out of
								${fn:length(totalOrder)} results found</span>
							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(totalOrder),DynamicPagination.totalOrderOfPage)}"
									name="totalPage" />
								<jsp:param value="${page}" name="currentPage" />
							</jsp:include>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/68d5e1d296.js" crossorigin="anonymous"></script>

	<script type="text/javascript">
	// End Validate of quantity
	</script>
</body>
</html>
