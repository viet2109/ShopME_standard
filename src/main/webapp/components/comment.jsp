<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- start link -->
<link
	href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css?version=1"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link
	href="${pageContext.request.contextPath }/assets/css/comment.css?version=3"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>

<!-- end link -->


</head>
<body>
	<c:set var="product_id" value="${param.product_id}" />

	<input type="hidden" id="cmt" value="${sessionScope.cmt}">
	<input type="hidden" value="${sessionScope.user!=null?'exist':'no exist' }" id="user">
	<div style="display: none">${sessionScope.cmt = ""}</div>
	<div class="container my-5 border" style="background-color: rgba(231, 233, 235, 0.5) !important;">
		
		<form action="${pageContext.request.contextPath }/comments"
			method="post" id="form"
			onsubmit=" if (validateForm()) handleSubmit()">
			<input
				type="hidden" name="product_id" value="${product_id }"> 
			<div class=" mt-4 mx-5 d-flex flex-row">
				<div class="">
					<div class="box-avatar">
						<img src="./assets/images/user-avatar.png" alt=""
							class="box-avatar">
					</div>

				</div>
				<div class=" me-3 w-100 d-flex flex-column">
					<div class="row mx-2" style="height: 40px">
						<span
							style="font-size: 14px; transform: translateY(11px); padding-left: 0; position: absolute;"
							class="text-capitalize h5 col-4">${user == null?"User":(user.getFullName())}</span>
						<div class="rating col-12" id="starRating"
							style="transform: translateX(-22px)">
							<input type="hidden" name="rating" id="rating" value="0">
							<i class='bx bx-star star' style="--i: 0;"></i> 
							<i class='bx bx-star star' style="--i: 1;"></i> 
							<i class='bx bx-star star' style="--i: 2;"></i> 
							<i class='bx bx-star star' style="--i: 3;"></i> 
							<i class='bx bx-star star' style="--i: 4;"></i>

						</div>
					</div>
					<textarea name="content-comment" id="content-comment"
						class="form-control border border-success rounded-4 mb-2   "
						placeholder="Your rate product..." required="required"></textarea>

				</div>

			</div>
			<div class="d-flex justify-content-center mb-3" id="btnForm">
				<button class="btn btn-success submit m-2" type="submit">Submit</button>
				<button class="btn btn-light btn-outline-success cancel m-2"
					type="button" id="cancelButton">Cancel</button>
			</div>
		</form>
	</div>


	<script src="https://code.jquery.com/jquery-3.7.1.js"
		integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/comment.js?version=7"></script>
</body>
</html>