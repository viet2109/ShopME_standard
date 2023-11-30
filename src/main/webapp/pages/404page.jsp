<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		body {
			margin: 0;
			padding: 0;
			font-family: 'Tomorrow', sans-serif;
			height: 100vh;
			background-image: linear-gradient(to top, #2e1753, #1f1746, #131537, #0d1028, #050819);
			display: flex;
			justify-content: center;
			align-items: center;
			overflow: hidden;
		}

		.text {
			position: absolute;
			top: 10%;
			color: #fff;
			text-align: center;
		}

		h1 {
			font-size: 50px;
		}
		
		.home-button {
			color: #fff;
		    width: 115px;
		    height: 50px;
		    background-color: #333;
		    border-radius: 10px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    text-decoration: none;
		    font-weight: 600;
		    margin-top: 25px;
			transition: 0.5s;
		}
		
		.home-button:hover {
		
			background-color: #ccc;
			color: #333;
		}

		.star {
			position: absolute;
			width: 2px;
			height: 2px;
			background: #fff;
			right: 0;
			animation: starTwinkle 3s infinite linear;
		}

		.astronaut img {
			width: 100px;
			position: absolute;
			top: 55%;
			animation: astronautFly 6s infinite linear;
		}

		@keyframes astronautFly {
			0% {
				left: -100px;
			}

			25% {
				top: 50%;
				transform: rotate(30deg);
			}

			50% {
				transform: rotate(45deg);
				top: 55%;
			}

			75% {
				top: 60%;
				transform: rotate(30deg);
			}

			100% {
				left: 110%;
				transform: rotate(45deg);
			}
		}

		@keyframes starTwinkle {
			0% {
				background: rgba(255, 255, 255, 0.4);
			}

			25% {
				background: rgba(255, 255, 255, 0.8);
			}

			50% {
				background: rgba(255, 255, 255, 1);
			}

			75% {
				background: rgba(255, 255, 255, 0.8);
			}

			100% {
				background: rgba(255, 255, 255, 0.4);
			}
		}
		
		
	</style>
</head>
<body>
<div class="text">
		<div>ERROR</div>
		<h1>404</h1>
		<hr>
		<div>Page Not Found</div>
		<a class="home-button" href="${pageContext.servletContext.contextPath}/home">Go to home</a>
	</div>
	

	<div class="astronaut">
		<img src="https://images.vexels.com/media/users/3/152639/isolated/preview/506b575739e90613428cdb399175e2c8-space-astronaut-cartoon-by-vexels.png"
			alt="" class="src">
	</div>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {

			var body = document.body;
			setInterval(createStar, 1000);
			function createStar() {
				var right = Math.random() * 500;
				var top = Math.random() * screen.height;
				var star = document.createElement("div");
				star.classList.add("star")
				body.appendChild(star);
				setInterval(runStar, 10);
				star.style.top = top + "px";
				function runStar() {
					if (right >= screen.width) {
						star.remove();
					}
					right += 3;
					star.style.right = right + "px";
				}
			}
		})
	</script>
</body>
</html>