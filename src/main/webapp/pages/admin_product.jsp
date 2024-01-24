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
	href="${pageContext.servletContext.contextPath}/assets/css/admin.css?version=2">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<style>
#productSeller {
	animation-duration: 5s;
	animation-name: slidein;
	animation-iteration-count: infinite; /* Lặp vô hạn */
	white-space: nowrap; /* Ngăn chữ xuống hàng */
	overflow: hidden; /* Ẩn nội dung vượt quá kích thước */
	text-overflow: ellipsis;
	/* Hiển thị dấu ba chấm (...) khi chữ vượt quá */
}

@keyframes slidein {from { margin-left:100%;
	
}

to {
	margin-left: -150%;
}

}
label[required]::after {
	content: '* ';
	color: red; /* Màu sắc của biểu tượng '*' */
}
</style>
</head>

<body>
	<c:set var="page" value="${requestScope.page}"></c:set>
	<c:set var="totalProduct" value="${totalProduct}"></c:set>
	<c:set var="result" value="${result}"></c:set>
	<c:set var="categories" value="${categories}"></c:set>
	<c:set var="status" value="${status }"></c:set>
	<c:set var="revenueOfMonth" value="${revenueOfMonth }"></c:set>
	<c:set var="revenueOfQuarter" value="${revenueOfQuarter }"></c:set>
	<c:set var="productBestSale" value="${productBestSale }"></c:set>
	<input type="hidden" id="status" value="${status }">

	<div
		class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
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
												products</span> <span class="h3 font-bold mb-0">${fn:length(totalProduct)}</span>
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
										<div
											class="col overflow-hidden text-overflow-ellipsis white-space-nowrap">
											<span
												class="h6 font-semibold text-muted text-sm d-block mb-2">BestSeller
												product</span> <span id="productSeller"
												class="h3 font-bold mb-0 text-capitalize">${productBestSale.name }</span>
										</div>
										<div class="col-auto">
											<div
												class="icon icon-shape bg-primary text-white text-lg rounded-circle">
												<i class="fa-solid fa-medal"></i>
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

					<!-- Start product create form -->
					<div class="card shadow border-0 mb-7" id="createItem"
						style="display: none;">
						<form class="row"
							action="${pageContext.servletContext.contextPath}/admin/products?page=${page}"
							method="post" enctype="multipart/form-data">
							<input type="hidden" value="add_product" name="action">
							<div class="my-2 ms-5">
								<h5 class="mb-0">Create a new product</h5>
							</div>
							<!-- Start Add Category button -->
							<div class="row my-2 px-5">
								<div class="col">
									<a data-bs-toggle="modal" data-bs-target="#addCategoryModal"
										class="btn btn-primary d-inline-flex btn-sm border-base mx-1">
										<span class=" pe-2"> <i class="bi bi-plus-circle-fill"></i>
									</span> <span>Add Category</span>
									</a>
								</div>
							</div>
							<!-- End Add Category button -->
							<div class="my-2 px-5">
								<div class="row">
									<div class="form-group col-md-3">
										<label class="control-label" required>Product's name</label>
										<input class="form-control" type="text" name="productName"
											required>
									</div>
									<div class="form-group col-md-3">
										<label class="control-label" required>Category</label> <select
											class="form-select" name="category">
											<option selected>--Open this category menu--</option>
											<c:forEach var="category" items="${categories }">
												<option class="text-capitalize" value="${category.id }">${category.name }</option>
											</c:forEach>
										</select>
									</div>
									<div class="form-group col-md-3">
										<label class="control-label" required>Price</label> <input
											class="form-control" type="number" step="0.01" name="price"
											required>
									</div>
									<div class="form-group col-md-3">
										<label class="control-label" required>Percent price</label> <input
											class="form-control" type="number" step="0.01"
											name="percentPrice" required>
									</div>
								</div>
								<div class="form-group col-md-6">
									<label for="fileInput" class="control-label" required>Choose
										a file</label> <input type="file" accept="image/*" class="form-control" id="image"
										name="image" required>
								</div>
								<div class="row">
									<label class="control-label" required>Descriptions</label>
									<div class="form-floating">
										<textarea class="form-control"
											placeholder="Product description" id="floatingTextarea"
											name="description" style="height: 100px" required></textarea>
									</div>
								</div>
								<button type="submit"
									class="submit btn btn-success w-auto my-2 px-5 d-flex justify-content-end">Submit</button>
							</div>
						</form>
					</div>
					<!-- End product create form -->


					<div class="card shadow border-0 mb-7">
						<div class="card-header">
							<h5 class="mb-0">Applications ${status }</h5>
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
									<c:forEach var="p" items="${result}">
										<tr>
											<td><img alt="..."
												src="data:image/gif;base64,${MathUtils.covertBlobToByteString(p.image)}"
												class="avatar avatar-sm rounded-circle me-2">
												<div class="text-heading font-semibold"
													style="text-transform: capitalize; display: inline-block;">
													${ p.name }</div></td>
											<td
												style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">${p.des }</td>
											<td><fmt:setLocale value="en_US" /> <fmt:formatNumber
													maxFractionDigits="2" type="currency" value="${p.price}"></fmt:formatNumber>
											</td>
											<td class="txt-cet"><fmt:formatNumber type="percent"
													value="${(1 - p.percentSale) }"></fmt:formatNumber></td>
											<td class="txt-cet"><fmt:setLocale value="en_US" /> <fmt:formatNumber
													maxFractionDigits="2" type="currency"
													value="${p.price * p.percentSale}"></fmt:formatNumber></td>
											<td class="txt-cet">${p.rate}</td>

											<td class="text-end"><a data-bs-toggle="modal"
												data-bs-target="#myModal-${p.id }"
												class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
													<span class=" pe-2"> <i class="bi bi-pencil"></i>
												</span> <span>Edit</span>
											</a>
												<button type="button"
													onclick="showDeleteConfirmation('delete_product', 'delete_product_input', this)"
													class="btn btn-sm btn-square btn-neutral text-danger-hover"
													data-id="${p.id }">
													<i class="bi bi-trash"></i>
												</button> <!-- Start Product dialog box -->
												<div class="modal " id="myModal-${p.id }">
													<div class="modal-dialog modal-dialog-scrollable modal-lg "
														style="max-width: 50%;">
														<div class="modal-content">

															<!-- Modal Header -->
															<div class="modal-header">
																<h4 class="modal-title">Edit product</h4>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal"></button>
															</div>
															<!-- Modal body -->
															<form
																action="${pageContext.servletContext.contextPath}/admin/products?page=${page}"
																method="post" enctype="multipart/form-data">
																<input type="hidden" name="action" value="edit_product">
																<input type="text" class="d-none" value="${p.id }"
																	name="product_id">
																<div class="modal-body row" style="overflow-x: hidden;">
																	<div class="form-group col-md-6 ">
																		<label class="form-label d-flex justify-content-start">Product
																			name<span class="text-danger">*</span>
																		</label> <input type="text" class="form-control"
																			name="productName" value="${p.name }">
																	</div>
																	<div class="form-group col-md-6 ">
																		<label class="form-label d-flex justify-content-start">Category<span
																			class="text-danger">*</span></label> <select
																			class="form-select" name="category">
																			<c:forEach var="category" items="${categories }">
																				<option class="text-capitalize"
																					value="${category.id }"
																					${(p.categoryId==category.id)?'selected':'' }>${category.name }</option>
																			</c:forEach>
																		</select>
																	</div>
																	<div class="form-group col-md-6">
																		<label class="form-label d-flex justify-content-start">Price<span
																			class="text-danger">*</span></label> <input type="number"
																			class="form-control" name="price" value="${p.price }"
																			step="0.01">
																	</div>
																	<div class="form-group col-md-6">
																		<label class="form-label d-flex justify-content-start">Percent
																			sale<span class="text-danger">*</span>
																		</label> <input type="number" class="form-control"
																			name="percentPrice" value="${p.percentSale }"
																			step="0.01">
																	</div>
																	<div class="form-group d-flex flex-column">
																		<label for="fileInput"
																			class="form-label d-flex justify-content-start">Choose
																			a file<span class="text-danger">*</span>
																		</label> <input type="file" accept="image/*" class="form-control"
																			id="fileInput" name="image" value="">
																	</div>
																	<div class="form-group">
																		<label class="form-label d-flex justify-content-start">Descriptions<span
																			class="text-danger">*</span></label>
																		<div class="form-floating">
																			<textarea class="form-control"
																				placeholder="Product description"
																				id="floatingTextarea" name="description"
																				style="min-height: 200px">${p.des }</textarea>
																		</div>
																	</div>
																	<!-- Modal footer -->
																	<div class="modal-footer">
																		<button type="submit"
																			class="submit btn btn-success w-auto my-2 px-5" >Submit</button>
																		<button type="button" class="btn btn-danger"
																			data-bs-dismiss="modal">Close</button>
																	</div>
																</div>
															</form>
														</div>
													</div>
													<!-- End Product dialog box --></td>

										</tr>

									</c:forEach>

								</tbody>
							</table>
						</div>
						<div class="card-footer border-0 py-5">
							<span class="text-muted text-sm">Showing
								${fn:length(result)} products out of ${fn:length(totalProduct)}
								results found</span>
							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(totalProduct),DynamicPagination.totalProductOfPage)}"
									name="totalPage" />
								<jsp:param value="${page}" name="currentPage" />

							</jsp:include>

						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- MODAL ADD CATEGORY -->
	<div class="modal" id="addCategoryModal">
		<div class="modal-dialog modal-dialog-scrollable modal-lg "
			style="max-width: 50%;">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Category</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body " style="overflow-x: hidden;">
					<form
						action="${pageContext.servletContext.contextPath}/admin/products"
						method="post">
						<input type="hidden" name="action" value="insert_category" />
						<div class="mb-3 mt-3">
							<label for="categoryNameInput" class="form-lable" required>Category's
								name</label> <input type="text" class="form-control"
								id="categoryNameInput" name="categoryNameInput"
								required="required" />
						</div>
						<div class="d-flex justify-content-end">
							<button type="submit" class="btn btn-success mx-2">Save</button>
							<button type="button" class="btn btn-danger cancel mx-2"
								id="delete" onclick="deleteConfirmation()">Delete</button>
						</div>
					</form>
					<div class="mb-3">
						<label for="cate_table" class="form-lable">Existing
							product category</label>
						<table class="table table-hover table-nowrap " name="cate_table">
							<thead>
								<tr>
									<th scope="col" class="col-2">STT</th>
									<th scope="col" class="col-8">Category Name</th>
									<th scope="col" class="col-2"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${categories }" var="category"
									varStatus="loopStatus">
									<tr>
										<td>${loopStatus.index + 1 }</td>
										<td class="text-capitalize">${category.name }</td>
										<td class="text-end"><a href="#"
											class="btn d-inline-flex btn-sm btn-neutral border-base mx-1">
												<span class=" pe-2"> <i class="bi bi-pencil"></i>
											</span> <span>Edit</span>
										</a>
											<button type="button"
												onclick="showDeleteConfirmation('delete_category', 'delete_category_input', this)"
												data-id="${category.id}"
												class="btn btn-sm btn-square btn-neutral text-danger-hover ">
												<i class="bi bi-trash"></i>
											</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<!-- END MODAL ADD CATEGORY -->

	<form id="delete_category"
		action="${pageContext.servletContext.contextPath}/admin/products"
		method="post">
		<input type="hidden" name="action" value="delete_category" /> <input
			type="hidden" name="delete_category_input" id="delete_category_input" />
	</form>
	<form id="delete_product"
		action="${pageContext.servletContext.contextPath}/admin/products"
		method="post">
		<input type="hidden" name="action" value="delete_product" /> <input
			type="hidden" name="delete_category_input" id="delete_product_input" />
	</form>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/admin.js?version=2"></script>
	<script type="text/javascript">
		const isDeleted = localStorage.getItem("delete");

		if (localStorage.getItem("delete") === 'true') {
			if (status == "delete_failed") {
				Swal.fire('Cannot Delete!', 'Record cannot be deleted.',
						'error');
			} else {
				Swal.fire('Deleted!', 'Record has been successfully deleted.',
						'success');
			}
			localStorage.removeItem("delete");
		}
	</script>
</body>
</html>
