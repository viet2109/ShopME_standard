<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/admin.css">
<link
	href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css"
	rel="stylesheet">
</head>
<body>
<!-- Header -->
			<header class="bg-surface-primary border-bottom p-6">
				<div class="container-fluid">
					<div class="mb-npx">
						<div class="row align-items-center">
							<div class="col-sm-6 col-12 mb-4 mb-sm-0">
								<!-- Title -->
								<h1 class="h2 mb-0 ls-tight">
									<img src="https://bytewebster.com/img/logo.png" width="40">
									ByteWebster Application
								</h1>
							</div>
							<!-- Actions -->
							<div class="col-sm-6 col-12 text-sm-end">
								<div class="mx-n1">
									<div class="btn d-inline-flex btn-sm btn-primary mx-1" onclick="toggleVisibility('${param.createItem}')">
										<span class=" pe-2"> <i class="bi bi-plus"></i>
									</span> <span>Create</span>
									</div> 
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</header>
	<script src="https://kit.fontawesome.com/68d5e1d296.js" crossorigin="anonymous"></script>
	<script type="text/javascript">
		function toggleVisibility(targetId) {
		    var targetDiv = document.getElementById(targetId);
	
		    if (targetDiv.style.display === 'none') {
		      targetDiv.style.display = 'block';
		    } else {
		      targetDiv.style.display = 'none';
		    }
		  }
	</script>
</body>
</html>