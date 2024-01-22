<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="u" value="${param.customer }"/>
	<div class="modal " id="showProfile_u${u.id }">
		<div class="modal-dialog modal-lg " style="max-width: 50%;">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Edit user</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal body -->
				<form action="${pageContext.servletContext.contextPath}/admin/users"
					method="post">
					<input type="hidden" value="edit_role" name="action"> <input
						type="hidden" value="${u.id }" name="user_id"> <input
						type="text" class="d-none" value="${p.id }" name="product_id">
					<div class="modal-body row" style="overflow-x: hidden;">
						<h3 class="text-center text-dark">Customer Information</h3>
						<div class="row mt-5 ">
							<div class="col-md-3">
								<img alt="..."
									src="${pageContext.servletContext.contextPath}/assets/images/user-avatar.png"
									class="avatar avatar-sm rounded-circle me-2"
									style="width: 100px; height: auto">
							</div>
							<div class="col-md-4 text-start">
								<p class="text-dark">
									<strong>Id:</strong>
								</p>
								<p class="text-dark">
									<strong>Name:</strong>
								</p>
								<p class="text-dark">
									<strong>Date of birthday</strong>
								</p>
								<p class="text-dark">
									<strong>Email:</strong>
								</p>
								<p class="text-dark">
									<strong>Phone:</strong>
								</p>
								<p class="text-dark">
									<strong>Create date:</strong>
								</p>
								<p class="text-dark">
									<strong>Role:</strong>
								</p>
							</div>
							<div class="col-md-5 text-start">
								<p class="text-dark">${u.id}</p>
								<p class="text-dark">${u.lastName }${u.firstName }</p>
								<p class="text-dark">
									<fmt:formatDate pattern="dd-MM-yyyy" value="${u.dob}" />
								</p>
								<p class="text-dark">${u.email }</p>
								<p class="text-dark">${u.phone }</p>
								<p class="text-dark">
									<fmt:formatDate pattern="dd-MM-yyyy" value="${u.createDate}" />
								</p>
								<div class="form-group col-md-6 ">
									<select class="form-select" name="role">
										<option class="text-capitalize" value="${0 }"
											${(u.roles==0)?'selected':'' }>Admin</option>
										<option class="text-capitalize" value="${1 }"
											${(u.roles==1)?'selected':''}
											${sessionScope.user.id == u.id ? 'disabled' : '' }>User</option>
									</select>
								</div>
							</div>
						</div>
						<c:if test="${u.roles == 1 }">
							<h3 class="text-center text-dark mt-5">Purchase History</h3>
							<div class="row mt-5 "></div>
						</c:if>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit"
							class="submit btn btn-success w-auto my-2 px-5">Submit</button>
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal">Close</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>