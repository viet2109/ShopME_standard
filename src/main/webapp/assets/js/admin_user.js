/**
 * 
 */
console.log('Test');
	// Hàm để gọi API và lấy danh sách tỉnh
	async function fetchProvinces() {
		console.log('fetchProvinces')
		const response = await fetch('https:/vapi.vnappmob.com/api/province');
		const data = await response.json();
		const provinceSelect = document.getElementById('p_province');
		console.log(provinceSelect)

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
		console.log('fetch')
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

	let addList = [];


	const getNominatimSuggestions = debounce((query) => {
		let apiUrl = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`;

		fetch(apiUrl)
			.then(response => { document.querySelector(".loader-container").classList.remove("load"); return response.json() })
			.then(data => {
				const addressOptions = document.getElementById("addressOptions");

				if (data.length < 1) {
					console.log('log2')
					const province = document.getElementById("p_province").value;
					const district = document.getElementById("d_district").value;
					const ward = document.getElementById("w_ward").value;
					query = document.getElementById("c_address").value;
					apiUrl = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(`${query}`)}`;
					fetch(apiUrl)
						.then(response => response.json())
						.then(data => {
							// Xóa các tùy chọn cũ

							addressOptions.innerHTML = "";
							const addL = data.filter(add =>  removeVietnameseDiacritics(add.display_name).includes(removeVietnameseDiacritics(ward)) || removeVietnameseDiacritics(add.display_name).includes(removeVietnameseDiacritics(district)) || removeVietnameseDiacritics(add.display_name).includes(removeVietnameseDiacritics(province)))
							if (addL.length < 1) {
								const option = document.createElement("li");
								option.style.cursor = "default";
								option.textContent = "No result has found";
								addressOptions.appendChild(option);
							} else {
								addList = addL;
								addList.forEach(result => {
									const option = document.createElement("li");
									option.textContent = result.display_name;
									option.addEventListener('click', () => selectAddress(result.display_name));
									addressOptions.appendChild(option);
									
								});
							}



						})

				} else {
					// Xóa các tùy chọn cũ
					console.log("log1")
					addressOptions.innerHTML = "";
					addList = data
					data.forEach(result => {
						const option = document.createElement("li");
						option.textContent = result.display_name;
						option.addEventListener('click', () => selectAddress(result.display_name));
						addressOptions.appendChild(option);
						
					});
				}


			})
			.catch(error => { document.querySelector(".loader-container").classList.add("load"); console.error('Lỗi:', error) });

		document.querySelector(".loader-container").classList.add("load");
	}, 600);


	const checkValidAddress = (query) => {


		if (!addList.some(add => removeCharactersBetweenCommas(add.display_name.trim()) === removeCharactersBetweenCommas(query.trim()))) {
			document.querySelector(".detail-add-notice").classList.add("show");
			document.querySelector('input[name="address-constraint"]').value=""
			console.log("false")
		} else {
			console.log("true")
			document.querySelector('input[name="address-constraint"]').value="true"
		}

	}
	const getAddressSuggestions = () => {
		let inputAddress = document.getElementById("c_address").value;
		const province = document.getElementById("p_province").value;
		const district = document.getElementById("d_district").value;
		const ward = document.getElementById("w_ward").value;
		inputAddress = `${inputAddress}, ${ward}, ${district}, ${province}, Viet Nam`
		getNominatimSuggestions(inputAddress);
	};




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

	function submitOrderForm(form) {
		event.preventDefault();
		Swal.fire({
		    title: 'Are you sure?',
		    text: "The order will be placed after you confirm!",
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonColor: '#3085d6',
		    cancelButtonColor: '#d33',
		    confirmButtonText: 'Yes, order it!'
		  }).then((result) => {
		    if (result.isConfirmed) {
		      form.submit();
		    }
		  })
	}
	function removeVietnameseDiacritics(str) {
	    return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
	}
	
	function showProfile(e){
		document.getElementById('showProfile').style.display='block';
		document.getElementById('showProfile').style.display='block';
		document.querySelector('#user_id').value=e.dataset.userId;
		document.querySelector('#name_edit').value=e.dataset.userName;
		document.querySelector('#email_edit').value=e.dataset.userEmail;
		document.querySelector('#phone_edit').value=e.dataset.userPhone;
		document.querySelector('#dob_edit').value=e.dataset.userDob;
		document.querySelector('#p_province').firstElementChild.value=e.dataset.userProvince;
		document.querySelector('#p_province').firstElementChild.innerHTML=e.dataset.userProvince;
		document.querySelector('#d_district').firstElementChild.value=e.dataset.userDistrict;
		document.querySelector('#d_district').firstElementChild.innerHTML=e.dataset.userDistrict;
		document.querySelector('#w_ward').firstElementChild.value=e.dataset.userWard;
		document.querySelector('#w_ward').firstElementChild.innerHTML=e.dataset.userWard;
		document.querySelector('#c_address').value=e.dataset.userDetailaddress;
		

	}