<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon"
	href="${pageContext.servletContext.contextPath}/assets/images/favicon.png?version=3">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/fonts/material-icon/css/material-design-iconic-font.min.css?version=3">

<!-- Main css -->
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/auth.css?version=3">
<link rel="stylesheet" href="alert/dist/sweetalert.css">
</head>
<body>

	<%
	String status = (String) request.getAttribute("status");
	String firstName = (String) request.getAttribute("firstName");
	String lastName = (String) request.getAttribute("lastName");
	String email = (String) request.getAttribute("email");
	String phone = (String) request.getAttribute("phone");
	String date = (String) request.getAttribute("date");
	String pass = (String) request.getAttribute("pass");

	String re_pass = (String) request.getAttribute("re_pass");
	boolean isSuccessRegister = status == null ? false : status.equals("success");
	%>


	<input required type="hidden" id="status"
		value="${requestScope.status}" />
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<a class="home-href" style="margin-left: 75px;padding-top: 40px
				"
					href="${pageContext.servletContext.contextPath}/home"> <svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd"
							d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8" />
</svg>Back to home
				</a>
				<div class="signup-content">
					<div class="signup-form" style="margin-right: 0; padding: 0">
						<h2 class="form-title">Sign up</h2>

						<form method="post"
							action="${pageContext.servletContext.contextPath}/register"
							class="register-form" id="register-form">
							<div class="form-group" style="display: flex">
								<label for="firstName"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="text" name="firstName" id="firstName"
									placeholder="Your First Name" style="margin-right: 20px"
									value="<%=firstName != null ? firstName : ""%>" /> <input
									onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="text" name="lastName" id="lastName"
									placeholder="Your Last Name"
									value="<%=lastName != null ? lastName : ""%>" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="email" name="email" id="email"
									placeholder="Your Email"
									value="<%=email != null ? email : ""%>" />
							</div>

							<div class="form-group">
								<label for="contact"><svg
										xmlns="http://www.w3.org/2000/svg" height="1em"
										viewBox="0 0 512 512" style="font-size: 11px">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M164.9 24.6c-7.7-18.6-28-28.5-47.4-23.2l-88 24C12.1 30.2 0 46 0 64C0 311.4 200.6 512 448 512c18 0 33.8-12.1 38.6-29.5l24-88c5.3-19.4-4.6-39.7-23.2-47.4l-96-40c-16.3-6.8-35.2-2.1-46.3 11.6L304.7 368C234.3 334.7 177.3 277.7 144 207.3L193.3 167c13.7-11.2 18.4-30 11.6-46.3l-40-96z" /></svg></label>
								<input onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="text" name="contact" id="contact"
									placeholder="Your Phone Number"
									value="<%=phone != null ? phone : ""%>" />
							</div>
							<div class="form-group">
								<label for="dob"><svg xmlns="http://www.w3.org/2000/svg"
										height="1em" viewBox="0 0 448 512" style="font-size: 11px">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M86.4 5.5L61.8 47.6C58 54.1 56 61.6 56 69.2V72c0 22.1 17.9 40 40 40s40-17.9 40-40V69.2c0-7.6-2-15-5.8-21.6L105.6 5.5C103.6 2.1 100 0 96 0s-7.6 2.1-9.6 5.5zm128 0L189.8 47.6c-3.8 6.5-5.8 14-5.8 21.6V72c0 22.1 17.9 40 40 40s40-17.9 40-40V69.2c0-7.6-2-15-5.8-21.6L233.6 5.5C231.6 2.1 228 0 224 0s-7.6 2.1-9.6 5.5zM317.8 47.6c-3.8 6.5-5.8 14-5.8 21.6V72c0 22.1 17.9 40 40 40s40-17.9 40-40V69.2c0-7.6-2-15-5.8-21.6L361.6 5.5C359.6 2.1 356 0 352 0s-7.6 2.1-9.6 5.5L317.8 47.6zM128 176c0-17.7-14.3-32-32-32s-32 14.3-32 32v48c-35.3 0-64 28.7-64 64v71c8.3 5.2 18.1 9 28.8 9c13.5 0 27.2-6.1 38.4-13.4c5.4-3.5 9.9-7.1 13-9.7c1.5-1.3 2.7-2.4 3.5-3.1c.4-.4 .7-.6 .8-.8l.1-.1 0 0 0 0s0 0 0 0s0 0 0 0c3.1-3.2 7.4-4.9 11.9-4.8s8.6 2.1 11.6 5.4l0 0 0 0 .1 .1c.1 .1 .4 .4 .7 .7c.7 .7 1.7 1.7 3.1 3c2.8 2.6 6.8 6.1 11.8 9.5c10.2 7.1 23 13.1 36.3 13.1s26.1-6 36.3-13.1c5-3.5 9-6.9 11.8-9.5c1.4-1.3 2.4-2.3 3.1-3c.3-.3 .6-.6 .7-.7l.1-.1c3-3.5 7.4-5.4 12-5.4s9 2 12 5.4l.1 .1c.1 .1 .4 .4 .7 .7c.7 .7 1.7 1.7 3.1 3c2.8 2.6 6.8 6.1 11.8 9.5c10.2 7.1 23 13.1 36.3 13.1s26.1-6 36.3-13.1c5-3.5 9-6.9 11.8-9.5c1.4-1.3 2.4-2.3 3.1-3c.3-.3 .6-.6 .7-.7l.1-.1c2.9-3.4 7.1-5.3 11.6-5.4s8.7 1.6 11.9 4.8l0 0 0 0 0 0 .1 .1c.2 .2 .4 .4 .8 .8c.8 .7 1.9 1.8 3.5 3.1c3.1 2.6 7.5 6.2 13 9.7c11.2 7.3 24.9 13.4 38.4 13.4c10.7 0 20.5-3.9 28.8-9V288c0-35.3-28.7-64-64-64V176c0-17.7-14.3-32-32-32s-32 14.3-32 32v48H256V176c0-17.7-14.3-32-32-32s-32 14.3-32 32v48H128V176zM448 394.6c-8.5 3.3-18.2 5.4-28.8 5.4c-22.5 0-42.4-9.9-55.8-18.6c-4.1-2.7-7.8-5.4-10.9-7.8c-2.8 2.4-6.1 5-9.8 7.5C329.8 390 310.6 400 288 400s-41.8-10-54.6-18.9c-3.5-2.4-6.7-4.9-9.4-7.2c-2.7 2.3-5.9 4.7-9.4 7.2C201.8 390 182.6 400 160 400s-41.8-10-54.6-18.9c-3.7-2.6-7-5.2-9.8-7.5c-3.1 2.4-6.8 5.1-10.9 7.8C71.2 390.1 51.3 400 28.8 400c-10.6 0-20.3-2.2-28.8-5.4V480c0 17.7 14.3 32 32 32H416c17.7 0 32-14.3 32-32V394.6z" /></svg></label>
								<input onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="date" placeholder="MM/DD/YYYY"
									onfocus="(this.type='date')" onblur="(this.type='text')"
									name="dob" id="dob" value="<%=date != null ? date : ""%>" />
							</div>

							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									onblur="handleOnBlur(this)" onfocus="handleOnFocus(this)"
									required type="password" name="pass" id="pass"
									placeholder="Password" value="<%=pass != null ? pass : ""%>" />
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
							<div class="form-group">
								<label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
								<input onblur="handleOnBlur(this)" onfocus="hanleOnFocus(this)"
									required type="password" name="re_pass" id="re_pass"
									placeholder="Repeat your password"
									value="<%=re_pass != null ? re_pass : ""%>" /> <input
									style="display: none" type="checkbox" name="show_pass"
									id="show_re_pass" cla /> <label for="show_re_pass"
									class="show-pass" onclick="handleShowPass(this)"> <svg
										xmlns="http://www.w3.org/2000/svg" height="1em"
										viewBox="0 0 576 512">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z" /></svg>
								</label> <label for="show_re_pass" class="hide-pass"
									onclick="handleShowPass(this)"> <svg
										xmlns="http://www.w3.org/2000/svg" height="1em"
										viewBox="0 0 640 512">
										<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
										<path
											d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L525.6 386.7c39.6-40.6 66.4-86.1 79.9-118.4c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C465.5 68.8 400.8 32 320 32c-68.2 0-125 26.3-169.3 60.8L38.8 5.1zm151 118.3C226 97.7 269.5 80 320 80c65.2 0 118.8 29.6 159.9 67.7C518.4 183.5 545 226 558.6 256c-12.6 28-36.6 66.8-70.9 100.9l-53.8-42.2c9.1-17.6 14.2-37.5 14.2-58.7c0-70.7-57.3-128-128-128c-32.2 0-61.7 11.9-84.2 31.5l-46.1-36.1zM394.9 284.2l-81.5-63.9c4.2-8.5 6.6-18.2 6.6-28.3c0-5.5-.7-10.9-2-16c.7 0 1.3 0 2 0c44.2 0 80 35.8 80 80c0 9.9-1.8 19.4-5.1 28.2zm9.4 130.3C378.8 425.4 350.7 432 320 432c-65.2 0-118.8-29.6-159.9-67.7C121.6 328.5 95 286 81.4 256c8.3-18.4 21.5-41.5 39.4-64.8L83.1 161.5C60.3 191.2 44 220.8 34.5 243.7c-3.3 7.9-3.3 16.7 0 24.6c14.9 35.7 46.2 87.7 93 131.1C174.5 443.2 239.2 480 320 480c47.8 0 89.9-12.9 126.2-32.5l-41.9-33zM192 256c0 70.7 57.3 128 128 128c13.3 0 26.1-2 38.2-5.8L302 334c-23.5-5.4-43.1-21.2-53.7-42.3l-56.1-44.2c-.2 2.8-.3 5.6-.3 8.5z" /></svg>
								</label>
							</div>
							<div class="form-group"
								style="display: flex; align-items: center; margin-top: 6px">
								<input required type="checkbox" name="agree-term"
									id="agree-term" class="agree-term" /> <label for="agree-term"
									class="label-agree-term" style="margin: 0"> I agree all
									statements in <a href="#" class="term-service">Terms of
										service</a>
								</label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img
								src="${pageContext.servletContext.contextPath}/assets/images/signup-image.jpg"
								alt="sing up image">
						</figure>
						<a href="${pageContext.servletContext.contextPath}/login"
							class="signup-image-link">I am already member</a>
					</div>
				</div>
			</div>
		</section>

	</div>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
		const status = document.getElementById("status").value;
		const email = document.getElementById('email');
		const phone_number = document.getElementById('contact');
		const pass = document.getElementById('pass');
		const re_pass = document.getElementById('re_pass');
		
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
		
		if (status == "success") {
			swal("Congrats", "You have register successfully !", "success");
		} else if (status == "failed") {
			email.style.borderBottomColor = 'red';
			phone_number.style.borderBottomColor = 'red';
			swal("Sorry", "The email and the phone has already exist!", "error");
		} else if (status == "email_exist") {
			email.style.borderBottomColor = 'red';
			swal("Sorry", "The email has already exist!", "error");
		} else if (status == "phone_exist") {
			phone_number.style.borderBottomColor = 'red';
			swal("Sorry", "The phone has already exist!", "error");
		}
		
		
		const submitForm = document.getElementById('register-form');
		submitForm.onsubmit = (e) => {
			e.preventDefault();
			
			
			//Validate
			
			
			
			const isValidEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email.value);
			const isValidPhoneNumber = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/.test(phone_number.value);
			const isValidPass = pass.value.length > 5;
			const isMatchPass = pass.value === re_pass.value;
			
			if (!isValidEmail) {
				email.style.borderBottomColor = 'red';
				swal("Sorry", "The email has not correct format!", "error");
			} else if (!isValidPhoneNumber) {
				phone_number.style.borderBottomColor = 'red';
				swal("Sorry", "The phone has not correct format!", "error");
			} else if (!isValidPass) {
				pass.style.borderBottomColor = 'red';
				swal("Sorry", "The length of pass must be greater than 5 !", "error");
			} else if (!isMatchPass) {
				re_pass.style.borderBottomColor = 'red';
				swal("Sorry", "The repeat password does not match the password !", "error");
			}
			else {	
				submitForm.submit();
			}
			
			//End Validate
		}
		
	</script>


</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>