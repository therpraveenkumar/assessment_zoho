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
	max-height: 100vh;
	overflow: auto;
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
	width: 10vw;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>
</head>
<body onload="fetchOrders(event)">
	<div class="sidebar">
		<h5 class="text-center text-white">Welcome</h5>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link active"
				href="LandingPage.jsp">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="CancelOrder.jsp">Cancel
					order</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Order
					History</a></li>
			<li class="nav-item"><a class="nav-link"
				href="PartialCancel.jsp">Partial cancel</a></li>
		</ul>
	</div>

	<div class="content">
		<div class="container mt-5">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">Order ID</th>
						<th scope="col">STATUS</th>
						<th scope="col">Price</th>
					</tr>
				</thead>
				<tbody id="orders_container">
				</tbody>
			</table>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		/**
		fetch orders
		 */
		function fetchOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "order_tables_praveen?action=view_orders", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						document.getElementById("orders_container").innerHTML = xhr.responseText;
					} else {
						console.error("Error fetching orders:", xhr.status,
								xhr.statusText);
					}
				}
			};
			xhr.send();
		}
	</script>
</body>
</html>