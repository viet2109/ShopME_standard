/**
 * 
 *//**
 * 
 */
const allStar = document.querySelectorAll('.rating .star')
const ratingValue = document.querySelector('.rating input')
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




var star = document.getElementById('rating');
var comment = document.getElementById('content-comment').value;

var form = document.getElementById('form');
function validateForm() {
	event.preventDefault();
	if (parseInt(star.value) < 1) {
		console.log('run validate');
		swal("Sorry", "Please rate the product!", "error");
		return false;
	}
	
	return true;
}
var checkCmtValue = document.getElementById('checkCmt').value;
var check
function checkCmt() {
		if(checkCmtValue == 'true'){
			swal("Congrats", "Review submitted successfully. !", "success");
			return true;
		}else if(checkCmtValue == 'false'){
			swal("Sorry", "Review submission failed. !", "error");
			displayStars(0);
			return false;
		}else {
			check = 'null'
		}
}
var rating = document.getElementById('rating').value;
function displayStars(rating) {
   /* if(checkCmt == 'false'){
		const rating = -1;
	}else {
		const rating = parseInt(ratingValue.value);
	}*/
	

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
window.onload = function () {
    if(user.value !== ''){
		checkCmt()
		if(check === 'null'){
			displayStars(rating)
		}
	}
	
};



document.getElementById('cancelButton').addEventListener('click', function() {
	// Lấy thẻ textarea và radio button
	console.log('cancel button');
	var textarea = document.getElementById('content-comment');
	var radio = document.getElementById('rating');
	

	// Xóa văn bản trong textarea
	textarea.value = '';
	radio.value = 0;
	
	// Bỏ chọn radio button nếu có
	allStar.forEach((star) => {
		star.classList.remove('active');
		star.classList.replace('bxs-star', 'bx-star');
		
	})
});

