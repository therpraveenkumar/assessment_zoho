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

.sidebar a:focus {
	color: white;
	background-color: #0000FF;
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
	align-items: center;
	height: 5vh;
}

.cart-btn {
	height: 80%;
}

.logout-div {
	width: 25vw;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.cart-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}
</style>
</head>
<body onload="fetchOrders()">
	<div class="sidebar">
		<h5 class="text-center text-white">Welcome, admin</h5>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchOrders(event)">Orders</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchPendingOrders(event)">Pending Order</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchCanceledOrders(event)">Cancelled Order</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchCompletedOrders(event)">Delivered Order</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchCustomers(event)">customers</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchCancelReason(event)"> Cancel reason</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchProducts(event)">products </a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchProductCategory(event)"> Products category</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchCustomerWithoutOrder(event)">customers without
					order</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="fetchPayments(event)">payments</a></li>
		</ul>
	</div>

	<div class="content">
		<div class="top-nav">
			<div class="container mt-5">
				<button class="btn btn-primary" data-toggle="modal"
					data-target="#makeAdminModal">Make Admin</button>
				<button class="btn btn-primary" data-toggle="modal"
					data-target="#deliveredModal">Delivered</button>
				<button class="btn btn-primary" data-toggle="modal"
					data-target="#addProductModal">Add Product</button>
				<button class="btn btn-primary" data-toggle="modal"
					data-target="#addCategoryModal">Add Category</button>

			</div>
			<div class="logout-div">
				<button class="btn btn-secondary" data-bs-toggle="modal"
					data-bs-target="#changePasswordModal">Change password</button>
				<form method="post" action="logout">
					<input type="hidden" name="action" value="logout">
					<button type="submit" class="btn btn-danger">Logout</button>
				</form>
			</div>


		</div>

		<div class="container mt-5">
			<table class="table table-bordered" id="write_container">
			</table>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="makeAdminModal" tabindex="-1"
		aria-labelledby="makeAdminModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="makeAdminModalLabel">Make Admin</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Enter the user ID to make them an admin:</p>
					<input type="number" class="form-control" id="userIdInput"
						placeholder="User ID" required>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="makeAdmin()">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal increase stock -->
	<div class="modal fade" id="increaseStockModal" tabindex="-1"
		aria-labelledby="increaseStockModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="increaseStockModalLabel">Increase
						Stock</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="increaseStockForm" onsubmit="return validateStock(event)">
						<div class="mb-3">
							<label for="stockQuantity" class="form-label">Stock
								Quantity</label> <input type="number" class="form-control"
								id="stockQuantity" min="1" required>
							<div class="invalid-feedback">Please enter a quantity
								greater than 0.</div>
						</div>
						<button type="submit" class="btn btn-success">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Confirm Delivery Modal -->
	<div class="modal fade" id="deliveredModal" tabindex="-1"
		aria-labelledby="deliveredModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deliveredModalLabel">Confirm
						Delivery</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Enter the order ID to confirm delivery:</p>
					<input type="number" class="form-control" id="orderIdInput"
						placeholder="Order ID" required>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-success" data-dismiss="modal"
						onclick="confirmDelivery()">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Change Password Modal -->
	<div class="modal fade" id="changePasswordModal" tabindex="-1"
		aria-labelledby="changePasswordModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="changePasswordModalLabel">Change
						Password</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="changePasswordForm"
						onsubmit="handleChangePassword(event)">
						<div class="mb-3">
							<label for="newPassword" class="form-label">Old Password</label>
							<input type="password" class="form-control" id="oldPassword"
								required>
						</div>
						<div class="mb-3">
							<label for="newPassword" class="form-label">New Password</label>
							<input type="password" class="form-control" id="newPassword"
								required>
						</div>
						<button type="submit" class="btn btn-primary"
							data-bs-dismiss="modal">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Add Product Modal -->
	<div class="modal fade" id="addProductModal" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Enter product details:</p>
					<div class="form-group">
						<label for="productName">Product Name</label> <input type="text"
							class="form-control" id="productName" placeholder="Product Name"
							required>
					</div>
					<div class="form-group">
						<label for="productDescription">Product Description</label>
						<textarea class="form-control" id="productDescription"
							placeholder="Product Description" required></textarea>
					</div>
					<div class="form-group">
						<label for="productPrice">Price</label> <input type="number"
							step="0.01" class="form-control" id="productPrice"
							placeholder="Price" required>
					</div>
					<div class="form-group">
						<label for="productQuantity">Quantity</label> <input type="number"
							class="form-control" id="productQuantity" placeholder="Quantity"
							required>
					</div>
					<div class="form-group">
						<label for="categoryId">Category ID</label> <input type="number"
							class="form-control" id="categoryId" placeholder="Category ID"
							required>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-info" onclick="addProduct()">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Add Category Modal -->
	<div class="modal fade" id="addCategoryModal" tabindex="-1"
		aria-labelledby="addCategoryModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addCategoryModalLabel">Add
						Category</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Enter category name:</p>
					<input type="text" class="form-control" id="categoryName"
						placeholder="Category Name" required>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-warning"
						onclick="addCategory()">Submit</button>
				</div>
			</div>
		</div>
	</div>
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
		function makeAdmin() {
			const userId = document.getElementById("userIdInput").value;
			if (!userId) {
				alert("Please enter a valid User ID.");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST", "validator?action=changeRoleToAdmin&userId="
					+ userId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();
			$('#makeAdminModal').modal('hide');

			document.getElementById("userIdInput").value = '';
		}

		function openStock(button) {
			currentButton = button;
		}

		function validateStock(event) {
			event.preventDefault();

			const stockQuantity = document.getElementById('stockQuantity').value;
			const productId = currentButton.getAttribute('data-product-id');
			console.log(productId);
			if (stockQuantity <= 0) {
				alert("stock quantity can't be less than 1");
				return false;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("GET", "products?action=update_stock&productId="
					+ productId + "&quantity=" + stockQuantity, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

			const modal = bootstrap.Modal.getInstance(document
					.getElementById('increaseStockModal'));
			modal.hide();

			return true;
		}

		function confirmDelivery() {
			const orderId = document.getElementById("orderIdInput").value;

			if (!orderId) {
				alert("Please enter a valid Order ID.");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST",
					"order_tables_praveen?action=make_delivered&orderId="
							+ orderId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

			$('#deliveredModal').modal('hide');

			document.getElementById("orderIdInput").value = '';
		}

		function addProduct() {
			const productName = document.getElementById("productName").value
					.trim();
			const productDescription = document
					.getElementById("productDescription").value.trim();
			const productPrice = document.getElementById("productPrice").value;
			const productQuantity = document.getElementById("productQuantity").value;
			const categoryId = document.getElementById("categoryId").value;

			if (!productName || !productDescription || !productPrice
					|| !productQuantity || !categoryId) {
				alert("Please fill in all fields.");
				return;
			} else if (productQuantity < 0) {
				alert("quantity can't be less than 0");
				return;
			} else if (productPrice < 0) {
				alert("price can't be less than 0");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST", "products?action=add_product&productName="
					+ productName + "&productDescription=" + productDescription
					+ "&productPrice=" + productPrice + "&productQuantity="
					+ productQuantity + "&categoryId=" + categoryId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert("Successfully added");
				}
			};
			xhr.send();

			$('#addProductModal').modal('hide');
			document.getElementById("productName").value = '';
			document.getElementById("productDescription").value = '';
			document.getElementById("productPrice").value = '';
			document.getElementById("productQuantity").value = '';
			document.getElementById("categoryId").value = '';
		}

		function addCategory() {
			const categoryName = document.getElementById("categoryName").value
					.trim();

			if (!categoryName) {
				alert("Please enter a valid category name.");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST",
					"product_category_controller?action=add_category&categoryName="
							+ categoryName, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert("Successfully added");
				}
			};
			xhr.send();

			$('#addCategoryModal').modal('hide');
			document.getElementById("categoryName").value = '';
		}

		function handleChangePassword(event) {
			event.preventDefault();

			const newPassword = document.getElementById('newPassword').value
					.trim();
			const oldPassword = document.getElementById('oldPassword').value
					.trim();

			if (!newPassword || !oldPassword) {
				alert("Please fill all fields");
				return;
			}
			const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
			if (!passwordRegex.test(newPassword)
					|| !passwordRegex.test(oldPassword)) {
				alert("Password must be at least 8 characters long, with at least one lowercase and one uppercase letter.");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST", "validator?action=change_password&newPassword="
					+ newPassword + "&oldPassword=" + oldPassword, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

			document.getElementById("newPassword").value = '';
			document.getElementById("oldPassword").value = '';
		}

		function removeProduct(button) {//TODO
			console.log("remove product dread "+button.dataset.productId);
			const row = button.closest('tr');
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "products?action=remove_product&product_id="
					+ button.dataset.productId, true);

			xhr.send();
			const productId = row.dataset.productId;

			row.remove();
		}

		function fetchOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "order_tables_praveen?action=get_all_orders", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchPendingOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr
					.open(
							"GET",
							"order_tables_praveen?action=get_orders_by_status&status=pending",
							true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchCanceledOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr
					.open(
							"GET",
							"order_tables_praveen?action=get_orders_by_status&status=canceled",
							true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchCompletedOrders(event) {
			const xhr = new XMLHttpRequest();
			xhr
					.open(
							"GET",
							"order_tables_praveen?action=get_orders_by_status&status=completed",
							true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchCustomers(event) {
			console.log("dfcus");
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "validator?action=get_customers", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchCancelReason(event) {
			console.log("dread");
			const xhr = new XMLHttpRequest();
			xhr
					.open("GET", "cancel_controller?action=get_cancel_records",
							true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchProducts(event) {
			console.log("dread");
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "products?action=get_product_records", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchProductCategory(event) {
			console.log("dread");
			const xhr = new XMLHttpRequest();
			xhr.open("GET",
					"product_category_controller?action=get_product_category",
					true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchCustomerWithoutOrder(event) {
			console.log("dread");
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "validator?action=get_customers_without_order",
					true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		function fetchPayments(event) {
			console.log("dread");
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "payments?action=get_payments", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("write_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}
	</script>
</body>
</html>