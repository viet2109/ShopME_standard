/**
 * 
 *//**
* 
*/
const commentForm = document.getElementById('form');
const cmts = document.getElementById('cmt');
const cmt = localStorage.getItem("cmt");
const rating = document.getElementById('rating');
const comment = document.getElementById('content-comment');
const allStar = document.querySelectorAll('.rating .star')
const ratingValue = document.querySelector('.rating #rating')

checkCmt();

const handleSubmit = () => {
	event.preventDefault();
	const user = document.getElementById('user').value;
	if (user === 'no exist') {

		showSweetAlert();
	} 
	else {
		commentForm.submit();
	}
}

function showSweetAlert() {
	Swal.fire({
		title: 'Are you sure?',
		text: "You need login to comment this product!",
		icon: 'info',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Go to login page!'
	}).then((result) => {
		if (result.isConfirmed) {
			commentForm.submit();
		}
	})
}

allStar.forEach((item, idx) => {
	item.addEventListener('click', function() {
		let click = 0
		ratingValue.value = idx + 1

		allStar.forEach(i => {
			i.classList.replace('bxs-star', 'bx-star')
			i.classList.remove('active')
		})
		for (let i = 0; i < allStar.length; i++) {
			if (i <= idx) {
				allStar[i].classList.replace('bx-star', 'bxs-star')
				allStar[i].classList.add('active')
			} else {
				allStar[i].style.setProperty('--i', click)
				click++
			}
		}
	})
})

function validateForm() {
	event.preventDefault();
	if (parseInt(rating.value) < 1) {
	
		swal("Sorry", "Please rate the product!", "error");
		return false;
	}

	return true;
}

function checkCmt() {
	const checkCmtValue = cmts.value;
	if (checkCmtValue == 'true') {
		swal("Congrats", "Review submitted successfully. !", "success");
		return true;
	} else if (checkCmtValue == 'false') {
		swal("Sorry", "Review submission failed. !", "error");
		displayStars(0);
		return false;
	}
}

function displayStars(rating) {

	// Đặt giá trị cho mỗi sao dựa vào giá trị của input
	for (let i = 0; i < allStar.length; i++) {
		if (i < rating) {
			allStar[i].classList.replace('bx-star', 'bxs-star');
			allStar[i].classList.add('active');
		} else {
			allStar[i].classList.replace('bxs-star', 'bx-star');
			allStar[i].classList.remove('active');
		}
	}
}

document.getElementById('cancelButton').addEventListener('click', function() {
	


	// Xóa văn bản trong textarea
	comment.value = '';
	rating.value = 0;

	// Bỏ chọn radio button nếu có
	allStar.forEach((star) => {
		star.classList.remove('active');
		star.classList.replace('bxs-star', 'bx-star');

	})
});






