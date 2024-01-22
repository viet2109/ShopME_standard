

(function() {
	'use strict';



	var tinyslider = function() {
		var el = document.querySelectorAll('.testimonial-slider');

		if (el.length > 0) {
			var slider = tns({
				container: '.testimonial-slider',
				items: 1,
				axis: "horizontal",
				controlsContainer: "#testimonial-nav",
				swipeAngle: false,
				speed: 700,
				nav: true,
				controls: true,
				autoplay: true,
				autoplayHoverPause: true,
				autoplayTimeout: 3500,
				autoplayButtonOutput: false
			});
		}
	};
	tinyslider();




	var sitePlusMinus = function() {

		var value,
			quantity = document.getElementsByClassName('quantity-container');

		function createBindings(quantityContainer) {
			var quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
			var increase = quantityContainer.getElementsByClassName('increase')[0];
			var decrease = quantityContainer.getElementsByClassName('decrease')[0];
			increase.addEventListener('click', function(e) { increaseValue(e, quantityAmount, quantityAmount.dataset.id); });
			decrease.addEventListener('click', function(e) { decreaseValue(e, quantityAmount, quantityAmount.dataset.id); });
		}

		function init() {
			for (var i = 0; i < quantity.length; i++) {
				createBindings(quantity[i]);
			}
		};

		function increaseValue(event, quantityAmount, product_id) {
			value = parseInt(quantityAmount.value, 10);

			value = isNaN(value) ? 1 : value;
			value++;
			quantityAmount.value = value;

			const selected = document.getElementById(`check-product-${product_id}`).checked ? 1 : 0;
			updateProduct(product_id, value, selected)

		}

		function decreaseValue(event, quantityAmount, product_id) {
			value = parseInt(quantityAmount.value, 10);

			value = isNaN(value) ? 1 : value;
			if (value > 1) value--;

			const selected = document.getElementById(`check-product-${product_id}`).checked ? 1 : 0;
			updateProduct(product_id, value, selected)
		}



		init();

	};
	sitePlusMinus();
	const updateProduct = (product_id, quantity, selected) => {
		document.getElementById("update_input_quantity").value = quantity;
		document.getElementById("update_input_selected").value = selected;
		document.getElementById("update_input_id").value = product_id;

		document.getElementById("update_product").submit();


	}

})();

function checkAllInputs(checked) {
	// Lấy danh sách tất cả các input có id bắt đầu bằng "check-product-"
	var inputs = document.querySelectorAll('[id^="check-product-"]');
	console.log(checked)

	// Lặp qua danh sách input và đặt giá trị checked cho mỗi input
	inputs.forEach(function(input) {
		input.checked = checked;
		// Tạo và kích hoạt sự kiện change
        var event = new Event('change');
        input.dispatchEvent(event);
        
	});
}















