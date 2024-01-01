<%@page import="Utils.MathUtils"%>
<%@page import="DAO.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<c:set var="lang" value="${lang}" scope="session"></c:set>
<fmt:setLocale value="${lang}" />
<fmt:setBundle basename="Utils.text" />
<!doctype html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="author" content="Untree.co">
<link rel="shortcut icon"
	href="${pageContext.servletContext.contextPath}/assets/images/favicon.png">
<meta name="description" content="" />
<meta name="keywords" content="bootstrap, bootstrap4" />

<!-- Bootstrap CSS -->
<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css?version=1"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css?version=1"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css?version=8"
	rel="stylesheet">
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<title>Furni Free Bootstrap 5 Template for Furniture and
	Interior Design Websites by Untree.co</title>

<style type="text/css">
#addressOptions {
	box-shadow: 0 7px 16px rgba(0, 0, 0, 0.2);
	cursor: pointer;
	border-radius: 10px;
	overflow: hidden;
	padding: 0;
	margin-top: 4px;
	height: fit-content;
	transition: 1s;
}

#addressOptions li {
	line-height: 56px;
	text-overflow: ellipsis;
	text-wrap: nowrap;
	overflow: hidden;
	padding: 0 16px;
}

#addressOptions li:hover {
	background-color: rgba(0, 0, 0, 0.2);
	color: #fff;
}

.loader-container {
	display: none;
	align-items: center;
	position: absolute;
	height: fit-content;
	right: 6px;
	top: 50%;
	transform: translateY(-50%);
	height: 82%;
	width: 55px;
	background: #fff;
	padding-left: 10px;
}

.loader-container.load {
	display: flex;
}

.loader-container .dot {
	width: 5px;
	height: 5px;
	background-color: #3b5d50;
	border-radius: 50%;
	margin-right: 3px;
	animation: bounce 1.1s ease infinite;
}

.loader-container .dot:nth-child(1) {
	animation-delay: calc(0.10s * ( 1 - 1));
}

.loader-container .dot:nth-child(2) {
	animation-delay: calc(0.10s * ( 2 - 1));
}

.loader-container .dot:nth-child(3) {
	animation-delay: calc(0.10s * ( 3 - 1));
}

.loader-container .dot:nth-child(4) {
	animation-delay: calc(0.10s * ( 4 - 1));
}

.loader-container .dot:nth-child(5) {
	animation-delay: calc(0.10s * ( 5 - 1));
}

.detail-add-notice {
	display: none;
	padding: 0 12px;
	color: rgb(220, 53, 69);
}

.detail-add-notice.show {
	display: block;
}

@keyframes bounce { 0%, 20%, 50%, 80%, 100% {
		transform: translateY(0);
	}
	40%
	{
		transform:translateY(-10px);
	}
	60%
	{
	transform:translateY(-5px);
	}
}
</style>
</head>

<body>

	<c:set var="products"
		value="${CartDAO.getSelectedProductList(sessionScope.user.id)}"></c:set>
	<c:set var="coupon" value="${sessionScope.coupon}"></c:set>
	<c:set var="user" value="${sessionScope.user}"></c:set>

	<input type="hidden" id="coupon-insert"
		value="${requestScope.insert_coupon }">
	<!-- Start Header/Navigation -->
	<jsp:include page="../components/header.jsp"></jsp:include>
	<!-- End Header/Navigation -->

	<!-- Start Hero Section -->
	<div class="hero">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col-lg-5">
					<div class="intro-excerpt">
						<h1>Checkout</h1>
					</div>
				</div>
				<div class="col-lg-7"></div>
			</div>
		</div>
	</div>
	<!-- End Hero Section -->

	<div class="untree_co-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-12">
					<div class="border p-4 rounded" role="alert">
						<a class="home-href" href="${pageContext.servletContext.contextPath}/cart"> <svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd"
							d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8" />
