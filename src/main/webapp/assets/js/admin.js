/**
 * 
 */

/*admin_user*/
const status = document.getElementById("status").value;
checkStatus();
function checkStatus() {
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
		const type = tag.className === 'show-pass' ? 'password' : 'text';
		tag.parentNode.getElementsByTagName('input')[0].type = type;
	}
	console.log('admin.js: ', status)
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
	} else if (status == "update_failed_user") {
		swal("Sorry", "Unable to update user information!", "error");
	}else if (status == "update_success_user") {
		swal("Congrats", "Update user information successfully!", "success");
	}else if (status == "insert_failed_category") {
		swal("Sorry", "Unable to insert category!", "error");
	}else if (status == "insert_success_category") {
		swal("Congrats", "Insert category successfully!", "success");
	}else if (status == "insert_failed_product") {
		swal("Sorry", "Unable to insert product!", "error");
	}else if (status == "insert_success_product") {
		swal("Congrats", "Insert product successfully!", "success");
	}else if (status == "update_product_failed") {
		swal("Sorry", "Unable to update product information!", "error");
	}else if (status == "update_product_success") {
		swal("Congrats", "Update product information successfully!", "success");
	}
}

/* Bat loi khi them user */
const submitForm = document.getElementById('create-user-form');
submitForm.onsubmit = (e) => {
	e.preventDefault();

	const email = document.getElementById('email');
	const phone_number = document.getElementById('contact');
	const pass = document.getElementById('pass');
	const re_pass = document.getElementById('re_pass');
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

// Delete user
const delete_user = document.querySelector('#delete_user');
const delete_input = document.querySelector('#delete_input');
function swal(title, mess, status) {
	Swal.fire({
		title: title,
		text: mess,
		icon: status
	})
}
function showDeleteConfirmation(formId, inputId, button) {
	const deleteForm = document.getElementById(formId);
	const deleteInput = document.getElementById(inputId);

	Swal.fire({
		title: 'Are you sure?',
		text: "You won't be able to revert this!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes, delete it!'
	}).then((result) => {
		if (result.isConfirmed) {
			// Sử dụng datasetKey để lấy giá trị từ thuộc tính data-* của button
			deleteInput.value = button.dataset.id;
			
			
			
			deleteForm.submit();
			localStorage.setItem('delete', "true");
		}
	});
}
document.addEventListener('DOMContentLoaded', function () {
	    const isDeleted = localStorage.getItem("delete");

	    if (localStorage.getItem("delete") === 'true') {
			if(status == "delete_failed"){
				Swal.fire(
						'Cannot Delete!',
						'Record cannot be deleted.',
						'error'
					);
			}else{
			Swal.fire(
				'Deleted!',
				'Record has been successfully deleted.',
				'success'
			);
			}
			localStorage.removeItem("delete");
		}
	});
	

/*Lấy dữ liệu order của user*/
/* fetch data orders of user */
function onButtonSeeMoreClick() {
	const buttonId = 'see-more-button';
	const elem = document.getElementById(buttonId);
	const url = "http://localhost:8080" + elem.getAttribute('data-url');
	const customerId = elem.getAttribute('data-user-id');
	/* const url = "http://localhost:8080/ShopMe_standard/admin/users"; */
	fetch(url, {
		method: 'POST',
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ action: 'purchase_history', customerId })
	})
		.then(response => response.json())
		.then(function(data) {


			console.log(data)
			displayDataInTable(data);
		})
		.catch(error => {
			console.error('Error:', error);
		});
}

window.addEventListener("load", (event) => {
	const button = document.querySelector('#see-more-button');
	button.addEventListener("click", () => onButtonSeeMoreClick());
	
});

function displayDataInTable(data) {
	/*  const tableBody = document.getElementById('purchase-history-body'); */
	const purchaseHistoryDiv = document.getElementById('purchaseHistory');
	// Xóa dữ liệu cũ trong bảng

	if (data.length > 0) {
		// Nếu có dữ liệu, hiển thị bảng
		purchaseHistoryDiv.innerHTML = ''; // Xóa bất kỳ thông báo nào cũ
		const table = document.createElement("table");
		table.className = "table table-hover table-nowrap";

		const thead = document.createElement("thead");
		thead.className = "thead-light";
		const tr = document.createElement("tr");

		const headerColumns = ["Order ID", "Customer Name", "Date", "Total", "Payment"];
		headerColumns.forEach((header, index) => {
			const th = document.createElement("th");
			th.scope = "col";
			th.textContent = header;
			th.setAttribute("col-index", index + 2);
			tr.appendChild(th);
		});

		thead.appendChild(tr);
		table.appendChild(thead);

		const tbody = document.createElement("tbody");

		data.forEach(item => {
			const tr = document.createElement("tr");

			const orderIdTd = document.createElement("td");
			orderIdTd.textContent = item.id;
			tr.appendChild(orderIdTd);

			const customerNameTd = document.createElement("td");
			customerNameTd.textContent = item.customerName;
			tr.appendChild(customerNameTd);

			const dateTd = document.createElement("td");
			dateTd.textContent = item.date;
			tr.appendChild(dateTd);

			const totalTd = document.createElement("td");
			totalTd.textContent = "$" + parseFloat(item.total).toLocaleString(undefined, { maximumFractionDigits: 2 });
			tr.appendChild(totalTd);

			const paymentTd = document.createElement("td");
			paymentTd.textContent = item.payment;
			tr.appendChild(paymentTd);

			tbody.appendChild(tr);
		});

		table.appendChild(tbody);
		purchaseHistoryDiv.appendChild(table);
	} else {
		// Nếu không có dữ liệu, hiển thị thông báo
		const notification = document.createElement("div");
		notification.textContent = 'No orders.';
		notification.className = 'text-center text-dark';
		purchaseHistoryDiv.appendChild(notification);

	}
}

