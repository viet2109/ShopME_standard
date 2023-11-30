<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>Insert title here</title>
<style type="text/css">


h1 {
	color: var(--color-dark);
}

.page-container {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	justify-content: center;
	margin-top: 2rem !important;
	background-color: #fff;
	box-shadow: 0 0 10px #d3d3d3;
	border-radius: 5px;
	padding: 10px 15px;
	height: 56px;
}

.page-container i {
	padding: 6px 12px;
	cursor: pointer;
	font-size: 18px;
	color: var(--color-dark);
	pointer-events: none;
}

.page-container button {
	cursor: pointer;
	background-color: transparent;
	border: none;
}

.page-container button:disabled i {
	color: #aaadc7;
}

#pagination {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
}

#pagination li {
	list-style: none;
	cursor: pointer;
	border-radius: 5px;
	overflow: hidden;
	margin: 0 3px;
}

#pagination li.active {
	background-color: #39f;
}

#pagination li.active a {
	color: #fff;
}

#pagination li a {
	text-decoration: none;
	font-weight: 600;
	padding: 8px 13px;
	display: inline-block;
	line-height: 1;
	color: #a9a9a9;
	font-size: 20px;
	
	
}

#pagination li:hover {
	background-color: #39f;
}

#pagination li:hover a {
	color: #fff;
}

.settings {
	padding-top: 3rem;
	display: none;
	align-items: flex-start;
}

.settings .form-input {
	margin-bottom: 1rem;
}

.settings .form-input:not(:last-child) {
	margin-right: 3rem;
}

.settings .form-input>label {
	margin-bottom: 10px;
}

.settings .form-input label {
	font-size: 18px;
	font-weight: 600;
	display: block;
}

.settings .form-input>input {
	width: 100%;
}

.settings .form-input input {
	font-size: 18px;
	outline: none;
	padding: 10px 17px;
	border-radius: 5px;
	border: 1px solid #b6b6b6;
}

.settings .wrapper-form-check {
	display: flex;
}

.settings .wrapper-form-check .form-check {
	display: flex;
	line-height: 1;
	align-items: center;
}

.settings .wrapper-form-check .form-check:not(:last-child) {
	margin-right: 10px;
}

.settings .wrapper-form-check label {
	margin-left: 10px;
}

@media ( max-width : 992px) {
	.settings {
		flex-direction: column;
	}
}

/*# sourceMappingURL=style.css.map */
</style>
</head>
<body>
	<div class="page-container">
		<button class="first-page" disabled>
			<i class="fas fa-angle-double-left"></i>
		</button>
		<button class="prev-page" disabled>
			<i class="fas fa-angle-left"></i>
		</button>
		<div id="pagination"></div>
		<button class="next-page">
			<i class="fas fa-angle-right"></i>
		</button>
		<button class="last-page">
			<i class="fas fa-angle-double-right"></i>
		</button>
	</div>
	<input type="hidden" value="${pageContext.servletContext.contextPath }" id="contextPath"/>
	<div class="settings">
		<div class="form-input">
			<label for="">Truncation</label>
			<div class="wrapper-form-check">
				<div class="form-check">
					<input class="check" type="radio" checked name="enable" id="enable" />
					<label for="enable">Enable</label>
				</div>
				<div class="form-check">
					<input class="check" type="radio" name="enable" id="disable" /> <label
						for="disable">Disable</label>
				</div>
			</div>
		</div>
		<div class="form-input">
			<label for="pages">Number of pages:</label> <input type="number"
				min="1" id="pages" value="${param.totalPage}" />
		</div>
		<div class="form-input">
			<label for="curpage">Current page:</label> <input type="number"
				min="1" id="curpage" value="${param.currentPage }" />
		</div>

		<div class="form-input">
			<label for="delta">Number of links two side of current page</label> <input
				type="number" id="delta" min="1" max="5" value="1" />
		</div>
	</div>
	<script type="text/javascript" src="${pageContext.servletContext.contextPath}/assets/js/pagination.js?version=4"></script>
	
</body>
</html>