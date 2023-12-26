<%@page import="Model.Product"%>
<%@page import="DAO.CommentDAO"%>
<%@page import="DAO.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="Utils.DynamicPagination"%>
<%@page import="Utils.MathUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Database.DBConnection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<link
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css?version=5"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/tiny-slider.css?version=5"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath}/assets/css/page.css?version=4"
	rel="stylesheet">
<title>Furni Free Bootstrap 5 Template for Furniture and
	Interior Design Websites by Untree.co</title>
</head>
<body>


	<c:set var="id" value="${param.id }"></c:set>
	<c:set var="comment_page"
		value="${param.comment_page == null ? 1: param.comment_page }"></c:set>
	<c:set var="result" value="${ProductDAO.getById(id)}"></c:set>
	<c:set var="comments"
		value="${CommentDAO.getByOffset(CommentDAO.getByProductId(id), comment_page)}"></c:set>
	<c:set var="totalComment" value="${CommentDAO.getByProductId(id)}"></c:set>
	<c:set var="result_related_product"
		value="${ProductDAO.getBestSale(9, id)}"></c:set>




	<!-- Start Header/Navigation -->
	<jsp:include page="../components/header.jsp"></jsp:include>
	<!-- End Header/Navigation -->

	<!-- product-detail content -->

	<div class="bg-main">
		<div class="container">
			<div class="box">
				<div class="breadcumb">
					<a href="${pageContext.servletContext.contextPath}/home">home</a> <span><i
						class='bx bxs-chevrons-right'></i></span> <a
						href="${pageContext.servletContext.contextPath}/products?page=1">all
						products</a> <span><i class='bx bxs-chevrons-right'></i></span> <a
						style="pointer-events: none"
						href="${pageContext.servletContext.contextPath}/">${result.name}</a>
				</div>
			</div>
			<div class="row product-row">
				<div class="col-12 col-lg-5">
					<div class="product-img" id="product-img">
						<img
							src="data:image/gif;base64, ${MathUtils.covertBlobToByteString(result.image)}"
							alt="">
					</div>
					<div class="box">
						<div class="product-img-list">
							<div class="product-img-item">
								<img
									src="data:image/gif;base64, ${MathUtils.covertBlobToByteString(result.image)}"
									alt="">
							</div>
							<div class="product-img-item">
								<img
									src="data:image/gif;base64, ${MathUtils.covertBlobToByteString(result.image)}"
									alt="">
							</div>
							<div class="product-img-item">
								<img
									src="data:image/gif;base64, ${MathUtils.covertBlobToByteString(result.image)}"
									alt="">
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-lg-7">
					<div class="product-info">
						<h1 style="text-transform: capitalize;">${result.name}</h1>
						<div class="product-info-detail">
							<span class="product-info-detail-title">Brand:</span> <a href="#">JBL</a>
						</div>
						<div class="product-info-detail">
							<span class="product-info-detail-title">Rated:</span> <span
								class="rating"> <c:forEach var="star" begin="1"
									end="${result.rate }">

									<i class='bx bxs-star'></i>
								</c:forEach>

							</span>
						</div>
						<p class="product-description">${result.des }</p>
						<div class="product-info-price">$${result.price }</div>
						<div class="product-quantity-wrapper">
							<span class="product-quantity-btn"> <i class='bx bx-minus'></i>
							</span> <span class="product-quantity">1</span> <span
								class="product-quantity-btn"> <i class='bx bx-plus'></i>
							</span>
						</div>
						<div>
							<form action="${pageContext.servletContext.contextPath}/cart"
								method="post" id="insert-form">
								<input type="hidden" name="action" value="insert" /> <input
									type="hidden" name="product-quantity" id="product-quantity"
									value="1" /> <input type="hidden" name="product-id"
									value="${id}" />
								<button type="submit" class="btn-flat btn-hover">add to
									cart</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="box">
				<div class="box-header">description</div>
				<div class="product-detail-description">
					<div style="cursor: pointer; border-radius: 10px"
						class="btn-flat btn-hover btn-view-description"
						id="view-all-description"
						style="margin-top: 16px; border-radius: 10px">view all</div>
					<div class="product-detail-description-content">
						<p>${result.des }</p>
					</div>
				</div>
			</div>

			<div>

				<jsp:include page="../components/comment.jsp">
					<jsp:param value="${id }" name="product_id" />
				</jsp:include>
			</div>
			<div class="box">
				<div class="box-header">review</div>
				<div>

					<c:choose>

						<c:when test="${fn:length(totalComment)>0}">

							<c:forEach var="comment" items="${comments }">


								<c:set var="_user" value="${UserDAO.getById(comment.user.id)}"></c:set>



								<div class="user-rate">
									<div class="user-info" style="margin-bottom: 0">
										<div class="user-avt">
											<img
												src="${pageContext.servletContext.contextPath }/assets/images/user-avatar.png"
												alt="">
										</div>
										<div class="user-name">
											<span class="name">${_user.lastName}
												${_user.firstName}</span> <span class="rating"
												style="justify-content: flex-start; margin-bottom: 10px">
												<c:forEach var="user-rate" begin="1" end="${comment.rate}">
													<i class='bx bxs-star'></i>
												</c:forEach>

											</span> <span class="rate-datetime"><fmt:formatDate
													type="both" dateStyle="short" timeStyle="short"
													pattern="dd-MM-yyyy HH:mm" value="${comment.create_date}" /></span>
										</div>
									</div>

									<div class="user-rate-content">${comment.content}</div>
								</div>



							</c:forEach>


							<jsp:include page="../components/dynamicPagination.jsp">
								<jsp:param
									value="${MathUtils.roundUp(fn:length(totalComment), DynamicPagination.totalCommentOfPage)}"
									name="totalPage" />
								<jsp:param value="${comment_page}" name="currentPage" />
							</jsp:include>

						</c:when>

						<c:otherwise>

							<div class="empty-state">
								<div class="empty-state__content">
									<div class="empty-state__icon">
										<img
											src="https://www.un.org/sites/un2.un.org/files/2020/08/chat.png"
											alt="">
									</div>
									<div class="empty-state__message">No comments has been
										added yet.</div>
									<div class="empty-state__help">Add a new comment by
										simpley clicking the button on top left side.</div>
								</div>
							</div>

						</c:otherwise>

					</c:choose>




				</div>
			</div>


			<div class="box">
				<div class="box-header">related products</div>
				<div class="product-section">
					<div class="container">
						<div class="row" id="related-products">
							<c:forEach var="rp" items="${result_related_product}">
								<jsp:include page="../components/cardProduct.jsp">
									<jsp:param
										value="${MathUtils.covertBlobToByteString(rp.image)}"
										name="src" />
									<jsp:param value="${rp.id }" name="id" />
									<jsp:param value="${rp.price }" name="price" />
									<jsp:param value="${rp.name }" name="des" />
								</jsp:include>
							</c:forEach>


						</div>

					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- end product-detail content -->



	<!-- Start Footer Section -->
	<jsp:include page="../components/footer.jsp"></jsp:include>
	<!-- End Footer Section -->

	<script
		src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.bundle.min.js">
	</script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/tiny-slider.js"></script>
	<script
		src="${pageContext.servletContext.contextPath}/assets/js/custom.js"></script>
	<script type="text/javascript">
		
	if (localStorage.getItem("insert") === 'true') {
		
		Swal.fire(
		        'Insert',
		        'Product has been successfully insert.',
		        'success'
		      );
		localStorage.removeItem("insert");
	}
		const insert_form = document.getElementById("insert-form");
		insert_form.onsubmit = (e) => {
			e.preventDefault();
			localStorage.setItem("insert", "true");
			e.target.submit();
		}
		document.querySelectorAll('.product-img-item').forEach(e => {
		    e.addEventListener('click', () => {
		        let img = e.querySelector('img').getAttribute('src')
		        document.querySelector('#product-img > img').setAttribute('src', img)
		    })
		})

		document.querySelector('#view-all-description').addEventListener('click', () => {
		    let content = document.querySelector('.product-detail-description-content')
		    content.classList.toggle('active')
		    document.querySelector('#view-all-description').innerHTML = content.classList.contains('active') ? 'view less' : 'view all'
		})
		
		const quantityButtons = document.querySelectorAll(".product-quantity-btn");
		const quantityValue = document.querySelector(".product-quantity");
		const quantity_product_input = document.querySelector("#product-quantity");
		quantityButtons.forEach((button) => {
			button.onclick = (e) => {
				
				const child = button.firstElementChild.className;
				if (child.includes("minus")) {
					if (parseInt(quantityValue.innerText) > 1) {
						
					quantityValue.innerText = parseInt(quantityValue.innerText) - 1;
					}
					
				} else {
					quantityValue.innerText = parseInt(quantityValue.innerText) + 1;
					
					
				}
				quantity_product_input.value = parseInt(quantityValue.innerText) ;
			}
		})
		
		</script>

</body>

</html>
