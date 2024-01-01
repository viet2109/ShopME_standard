<%@page import="Utils.MathUtils"%>
<%@page import="DAO.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Database.DBConnection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="author" content="Untree.co">
<meta name="description" content="" />
<meta name="keywords" content="bootstrap, bootstrap4" />
<link rel="shortcut icon"
	href="${pageContext.servletContext.contextPath}/assets/images/favicon.png">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>

<!-- Bootstrap CSS -->

<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css/?version=1"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css/?version=1"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css/?version=6"
	rel="stylesheet">
<title>Furni Free Bootstrap 5 Template for Furniture and
	Interior Design Websites by Untree.co</title>
</head>

<body>



	<c:set var="results" value="${sessionScope.cart}"></c:set>
	<c:set var="subtotal"
		value="${MathUtils.totalPriceCart(sessionScope.cart)}"></c:set>


	<!-- Start Header/Navigation -->
	<jsp:include page="../components/header.jsp"></jsp:include>
	<!-- End Header/Navigation -->

	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>Cart</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->



	<div class="untree_co-section before-footer-section">
		<div class="container">

			<c:choose>
				<c:when test="${fn:length(results.product_quantity)>0}">
					<div class="row mb-5">
						<div class="col-md-12">
							<div class="site-blocks-table"
								style="max-height: 1000px; overflow: auto;">
								<table class="table">
									<thead>
										<tr>
											<th></th>
											<th class="product-thumbnail">Image</th>
											<th class="product-name">Product</th>
											<th class="product-price">Price</th>
											<th class="product-quantity">Quantity</th>
											<th class="product-total">Total</th>
											<th class="product-remove">Remove</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="cd" items="${results.product_quantity}">
											<tr style="max-height: 200px">
												<td><input
													style="width: 20px; height: 20px; cursor: pointer;"
													id="check-product-${cd.key.id}" type="checkbox"
													${results.product_selected.get(cd.key) == 1?'checked':''}
													onchange="updateProduct(${cd.key.id}, ${cd.value}, this.checked?1:0)" /></td>
												<td class="product-thumbnail"><img
													src="data:image/gif;base64,${MathUtils.covertBlobToByteString(cd.key.image)}"
													alt="Image" class="img-fluid"></td>
												<td class="product-name">
													<h2 style="text-transform: capitalize;"
														class="h5 text-black">${cd.key.name}</h2>
												</td>
												<td><fmt:setLocale value="en_US" /> <fmt:formatNumber
														maxFractionDigits="2" type="currency"
														value="${cd.key.price*cd.key.percentSale}"></fmt:formatNumber></td>
												<td>
													<div
														class="input-group mb-3 d-flex align-items-center quantity-container"
														style="max-width: 120px; margin: 0 auto;">
														<div class="input-group-prepend">
															<button class="btn btn-outline-black decrease"
																type="button">&minus;</button>
														</div>
														<input style="border: none; background: transparent;"
															type="number" inputmode="none"
															class="form-control text-center quantity-amount"
															value="${cd.value}" placeholder=""
															aria-label="Example text with button addon"
															aria-describedby="button-addon1" data-id="${cd.key.id}"
															onchange="updateProduct(${cd.key.id},this.value, ${results.product_selected.get(cd.key)})"
															onblur="this.value=this.value===''?1:this.value">
														<div class="input-group-append">
															<button class="btn btn-outline-black increase"
																type="button">&plus;</button>
														</div>
													</div>

												</td>
												<td><fmt:setLocale value="en_US" />

													<div class="totalPrice">
														<fmt:formatNumber maxFractionDigits="2" type="currency"
															value="${cd.key.price*cd.key.percentSale*cd.value}"></fmt:formatNumber>
													</div></td>
												<td>


													<button type="button" onclick="showSweetAlert(this)"
														class="delete-btn" data-product="${cd.key.id}">
														<i class="bi bi-trash"></i>
													</button>




												</td>
											</tr>



										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>
					</div>

					<form id="delete_product"
						action="${pageContext.servletContext.contextPath}/cart"
						method="post">
						<input type="hidden" name="action" value="delete" /> <input
							type="hidden" name="product-id" value="1" id="delete_input" />

					</form>


					<form id="update_product"
						action="${pageContext.servletContext.contextPath}/cart"
						method="post">
						<input type="hidden" name="action" value="insert" /> <input
							type="hidden" name="product-id" value="1" id="update_input_id" />
						<input type="hidden" name="product-quantity" value="1"
							id="update_input_quantity" /> <input type="hidden"
							name="product-selected" value="0" id="update_input_selected" />

					</form>

					<div class="row">
						<div class="col-md-6">
							<div class="row mb-5">

								<div class="col-md-6">
									<button style="padding: 0; border: none">
										<a class="btn btn-outline-black btn-sm btn-block"
											style="color: #fff"
											href="${pageContext.servletContext.contextPath}/products?page=1">Continue
											Shopping</a>
									</button>
								</div>
							</div>

						</div>
						<div class="col-md-6 pl-5">
							<div class="row justify-content-end">
								<div class="col-md-7">
									<div class="row">
										<div class="col-md-12 text-right border-bottom mb-5">
											<h3 class="text-black h4 text-uppercase">Cart Totals</h3>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col-md-6">
											<span class="text-black">Subtotal</span>
										</div>
										<div class="col-md-6 text-right">
											<strong class="text-black subtotalprice"> <fmt:setLocale
													value="en_US" /> <fmt:formatNumber maxFractionDigits="2"
													type="currency"
													value="${MathUtils.totalPriceCart(results)}"></fmt:formatNumber>


											</strong>
										</div>
									</div>


									<div class="row">
										<div class="col-md-12" style="opacity: ${MathUtils.totalPriceCart(results) > 0 ? 1: 0.3};">
											<button style="pointer-events: ${MathUtils.totalPriceCart(results) > 0 ? 'all': 'none'}" class="btn btn-black btn-lg py-3 btn-block"
												onclick="window.location='${pageContext.servletContext.contextPath}/checkout'">Proceed
												To Checkout</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:when>
				<c:otherwise>
					<div class="empty-state mb-5">
						<div class="empty-state__content">
							<div class="empty-state__icon">
								<img
									src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/9bdd8040b334d31946f49e36beaf32db.png"
									alt="">
							</div>
							<div class="empty-state__message">No products has been
								added yet.</div>
							<div class="empty-state__help">Let's go shopping now!</div>
						</div>
					</div>


					<a class="empty_cart_link"
						href="${pageContext.servletContext.contextPath}/products?page=1">Go
						shopping</a>

				</c:otherwise>
			</c:choose>



		</div>
	</div>


	<!-- Start Footer Section -->
	<jsp:include page="../components/footer.jsp"></jsp:include>
	<!-- End Footer Section -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/tiny-slider.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/custom.js?version=14"></script>
	<script type="text/javascript">

const delete_product = document.querySelector('#delete_product');
const delete_input = document.querySelector('#delete_input');


if (localStorage.getItem("delete") === 'true') {
	Swal.fire(
		'Deleted!',
		'Record has been successfully deleted.',
		'success'
	);
	localStorage.removeItem("delete");
}

function showSweetAlert(button) {
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

			delete_input.value = button.dataset.product;
			delete_product.submit();
			localStorage.setItem('delete', "true");

		}
	})
}

const updateProduct = (product_id, quantity, selected) => {
	document.getElementById("update_input_quantity").value = quantity;
	document.getElementById("update_input_selected").value = selected;
	document.getElementById("update_input_id").value = product_id;
	document.getElementById("update_product").submit();


}</script>

</body>

</html>
