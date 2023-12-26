/**
 * 
 */

const coupon_insert = document.getElementById("coupon-insert");
if (coupon_insert.value === 'success') {
	swal("Success", "The coupon has been added for this order!", "success");
} else if (coupon_insert.value === 'fail') {
	swal("Sorry", "The coupon has not exist or expired!", "error");
}

// Hàm để gọi API và lấy danh sách tỉnh
async function fetchProvinces() {
	const response = await fetch('https:/vapi.vnappmob.com/api/province');
	const data = await response.json();
	const provinceSelect = document.getElementById('p_province');

	// Xóa các tùy chọn hiện tại
	provinceSelect.innerHTML = '<option value="" disabled selected hidden>Select a province</option>';

	// Thêm tùy chọn cho mỗi tỉnh
	data.results.forEach(province => {
		const option = document.createElement('option');
		option.value = province.province_name;
		option.textContent = province.province_name;
		option.setAttribute('data-id', province.province_id);
		provinceSelect.appendChild(option);
	});


}

// Hàm để gọi API và lấy danh sách quận/huyện dựa trên tỉnh đã chọn
async function fetchDistricts() {
	const provinceId = document.getElementById('p_province').dataset.id;

	const districtSelect = document.getElementById('d_district');

	// Nếu chưa chọn tỉnh, đặt tùy chọn mặc định cho quận/huyện và thoát
	if (!provinceId) {
		districtSelect.innerHTML = '<option value="" disabled selected hidden>Not selected</option>';
		return;
	}


	const response = await fetch("https:/vapi.vnappmob.com/api/province/district/" + provinceId);
	const data = await response.json();

	// Xóa các tùy chọn hiện tại
	districtSelect.innerHTML = '<option value="" disabled selected hidden>Select a district</option>';
	districtSelect.value = '';

	// Thêm tùy chọn cho mỗi quận/huyện
	data.results.forEach(district => {
		const option = document.createElement('option');
		option.value = district.district_name;
		option.textContent = district.district_name;
		option.setAttribute('data-id', district.district_id);
		districtSelect.appendChild(option);
	});

	ableDetailAddress();
}

// Hàm để gọi API và lấy danh sách quận/huyện dựa trên tỉnh đã chọn
async function fetchWards() {
	const districtId = document.getElementById('d_district').dataset.id;
	const wardSelect = document.getElementById('w_ward');

	// Nếu chưa chọn tỉnh, đặt tùy chọn mặc định cho quận/huyện và thoát
	if (!districtId) {
		wardSelect.innerHTML = '<option value="" disabled selected hidden>Not selected</option>';
		return;
	}

	const response = await fetch("https:/vapi.vnappmob.com/api/province/ward/" + districtId);
	const data = await response.json();

	// Xóa các tùy chọn hiện tại
	wardSelect.innerHTML = '<option value="" disabled selected hidden>Select a ward</option>';
	wardSelect.value = '';

	// Thêm tùy chọn cho mỗi quận/huyện
	data.results.forEach(district => {
		const option = document.createElement('option');
		option.value = district.ward_name;
		option.textContent = district.ward_name;

		wardSelect.appendChild(option);
	});

	ableDetailAddress();

}

// enable address deatail input
function enableDetailAddress() {
	const c_address = document.getElementById("c_address");
	c_address.disabled = false;
	c_address.removeAttribute('title');
	c_address.style.cursor = 'text';
}

// disable address deatail input
function disableDetailAddress() {
	const c_address = document.getElementById("c_address");
	c_address.disabled = true;
	c_address.setAttribute('title', "Please select ward before entering here");
	c_address.style.cursor = 'not-allowed';
}

function ableDetailAddress() {
	const province = document.getElementById("p_province").value;
	const district = document.getElementById("d_district").value;
	const ward = document.getElementById("w_ward").value;

	if (province !== '' && district !== '' && ward !== '') {

		enableDetailAddress();
	} else {
		disableDetailAddress();
	}

}


function setDataId(id) {
	const selectElement = document.getElementById(`${id}`);
	const selectedIndex = selectElement.selectedIndex;

	// Sử dụng selectedIndex để lấy thông tin về option được chọn
	const selectedOption = selectElement.options[selectedIndex];

	// set data-id
	selectElement.setAttribute("data-id", selectedOption.dataset.id);


}

// Khi trang được tải, gọi hàm fetchProvinces để hiển thị danh sách tỉnh
fetchProvinces();

const debounce = (func, delay) => {
	let timeoutId;

	return function() {
		const context = this;
		const args = arguments;

		clearTimeout(timeoutId);

		timeoutId = setTimeout(() => {
			func.apply(context, args);
		}, delay);
	};
};

const selectAddress = (value) => {
	document.getElementById("c_address").value = value;
	document.getElementById("addressOptions").innerHTML = "";
	document.querySelector(".detail-add-notice").classList.remove("show");

};



