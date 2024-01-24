<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.hidden {
	visibility: hidden;
    height: 0;
    padding: 0;
    margin: 0!important;
  
	}
</style>
</head>
<body>
	<!-- End User dialog box -->
	<div class="modal " id="showProfile"
		style="background: rgba(0, 0, 0, 0.4);">
		<div class="modal-dialog modal-lg " style="max-width: 50%;">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Edit user</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						onclick="document.getElementById('showProfile').style.display='none';"></button>
				</div>
				<!-- Modal body -->
				<form action="${pageContext.servletContext.contextPath}/admin/users?page=${param.page}"
					method="post">
					<input type="hidden" value="edit_user" name="action"> <input
						type="hidden" name="user_id" id="user_id">
					<div class="modal-body row" style="overflow-x: hidden;">
						<h3 class="text-center text-dark">Customer Information</h3>
						<div class="row mt-5 ">
							<div class="col-md-3">
								<img alt="..."
									src="${pageContext.servletContext.contextPath}/assets/images/user-avatar.png"
									class="avatar avatar-sm rounded-circle me-2"
									style="width: 100px; height: auto">
							</div>
							<div class="col-md-8 text-start">
								<div class="row mt-5">
									<p class="col-md-4 text-dark">
										<strong>Name:</strong>
									</p>
									<input name="name" id="name_edit" class="form-control"
										value="${u.lastName} ${u.firstName}" type="text"
										required="required" />
								</div>
								<div class="row mt-5">
									<p class="col-md-4 text-dark">
										<strong>Date of birthday:</strong>
									</p>
									<input name="dob" id="dob_edit" class="form-control"
										value="${u.dob}" type="date" required="required" />
								</div>
								<div class="row mt-5">
									<p class="col-md-4 text-dark">
										<strong>Email:</strong>
									</p>
									<input name="email" id="email_edit" class="form-control"
										value="${u.email}" type="email" required />
								</div>
								<div class="row mt-5">
									<p class="col-md-4 text-dark">
										<strong>Phone:</strong>
									</p>
									<input name="phone" id="phone_edit" class="form-control"
										value="${u.phone}" type="tel" pattern="^\s*\d(?:\s*\d){9}\s*$"
										required />
								</div>
								<div class="row mt-5">
									<select class="form-select" name="role" id="role">
										<option class="text-capitalize" value="0">Admin</option>
										<option class="text-capitalize" value="1">User</option>
									</select>
								</div>

								<div id="showInfoUser" class="my-5">
									<div class="row mt-5">
										<p class="col-md-4 text-dark">
											<strong>Address:</strong>
										</p>
										<div class="form-group">
											<label for="c_country" class="text-black">Country <span
												class="text-danger">*</span>
											</label> <select name="p_province" id="p_province"
												required="required" class="form-control"
												onchange="setDataId(this.id); fetchDistricts()">
												<option value="" disabled="disabled" selected
													hidden="hidden">Select a country</option>

											</select>
										</div>

										<div class="form-group">
											<label for="c_country" class="text-black">District <span
												class="text-danger">*</span>
											</label> <select name="d_district" id="d_district"
												required="required" class="form-control"
												onchange="setDataId(this.id);  fetchWards()">
												<option value="" disabled="disabled" selected
													hidden="hidden">Select a district</option>

											</select>
										</div>

										<div class="form-group">
											<label for="c_country" class="text-black">Ward<span
												class="text-danger">*</span></label> <select name="w_ward"
												id="w_ward" required="required" class="form-control"
												onchange="ableDetailAddress()">
												<option value="" disabled="disabled" selected
													hidden="hidden">Select a ward</option>

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
														placeholder="Apartment, suite, unit etc."
														autocomplete="off" oninput="getAddressSuggestions()"
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
												<p class="detail-add-notice">Địa chỉ không chính xác,
													vui lòng kiểm tra lại địa chỉ</p>
											</div>
										</div>

										<input
											style="height: 0; padding: 0; margin: 0; width: 0; border: none; position: absolute;"
											type="text" name='address-constraint' required="required"
											value="true" />

									</div>


								</div>
							</div>


						</div>
						<div id="showPurchaseHistory" class="">
							<h3 class="text-center text-dark mt-5">Purchase History</h3>
							<div
								style="width: 100%; display: flex; justify-content: center; margin-top: 10px;">
								<button id="see-more-button" type="button"
									data-url="${pageContext.servletContext.contextPath }/admin/users"
									class="btn btn-primary w-auto justify-content-center align-items-center">See
									More</button>
							</div>
							<div class="row mt-5 " id="purchaseHistory"></div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer mt-5">
							<button type="submit"
								class="submit btn btn-success w-auto my-2 px-5">Submit</button>
							<button type="button" class="btn btn-danger"
								onclick="document.getElementById('showProfile').style.display='none';">Close</button>
						</div>
				</form>
			</div>
		</div>
	</div>
	<!-- End User dialog box -->
</body>
</html>