<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="lang" value="${lang}" scope="session"></c:set>
<fmt:setLocale value="${lang}" />
<fmt:setBundle basename="Utils.text" />
<!DOCTYPE html>
<html lang="${lang}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon"
	href="${pageContext.servletContext.contextPath}/assets/images/favicon.png">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/auth.css?version=7">
</head>
<body>
	<c:set var="product_id" value="${param.id }" />
	<input type="hidden" id="status" value="${requestScope.status}" />
	<input type="hidden" id="register_status"
		value="${sessionScope.register_status}" />

	<div class="main">

		<!-- Sing in  Form -->
		<section class="sign-in">
			<div class="container">
				<a class="home-href" href="${pageContext.servletContext.contextPath}/home"> <svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd"
							d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8" />
</svg><fmt:message key="nav.home"></fmt:message>
				</a>
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/signin-image.jpg"
								alt="sing up image">
						</figure>
						<a href="${pageContext.servletContext.contextPath}/register"
							class="signup-image-link"><fmt:message key="form.register"></fmt:message></a>
					</div>

					<div class="signin-form">
						<h2 class="form-title"><fmt:message key="button.login"></fmt:message></h2>

						<form method="post"
							action="${pageContext.servletContext.contextPath}/login"
							class="register-form" id="login-form">
							
							
							<c:forEach var="prm" items="${param}">
								
								<c:forEach var="value" items="${prm.value}">
									
									<c:choose>
										
										<c:when test="${not (prm.key eq 'username' or prm.key eq 'password')}">
											
											<input type="hidden" name="${prm.key}" value="${value}" >
										
										</c:when>
										
									</c:choose>
									
								</c:forEach>
								
							</c:forEach>
							
							<div class="form-group">
								<label for="username"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									onblur='handleOnBlur(this)' onfocus="handleOnFocus(this)"
									type="text" name="username" id="username"
									placeholder="<fmt:message key="form.emailorphone"></fmt:message>" required="required"
									value="${requestScope.username==null?'':requestScope.username}" />
							</div>
							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									onblur='handleOnBlur(this)' onfocus="handleOnFocus(this)"
									type="password" name="password" id="password"
									placeholder="<fmt:message key="form.pass"></fmt:message>" required="required"
									value="${requestScope.password==null?'':requestScope.password}" />
								<input style="display: none" type="checkbox" name="show_pass"
									id="show_pass" /> <label for="show_pass" class="show-pass"
									onclick="handleShowPass(this)"> <svg
										xmlns="http://www.w3.org/2000/svg" height="1em"
										viewBox="0 0 576 512">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z" /></svg>
								</label> <label for="show_pass" class="hide-pass"
									onclick="handleShowPass(this)"> <svg
										xmlns="http://www.w3.org/2000/svg" height="1em"
										viewBox="0 0 640 512">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zm151 118.3C226 97.7 269.5 80 320 80c65.2 0 118.8 29.6 159.9 67.7C518.4 183.5 545 226 558.6 256c-12.6 28-36.6 66.8-70.9 100.9l-53.8-42.2c9.1-17.6 14.2-37.5 14.2-58.7c0-70.7-57.3-128-128-128c-32.2 0-61.7 11.9-84.2 31.5l-46.1-36.1zM394.9 284.2l-81.5-63.9c4.2-8.5 6.6-18.2 6.6-28.3c0-5.5-.7-10.9-2-16c.7 0 1.3 0 2 0c44.2 0 80 35.8 80 80c0 9.9-1.8 19.4-5.1 28.2zm9.4 130.3C378.8 425.4 350.7 432 320 432c-65.2 0-118.8-29.6-159.9-67.7C121.6 328.5 95 286 81.4 256c8.3-18.4 21.5-41.5 39.4-64.8L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5l-41.9-33zM192 256c0 70.7 57.3 128 128 128c13.3 0 26.1-2 38.2-5.8L302 334c-23.5-5.4-43.1-21.2-53.7-42.3l-56.1-44.2c-.2 2.8-.3 5.6-.3 8.5z" /></svg>
								</label>

							</div>
							<a href="${pageContext.servletContext.contextPath}/forgotPassword" class="forgot-pass">Quên mật khẩu?</a>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="<fmt:message key="button.login"></fmt:message>" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>

	</div>

	<c:set var="register_status" scope="session" value="${null}"></c:set>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
		const status = document.getElementById("status").value;
		const register_status = document.getElementById("register_status").value;
		const username = document.getElementById("username");
		const password = document.getElementById("password");
		
		if (status == "success") {
			swal("Congrats", "You have register successfully !", "success");
		} else if (status == "failed") {
			swal("Sorry", "The email/phone or the password is wrong!", "error");
			username.style.borderBottomColor = "red";
			password.style.borderBottomColor = "red";
			
		}
		
		if (register_status == "success") {
			swal("Congrats", "You have register successfully !", "success");
		}
		
		const handleOnFocus = (e) => {
			e.style.borderBottomColor = "#222";
			
		}
		const handleOnBlur = (e) => {
			e.style.borderBottomColor = "#999";
		}
		
		const handleShowPass = (tag) => {
				const type = tag.className === 'show-pass'? 'password':'text';
				tag.parentNode.getElementsByTagName('input')[0].type = type;
		}
		
		
	</script>
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>