const getNominatimSuggestions = debounce((query) => {
	let apiUrl = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`;

	fetch(apiUrl)
		.then(response => { document.querySelector(".loader-container").classList.remove("load"); return response.json() })
		.then(data => {
			const addressOptions = document.getElementById("addressOptions");

			if (data.length < 1) {

				query = document.getElementById("c_address").value;
				apiUrl = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`;
				fetch(apiUrl)
					.then(response => response.json())
					.then(data => {
						// Xóa các tùy chọn cũ
						addressOptions.innerHTML = "";

						if (data.length < 1) {
							const option = document.createElement("li");
							option.style.cursor = "default";
							option.textContent = "No result has found";
							addressOptions.appendChild(option);
						} else {

							data.forEach(result => {
								if (result.display_name.split(",").pop().trim().toLowerCase() === 'việt nam') {

									const option = document.createElement("li");
									option.textContent = result.display_name;
									option.addEventListener('click', () => selectAddress(result.display_name));
									addressOptions.appendChild(option);
								}
							});
						}

					})

			} else {



				// Xóa các tùy chọn cũ
				addressOptions.innerHTML = "";

				data.forEach(result => {
					if (result.display_name.split(",").pop().trim().toLowerCase() === 'việt nam') {

						const option = document.createElement("li");
						option.textContent = result.display_name;
						option.addEventListener('click', () => selectAddress(result.display_name));
						addressOptions.appendChild(option);
					}
				});
			}


		})
		.catch(error => { document.querySelector(".loader-container").classList.add("load"); console.error('Lỗi:', error) });

	document.querySelector(".loader-container").classList.add("load");
}, 600);


const checkValidAddress = (query) => {
	let apiUrl = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`;

	fetch(apiUrl)
		.then(response => response.json())
		.then(data => {
			if (data.length < 1) {
				document.querySelector(".detail-add-notice").classList.add("show");
			} else {

				const province = document.getElementById("p_province").value;
				const district = document.getElementById("d_district").value;
				const ward = document.getElementById("w_ward").value;

				const valuesToCheck = [province, district, ward];

				if (valuesToCheck.some(value => data.includes(value))) {
					// Nếu tất cả giá trị đều tồn tại trong chuỗi data
					document.querySelector(".detail-add-notice").classList.remove("show");
					console.log("Tất cả giá trị tồn tại trong chuỗi data.");
				} else {
					console.log("Ít nhất một giá trị không tồn tại trong chuỗi .");
					document.querySelector(".detail-add-notice").classList.add("show");
				}

			}
		})
		.catch(error => console.error('Lỗi:', error));

}
const getAddressSuggestions = () => {
	let inputAddress = document.getElementById("c_address").value;
	const province = document.getElementById("p_province").value;
	const district = document.getElementById("d_district").value;
	const ward = document.getElementById("w_ward").value;
	inputAddress = `${inputAddress}, ${ward}, ${district}, ${province}, Viet Nam`
	getNominatimSuggestions(inputAddress);
};

function addAddress(add) {
	const province = document.getElementById("p_province").value;
	const district = document.getElementById("d_district").value;
	const ward = document.getElementById("w_ward").value;
}


// setting c_address input
const c_address = document.getElementById("c_address");
if (c_address.value.trim() === "") {
	disableDetailAddress()
}

function removeCharactersBetweenCommas(inputString) {
	const parts = inputString.split(/[,\s]+/);

	parts.splice(1, 1);
	return parts.join(',');

}

function submitCouponForm(servlet, method = 'get') {

	const code = document.getElementById("c_code").value;
	const form = document.createElement('form');
	form.setAttribute('action', servlet);
	form.setAttribute('method', method.toLowerCase());

	const input = document.createElement('input');
	input.setAttribute('type', 'hidden');
	input.setAttribute('name', 'coupon');
	input.setAttribute('value', code);

	form.appendChild(input);

	// Thêm form vào DOM
	document.body.appendChild(form);

	// Gửi form
	form.submit();

	// Optional: Xóa form sau khi đã gửi đi (tùy thuộc vào yêu cầu của bạn)
	document.body.removeChild(form);
}

function submitOrderForm(servlet, method = 'get') {
	// Lấy tham chiếu đến form
	const formSub = document.getElementById('form');

	// Tạo một form mới
	const form = document.createElement('form');
	form.setAttribute('action', servlet);
	form.setAttribute('method', method.toLowerCase());

	// Sao chép các input từ form cũ sang form mới
	formSub.querySelectorAll('input').forEach(input => {
		const inputCopy = document.createElement('input');
		inputCopy.setAttribute('type', input.type);
		inputCopy.setAttribute('name', input.name);
		inputCopy.setAttribute('value', input.value);
		if (input.pattern) {

			inputCopy.setAttribute('pattern', input.pattern);
		}

		if (input.required) {

			inputCopy.setAttribute('required', 'required');
		}
		form.appendChild(inputCopy);
	});

	// Sao chép các input từ form cũ sang form mới
	formSub.querySelectorAll('select').forEach(input => {
		const inputCopy = document.createElement('select');

		inputCopy.setAttribute('name', input.name);
		inputCopy.setAttribute('value', input.value);


		if (input.required) {

			inputCopy.setAttribute('required', 'required');
		}
		form.appendChild(inputCopy);
	});

	// Thêm form vào DOM
	document.body.appendChild(form);

	console.log(form)
	// Gửi form
	//form.submit();

	// Optional: Xóa form sau khi đã gửi đi (tùy thuộc vào yêu cầu của bạn)
	document.body.removeChild(form);
}

