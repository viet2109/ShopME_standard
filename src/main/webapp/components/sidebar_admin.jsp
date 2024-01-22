<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
</head>
<body>
	
	
	<nav
		class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 navbar-light bg-white border-bottom border-bottom-lg-0 border-end-lg"
		id="navbarVertical">
		<div class="container-fluid">
			<!-- Toggler -->
			<button class="navbar-toggler ms-n2" type="button"
				data-bs-toggle="collapse"
				aria-controls="sidebarCollapse" aria-expanded="false"
				aria-label="Toggle navigation" onclick="showCollapse()">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- Brand -->
			<a class="navbar-brand py-lg-2 mb-lg-5 px-lg-6 me-0" href="#">
				<h3 class="text-success">
					<img src="https://bytewebster.com/img/logo.png" width="40"><span
						class="text-info">BYTE</span>WEBSTER
				</h3>
			</a>
			<!-- User menu (mobile) -->
			<div class="navbar-user d-lg-none">
				<!-- Dropdown -->
				<div class="dropdown">
					<!-- Toggle -->
					<a href="#" id="sidebarAvatar" role="button"
						data-bs-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">
						<div class="avatar-parent-child">
							<img alt="Image Placeholder"
								src="https://images.unsplash.com/photo-1548142813-c348350df52b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80"
								class="avatar avatar- rounded-circle"> <span
								class="avatar-child avatar-badge bg-success"></span>
						</div>
					</a>
					<!-- Menu -->
					<div class="dropdown-menu dropdown-menu-end"
						aria-labelledby="sidebarAvatar">
						<a href="#" class="dropdown-item">Profile</a> <a href="#"
							class="dropdown-item">Settings</a> <a href="#"
							class="dropdown-item">Billing</a>
						<hr class="dropdown-divider">
						<a href="#" class="dropdown-item">Logout</a>
					</div>
				</div>
			</div>
			<!-- Collapse -->
			<div class="collapse navbar-collapse" id="sidebarCollapse">
				<!-- Navigation -->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="bi bi-house"></i> Dashboard
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="bi bi-bar-chart"></i> Analitycs
					</a></li>

					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="bi bi-bookmarks"></i> Collections
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.servletContext.contextPath}/admin/users?page=1">
							<i class="bi bi-people"></i> Users
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.servletContext.contextPath}/admin/products?page=1">
							<div style="min-width: 1.875rem">
								<svg xmlns="http://www.w3.org/2000/svg" height="1em"
									viewBox="0 0 640 512"
									style="min-width: auto; aspect-ratio: 1/1; opacity: 0.4">
									<!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
									<path
										d="M64 160C64 89.3 121.3 32 192 32H448c70.7 0 128 57.3 128 128v33.6c-36.5 7.4-64 39.7-64 78.4v48H128V272c0-38.7-27.5-71-64-78.4V160zM544 272c0-20.9 13.4-38.7 32-45.3c5-1.8 10.4-2.7 16-2.7c26.5 0 48 21.5 48 48V448c0 17.7-14.3 32-32 32H576c-17.7 0-32-14.3-32-32H96c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32V272c0-26.5 21.5-48 48-48c5.6 0 11 1 16 2.7c18.6 6.6 32 24.4 32 45.3v48 32h32H512h32V320 272z" /></svg>

							</div> Products
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.servletContext.contextPath}/admin/orders?page=1">
							<i class="fa-solid fa-clipboard-list"></i></i> Orders
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="bi bi-file-text"></i> Posts
					</a></li>
				</ul>
				<!-- Divider -->
				<hr class="navbar-divider my-5">
				<!-- Navigation -->
	
				<input type="hidden" id='servlet' value="${pageContext.servletContext.contextPath}">
			
				<!-- User (md) -->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="bi bi-person-square"></i> Account
					</a></li>
					
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="confirmLogout()"> <i class="bi bi-box-arrow-left"></i>
							Logout
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
	const servlet  = document.getElementById('servlet').value;
	const hrefValue = servlet + "/logout";
		function confirmLogout() {
			event.preventDefault();
			  Swal.fire({
				    title: 'Are you sure?',
				    text: "You will be able to log out app!",
				    icon: 'warning',
				    showCancelButton: true,
				    confirmButtonColor: '#3085d6',
				    cancelButtonColor: '#d33',
				    confirmButtonText: 'Log out'
				  }).then((result) => {
				    if (result.isConfirmed) {
				    	
				      window.location.href = hrefValue;
				    }
				  })
		}
		
		function showCollapse() {
			document.getElementById('sidebarCollapse').classList.toggle('show')
		}
		</script>
		
		
</body>
</html>