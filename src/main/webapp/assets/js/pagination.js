/**
 * 
 */
const pg = document.getElementById("pagination");
const pages = document.getElementById("pages");
const curPage = document.getElementById("curpage");
const numLinksTwoSide = document.getElementById("delta");
const checks = document.querySelectorAll(".check");
const btnNextPg = document.querySelector("button.next-page");
const btnPrevPg = document.querySelector("button.prev-page");
const btnFirstPg = document.querySelector("button.first-page");
const btnLastPg = document.querySelector("button.last-page");
const contextPath = document.getElementById("contextPath");


// when page load
// curPage.setAttribute('max', pages.value);
const valuePage = {
	truncate: true,
	curPage: parseInt(curPage.value),
	numLinksTwoSide: 1,
	totalPages: parseInt(pages.value)
};

pagination();

pg.onclick = (e) => {

	const ele = e.target;


	if (ele.dataset.page) {
		const pageNumber = parseInt(e.target.dataset.page, 10);

		valuePage.curPage = pageNumber;
		curPage.value = pageNumber;
		pagination(valuePage);

		handleButtonLeft();
		handleButtonRight();
	}
};

pages.onchange = () => {
	valuePage.totalPages = parseInt(pages.value, 10);
	handleCheckTruncate();
	handleCurPage();
	pagination();
	handleButtonLeft();
	handleButtonRight();
};
curPage.onchange = () => {
	handleCurPage();
	pagination();
	handleButtonLeft();
	handleButtonRight();
};
numLinksTwoSide.onchange = function() {
	if (this.value > 5) {
		this.value = 1;
		valuePage.numLinksTwoSide = 1;
	} else {
		valuePage.numLinksTwoSide = parseInt(this.value, 10);
	}
	pagination();
};

checks.forEach((check) => {
	check.onclick = (e) => {
		console.log(e.target);
		handleCheckTruncate();
		pagination();
	};
});

// DYNAMIC PAGINATION
function pagination() {
	const { totalPages, curPage, truncate, numLinksTwoSide: delta } = valuePage;

	const range = delta + 4; // use for handle visible number of links left side

	let render = "";
	let renderTwoSide = "";
	let dot = `<li class="pg-item"><a class="pg-link">...</a></li>`;
	let countTruncate = 0; // use for ellipsis - truncate left side or right side

	// use for truncate two side
	const numberTruncateLeft = curPage - delta;
	const numberTruncateRight = curPage + delta;

	let active = "";
	for (let pos = 1; pos <= totalPages; pos++) {
		console.log();
		active = pos === curPage ? "active" : "";

		// truncate
		if (totalPages >= 2 * range - 1 && truncate) {
			if (numberTruncateLeft > 3 && numberTruncateRight < totalPages - 3 + 1) {
				// truncate 2 side
				if (pos >= numberTruncateLeft && pos <= numberTruncateRight) {
					renderTwoSide += renderPage(pos, active);
				}
			} else {
				// truncate left side or right side
				if (
					(curPage < range && pos <= range) ||
					(curPage > totalPages - range && pos >= totalPages - range + 1) ||
					pos === totalPages ||
					pos === 1
				) {
					render += renderPage(pos, active);
				} else {
					countTruncate++;
					if (countTruncate === 1) render += dot;
				}
			}
		} else {
			// not truncate
			render += renderPage(pos, active);
		}
	}

	if (renderTwoSide) {
		renderTwoSide =
			renderPage(1) + dot + renderTwoSide + dot + renderPage(totalPages);
		pg.innerHTML = renderTwoSide;
	} else {
		pg.innerHTML = render;
	}
}

function renderPage(index, active = "") {
	
	const path = window.location.pathname;
	const param = new URLSearchParams(window.location.search);
	
	// param products page
	if (param.get('page') != null) {
		param.set('page', index);
	} 

	// param product detail page
	else if (param.get('id') != null) {
		param.set('comment_page', index);
		
	}
	
	
	const newParam = param.toString();
	
	
	const result = ` <li class="pg-item ${active}" data-page="${index}">
	        <a class="pg-link" href="${path}?${newParam}" >${index}</a>
	    </li>`
	return result;
}
function handleCurPage() {
	if (+curPage.value > pages.value) {
		curPage.value = 1;
		valuePage.curPage = 1;
	} else {
		valuePage.curPage = parseInt(curPage.value, 10);
	}
}
function handleCheckTruncate() {
	const truncate = document.querySelector("input[type=radio]:checked");

	if (truncate.id === "enable") {
		valuePage.truncate = true;
	} else {
		if (pages.value > 1000) {
			let isTruncate = confirm(
				`Are you sure you want to render all the links? number of pages: ${pages.value}`
			);
			// true => disable truncate
			if (isTruncate) {
				valuePage.truncate = false;
			} else {
				valuePage.truncate = true;
				truncate.removeAttribute("checked");
				document.getElementById("enable").checked = true;
			}
		} else {
			valuePage.truncate = false;
		}
	}
}

document.querySelector(".page-container").onclick = function(e) {
	handleButton(e.target);
	const pg_item = document.querySelector('.pg-item.active');

	pg_item.firstElementChild.click();
};


	


function handleButton(element) {
	
	if (element.classList.contains("first-page")) {
		console.log("first-page")
		valuePage.curPage = 1;
		handleButtonLeft();
	} else if (element.classList.contains("last-page")) {
		console.log("last-page")
		valuePage.curPage = parseInt(pages.value, 10);
		handleButtonRight();
	} else if (element.classList.contains("prev-page")) {
		console.log("prev-page")
		valuePage.curPage--;
		handleButtonLeft();
		btnNextPg.disabled = false;
		btnLastPg.disabled = false;
	} else if (element.classList.contains("next-page")) {
		console.log("next-page")
		valuePage.curPage++;
		handleButtonRight();
		btnPrevPg.disabled = false;
		btnFirstPg.disabled = false;
	}
	pagination();
}
function handleButtonLeft() {
	
	if (valuePage.totalPages === 1) {
		console.log("not prev")
		btnPrevPg.disabled = true;
		btnFirstPg.disabled = true;
		btnNextPg.disabled = true;
		btnLastPg.disabled = true;
	}
	else if (valuePage.curPage === 1) {
		console.log("not prev")
		btnPrevPg.disabled = true;
		btnFirstPg.disabled = true;
		btnNextPg.disabled = false;
		btnLastPg.disabled = false;
	} else {
		console.log("can prev")
		btnPrevPg.disabled = false;
		btnFirstPg.disabled = false;
	}
}
function handleButtonRight() {
	
	if (valuePage.totalPages === 1) {
		console.log("not prev")
		btnPrevPg.disabled = true;
		btnFirstPg.disabled = true;
		btnNextPg.disabled = true;
		btnLastPg.disabled = true;
	} else if (valuePage.curPage === valuePage.totalPages) {
		console.log("not next")
		btnNextPg.disabled = true;
		btnLastPg.disabled = true;
		btnPrevPg.disabled = false;
		btnFirstPg.disabled = false;
	} else {
		console.log("can next ")
		btnNextPg.disabled = false;
		btnLastPg.disabled = false;
	}
}


handleButtonLeft();
	handleButtonRight();


