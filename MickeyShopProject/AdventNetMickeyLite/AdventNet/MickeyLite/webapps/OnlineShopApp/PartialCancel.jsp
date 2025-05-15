<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Insert title here</title>
<style>
body {
	background-color: #f8f9fa;
}

.sidebar {
	height: 100vh;
	width: 15vw;
	position: relatvie;
	top: 0;
	left: 0;
	background-color: #343a40;
	padding-top: 20px;
}

.sidebar a {
	color: white;
}

.sidebar a:hover {
	color: white;
	background-color: #495057;
}

.content {
	margin-left: 200px; /* Width of the sidebar */
	width: 85vw;
	padding: 20px;
	position: absolute;
	top: 0;
	right: 0;
	float: right;
}

.username {
	position: fixed;
	top: 20px;
	right: 20px;
	font-size: 18px;
	color: #343a40;
}

.input-group {
	width: 20vw;
}

.top-nav {
	display: flex;
	justify-content: space-between;
}

.cart-btn {
	height: 80%;
}

.cart-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.delete-button {
	cursor: pointer;
	color: red;
	font-size: 15px;
}

.logout-div {
	width: 25vw;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>
</head>
<body onload="fetchOrders()">
	<div class="sidebar">
		<h5 class="text-center text-white">Welcome</h5>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link active"
				href="LandingPage.jsp">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="CancelOrder.jsp">Cancel
					order</a></li>
			<li class="nav-item"><a class="nav-link"
				href="ViewOrderPage.jsp">Order History</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Partial
					cancel</a></li>

		</ul>
	</div>

	<div class="content">
		<div class="container mt-5">
			<table class="table table-bordered" id="products_container">

			</table>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		/**
		fetch order items which has more than one item in single order id
		 */
		function fetchOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "order_controller?action=getMoreThanOneItem", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("products_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}
		/**
		cancel order item
		 */
		function cancelItem(button) {
			const xhr = new XMLHttpRequest();
			const orderItemId = button.getAttribute('data-orderitem-id');
			xhr.open("GET",
					"order_controller?action=remove_order_item&orderItemId="
							+ orderItemId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("products_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
			location.reload();
		}
	</script>
</body>
</html>