</svg>&nbsp;<fmt:message key="nav.cart"></fmt:message>

				</a>
					</div>
				</div>
			</div>

			<form id="form" class="row"
				action="${pageContext.servletContext.contextPath}/payment"
				method="post" onsubmit="submitOrderForm(this)">
				<div class="col-md-6 mb-5 mb-md-0">
					<h2 class="h3 mb-3 text-black">Billing Details</h2>
					<div class="p-3 p-lg-5 border bg-white">

						<div class="form-group row">
							<div class="col-md-6">
								<label for="c_fname" class="text-black">First Name <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="c_fname" name="c_fname"
									required="required" value="${user.firstName}">
							</div>
							<div class="col-md-6">
								<label for="c_lname" class="text-black">Last Name <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="c_lname" name="c_lname"
									required="required" value="${user.lastName}">
							</div>
						</div>
						<div class="form-group">
							<label for="c_country" class="text-black">Country <span
								class="text-danger">*</span></label> <select name="p_province"
								id="p_province" required="required" class="form-control"
								onchange="setDataId(this.id); fetchDistricts()">
								<option value="" disabled="disabled" selected hidden="hidden">Select
									a country</option>

							</select>
						</div>

						<div class="form-group">
							<label for="c_country" class="text-black">District <span
								class="text-danger">*</span></label> <select name="d_district"
								id="d_district" required="required" class="form-control"
								onchange="setDataId(this.id);  fetchWards()">
								<option value="" disabled="disabled" selected hidden="hidden">Select
									a district</option>

							</select>
						</div>

						<div class="form-group">
							<label for="c_country" class="text-black">Ward<span
								class="text-danger">*</span></label> <select name="w_ward" id="w_ward"
								required="required" class="form-control"
								onchange="ableDetailAddress()">
								<option value="" disabled="disabled" selected hidden="hidden">Select
									a ward</option>

							</select>
						</div>

						<div class="form-group row">
							<div class="col-md-12">
								<label for="c_address" class="text-black">Address <span
									class="text-danger">*</span>
								</label>

								<div style="position: relative;">

									<input required="required" type="text" class="form-control"
										id="c_address" name="c_address"
										placeholder="Apartment, suite, unit etc." autocomplete="off"
										oninput="getAddressSuggestions()"
										onfocus="document.getElementById('addressOptions').style.height = 'fit-content'; document.querySelector('.detail-add-notice').classList.remove('show')"
										onblur=" setTimeout(() => {checkValidAddress(this.value);document.getElementById('addressOptions').style.height = 0; }, 300)" />
									<div class="loader-container">
										<div class="dot"></div>
										<div class="dot"></div>
										<div class="dot"></div>
										<div class="dot"></div>
										<div class="dot"></div>
									</div>
								</div>
								<ul style="margin-bottom: 0" id="addressOptions"></ul>
								<p class="detail-add-notice">Địa chỉ không chính xác, vui
									lòng kiểm tra lại địa chỉ</p>
							</div>
						</div>

						<input
							style="height: 0; padding: 0; margin: 0; width: 0; border: none; position: absolute;"
							type="text" name='address-constraint' required="required"
							value="true" />



						<div class="form-group row mb-5">
							<div class="col-md-6">
								<label for="c_email_address" class="text-black">Email
									Address <span class="text-danger">*</span>
								</label> <input type="email" class="form-control" id="c_email_address"
									required="required" name="c_email_address"
									value="${user.email}">
							</div>
							<div class="col-md-6">
								<label for="c_phone" class="text-black">Phone <span
									class="text-danger">*</span></label> <input required="required"
									type="tel" class="form-control" id="c_phone" name="c_phone"
									placeholder="Phone Number" value="${user.phone}"
									pattern="^\s*\d(?:\s*\d){9}\s*$">
							</div>
						</div>





						<div class="form-group">
							<label for="c_order_notes" class="text-black">Order Notes</label>
							<textarea name="c_order_notes" id="c_order_notes" cols="30"
								rows="5" class="form-control"
								placeholder="Write your notes here/ShopMe."></textarea>
						</div>

					</div>
				</div>
				<div class="col-md-6">

					<div class="row mb-5">
						<div class="col-md-12">
							<h2 class="h3 mb-3 text-black">Coupon Code</h2>
							<div class="p-3 p-lg-5 border bg-white">

								<label for="c_code" class="text-black mb-3">Enter your
									coupon code if you have one</label>
								<div class="input-group w-75 couponcode-wrap">
									<div style="display: flex;">

										<input style="cursor: text;" type="text"
											class="form-control me-2" id="c_code"
											placeholder="Coupon Code" aria-label="Coupon Code"
											name="coupon" aria-describedby="button-addon2"
											value="${coupon.id}">
										<div class="input-group-append">
											<button
												onclick="submitCouponForm('${pageContext.servletContext.contextPath}/checkout','post')"
												style="cursor: pointer;" class="btn btn-black btn-sm"
												type="button" id="button-addon2">Apply</button>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					
					
					<div class="row mb-5">
						<div class="col-md-12">
							<h2 class="h3 mb-3 text-black">Your Order</h2>
							<div class="p-3 p-lg-5 border bg-white">
								<table class="table site-block-order-table mb-5">
									<thead>
										<th>Product</th>
										<th>Total</th>
									</thead>
									<tbody>

										<c:forEach var="product" items="${products}">

											<tr>
												<td style="text-transform: capitalize;">${product.key.name}<strong
													class="mx-2">x</strong> ${product.value}
												</td>
												<td>
													<fmt:setLocale value="en_US" /> 
													<fmt:formatNumber
														maxFractionDigits="2" type="currency"
														
														currencySymbol="$"
														value="${product.key.price*product.key.percentSale*product.value}">
													</fmt:formatNumber>

												</td>
											</tr>
										</c:forEach>


										<tr>
											<td class="text-black font-weight-bold"><strong>Cart
													Subtotal</strong></td>
											<td class="text-black">
												<fmt:setLocale value="en_US" />
												<fmt:formatNumber currencySymbol="$" maxFractionDigits="2" type="currency"
													value="${MathUtils.totalPriceCart(sessionScope.cart)}">
												</fmt:formatNumber>
											</td>
										</tr>
										<c:choose>

											<c:when test="${not empty coupon}">
												<tr>
													<td class="text-black font-weight-bold"><strong>Coupon
													</strong></td>
													<td class="text-black">-
														<fmt:setLocale value="en_US" />
														<fmt:formatNumber currencySymbol="$" maxFractionDigits="2" type="currency"
															value="${MathUtils.totalPriceCart(sessionScope.cart)*coupon.percentSale}">
														</fmt:formatNumber>
														(<fmt:formatNumber type="percent"
															value="${coupon.percentSale}">
														</fmt:formatNumber>)

													</td>
												</tr>
											</c:when>

										</c:choose>

										<tr>
											<td class="text-black font-weight-bold"><strong>Order
													Total</strong></td>
											<td class="text-black font-weight-bold">
												<strong>
													<fmt:setLocale
														value="en_US" /> 
													<fmt:formatNumber maxFractionDigits="2" currencySymbol="$"
														type="currency"
														value="${MathUtils.totalPriceCart(sessionScope.cart) - MathUtils.totalPriceCart(sessionScope.cart)*coupon.percentSale}">
													</fmt:formatNumber>
												</strong>
											</td>
										</tr>
									</tbody>
								</table>

								<div class="border p-3 mb-3">
									<h3
										onclick="event.currentTarget.lastElementChild.checked = true"
										class="h6 mb-0"
										style="display: flex; justify-content: space-between;">
										<a style="width: 100%" class="d-block"
											data-bs-toggle="collapse" href="#collapsebank" role="button"
											aria-expanded="false" aria-controls="collapsebank">Direct
											Bank Transfer</a> <input style="cursor: pointer;"
											checked="checked" type="radio" name="payment" value="1">
									</h3>

									<div class="collapse" id="collapsebank">
										<div class="py-2">
											<p class="mb-0">Make your payment directly into our bank
												account. Please use your Order ID as the payment reference.
												Your order wonât be shipped until the funds have cleared
												in our account.</p>
										</div>
									</div>
								</div>

								<div class="border p-3 mb-3">
									<h3
										onclick="event.currentTarget.lastElementChild.checked = true"
										class="h6 mb-0"
										style="display: flex; justify-content: space-between;">
										<a style="width: 100%" class="d-block"
											data-bs-toggle="collapse" href="#collapsecheque"
											role="button" aria-expanded="false"
											aria-controls="collapsecheque">Cheque Payment</a> <input
											id="cheque_payment" style="cursor: pointer;" type="radio"
											name="payment" value="2">
									</h3>


									<div class="collapse" id="collapsecheque">
										<div class="py-2">
											<p class="mb-0">Make your payment directly into our bank
												account. Please use your Order ID as the payment reference.
												Your order wonât be shipped until the funds have cleared
												in our account.</p>
										</div>
									</div>
								</div>

								<div class="border p-3 mb-5">
									<h3
										onclick="event.currentTarget.lastElementChild.checked = true"
										class="h6 mb-0"
										style="display: flex; justify-content: space-between;">
										<a style="width: 100%" class="d-block"
											data-bs-toggle="collapse" href="#collapsepaypal"
											role="button" aria-expanded="false"
											aria-controls="collapsepaypal">Paypal</a> <input
											style="cursor: pointer;" type="radio" name="payment"
											value="3">
									</h3>


									<div class="collapse" id="collapsepaypal">
										<div class="py-2">
											<p class="mb-0">Make your payment directly into our bank
												account. Please use your Order ID as the payment reference.
												Your order wonât be shipped until the funds have cleared
												in our account.</p>
										</div>
									</div>
								</div>

								<div class="form-group">
									<button class="btn btn-black btn-lg py-3 btn-block"
										type="submit">Place Order</button>
								</div>

							</div>
						</div>
					</div>

				</div>
		</form>
		<!-- </form> -->
		</div>
	</div>

	<!-- Start Footer Section -->
	<jsp:include page="../components/footer.jsp"></jsp:include>
	<!-- End Footer Section -->


	<script
		src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/tiny-slider.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/custom.js?version=13"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/checkout.js?version=5"></script>

</body>

</html>
