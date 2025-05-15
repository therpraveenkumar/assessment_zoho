<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
	HttpSession sessions = request.getSession(false);
	System.out.println("dfdfd");
	if (sessions == null || sessions.getAttribute("user") == null) {
		response.sendRedirect("LoginPage.jsp");
		return;
	}
%>
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
	width: 28vw;
	display: flex;
	justify-content: space-between;
	align-items: center;
	position: relative;
}

.profile-icon {
	font-size: 2rem;
	cursor: pointer;
	color: #007bff;
	top: 24%;
	position: absolute;
}

.edit-icon {
	cursor: pointer;
	color: #28a745;
}

.modal-body input {
	margin-bottom: 10px;
}
</style>
</head>
<body onload="create_cart();fetchAllProducts();">
	<div class="sidebar">
		<h5 class="text-center text-white">Welcome</h5>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link active" href="#">Home</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="CancelOrder.jsp">Cancel
					order</a></li>
			<li class="nav-item"><a class="nav-link"
				href="ViewOrderPage.jsp">Order History</a></li>
			<li class="nav-item"><a class="nav-link"
				href="PartialCancel.jsp">Partial cancel</a></li>

		</ul>
	</div>

	<div class="content">
		<div class="top-nav">
			<form onsubmit="fetchProducts(event)" id="productForm">
				<div class="input-group mb-3">
					<input type="hidden" name="action" value="search"> <input
						type="text" class="form-control search-input" name="query"
						placeholder="Search... laptop, shoe, chair" aria-label="Search"
						aria-describedby="button-search" required>
					<button class="btn btn-primary" type="submit" id="button-search">Search</button>
				</div>
			</form>

			<div class="logout-div">
				<form method="post" action="logout">
					<input type="hidden" name="action" value="logout">
					<button type="submit" class="btn btn-danger">Logout</button>
				</form>
				<button class="btn btn-secondary" data-bs-toggle="modal"
					data-bs-target="#changePasswordModal">Change password</button>
				<div class="mt-5" onclick="updateProfileDate()">
					<i class="bi bi-person-circle profile-icon" data-bs-toggle="modal"
						data-bs-target="#profileModal" ></i>
				</div>
				<!-- Button to trigger the cart modal -->
				<form onsubmit="fetchCartItems(event)" id="cart_form">
					<input type="hidden" name="action" value="view_cart_item">
					<button class="btn btn-primary cart-btn" data-bs-toggle="modal"
						data-bs-target="#cartModal">
						<i class="bi bi-cart"></i> Cart
					</button>
				</form>



				<!-- Cart Modal -->
				<div class="modal fade" id="cartModal" tabindex="-1"
					aria-labelledby="cartModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="cartModalLabel">Your Cart</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<ul class="list-group" id="cart_item_container">
									<!-- Cart items will be dynamically inserted here -->
								</ul>
							</div>
							<div class="modal-footer">
								<div class="form-check">
									<input class="form-check-input" type="radio"
										name="paymentMethod_checkout" id="upi" value="UPI" checked>
									<label class="form-check-label" for="upi">UPI</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio"
										name="paymentMethod_checkout" id="cod" value="COD"> <label
										class="form-check-label" for="cod">Cash on Delivery</label>
								</div>
								<form id="clear_cart_form" onsubmit="clearCart(event)">
									<input type="hidden" name="action" value="clear_cart_items">
									<button class="btn btn-secondary" type="submit">Clear</button>
								</form>
								<button type="button" class="btn btn-primary"
									data-bs-dismiss="modal" onclick="checkout(event)">Checkout</button>
							</div>
						</div>
					</div>
				</div>

				<div class="modal fade" id="profileModal" tabindex="-1"
					aria-labelledby="profileModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="profileModalLabel">Edit Profile</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<!-- Name Field -->
								<div class="mb-3">
									<label for="name" class="form-label">Name</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="name"
											value="John Doe" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('name')"></i>
									</div>
								</div>

								

								<!-- Address Field -->
								<div class="mb-3">
									<label for="state" class="form-label">Address</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="address"
											value="sample value" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('address')"></i>
									</div>
								</div>

								<!-- State Field -->
								<div class="mb-3">
									<label for="state" class="form-label">State</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="state"
											value="California" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('state')"></i>
									</div>
								</div>

								<!-- City Field -->
								<div class="mb-3">
									<label for="city" class="form-label">City</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="city"
											value="Los Angeles" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('city')"></i>
									</div>
								</div>

								<!-- Country Field -->
								<div class="mb-3">
									<label for="country" class="form-label">Country</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="country"
											value="USA" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('country')"></i>
									</div>
								</div>

								<!-- Hint Field -->
								<div class="mb-3">
									<label for="hint" class="form-label">Hint</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="hint"
											value="My first pet's name" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('hint')"></i>
									</div>
								</div>

								<!-- Pincode Field -->
								<div class="mb-3">
									<label for="pincode" class="form-label">Pincode</label>
									<div class="d-flex justify-content-between">
										<input type="text" class="form-control" id="pincode"
											value="90001" disabled> <i
											class="bi bi-pencil-square edit-icon"
											onclick="editField('pincode')"></i>
									</div>
								</div>

								<!-- Update Button -->
								<button class="btn btn-primary" onclick="updateProfile()">Update</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div class="container mt-5">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">Product name</th>
						<th scope="col">Description</th>
						<th scope="col">Price</th>
						<th scope="col">Actions (Add)</th>
						<th scope="col">Actions (Buy)</th>
					</tr>
				</thead>
				<tbody id="products_container">
				</tbody>
			</table>
		</div>

		<!-- Payment Modal -->
		<div class="modal fade" id="paymentModal" tabindex="-1"
			aria-labelledby="paymentModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="paymentModalLabel">Select Payment
							Method</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="paymentForm">
							<div class="form-check">
								<input class="form-check-input" type="radio"
									name="paymentMethod" id="upi" value="UPI" checked> <label
									class="form-check-label" for="upi">UPI</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio"
									name="paymentMethod" id="cod" value="COD"> <label
									class="form-check-label" for="cod">Cash on Delivery</label>
							</div>
						</form>
						<p id="selectedProduct"></p>
						<!-- To display selected product -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary"
							onclick="submitPayment()" data-bs-dismiss="modal">Submit</button>
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

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	
		function editField(field) {
			document.getElementById(field).disabled = false;
		}
		
		
		
		function updateProfileDate(){
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "validator?action=get_user_session", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					const data = xhr.responseText;
					console.log(data);
					
					if(!data)
						return;
					const userData = data.split(',:');
					// Update modal fields with the split data
			        document.getElementById('name').value = userData[0];
			        document.getElementById('state').value = userData[1];
			        document.getElementById('city').value = userData[2];
			        document.getElementById('country').value = userData[3];
			        document.getElementById('hint').value = userData[4];
			        document.getElementById('pincode').value = userData[5];
			        document.getElementById('address').value = userData[6];
				}
			};
			xhr.send();
			
		}

		// Function to handle the update (you can connect this to your DB logic here)
		function updateProfile() {
			const name = document.getElementById('name').value;
			const state = document.getElementById('state').value;
			const city = document.getElementById('city').value;
			const country = document.getElementById('country').value;
			const hint = document.getElementById('hint').value;
			const pincode = document.getElementById('pincode').value;
			const address = document.getElementById('address').value.trim();
			

			const usernameRegex = /^[A-Za-z][A-Za-z0-9]*$/;
			if (!usernameRegex.test(name)) {
				alert("name must start with a letter and contain only letters and numbers.");
				return;
			}

			const alphaRegex = /^[A-Za-z\s]+$/;
			if (!alphaRegex.test(city) || !alphaRegex.test(state)
					|| !alphaRegex.test(country)) {
				alert("City, State, and Country must contain only letters.");
				return;
			}


			if (address.length === 0) {
				alert("Address cannot be empty.");
				return;
			}

			if (hint.length === 0) {
				alert("hint cannot be empty.");
				return;
			}

			if (isNaN(pincode) || pincode <= 0) {
				alert("Pin Code must be a positive number.");
				return;
			}

			const params = new URLSearchParams({
				action : 'update_profile',
				userName : name,
				city : city,
				state : state,
				country : country,
				pincode : pincode,
				hint : hint,
				address : address,
				email : "e",
				phone : "1"
			});

			const xhr = new XMLHttpRequest();
			xhr.open("POST", "validator?" + params.toString(), true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

		}
		/**
		method to handle change password
		 */
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
		/**
		fetch all products 
		 */
		function fetchAllProducts() {

			const xhr = new XMLHttpRequest();
			xhr.open("GET", "products?action=search&query= ", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("products_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		/**
		fetch products based on user search
		 */
		function fetchProducts(event) {
			event.preventDefault();

			const formData = new FormData(document
					.getElementById("productForm"));
			const params = new URLSearchParams(formData).toString();
			console.log(params);
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "products?" + params, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("products_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		/**
		method to buy cart items
		 */
		function checkout(event) {
			const xhr = new XMLHttpRequest();
			const selectedPayment = document
					.querySelector('input[name="paymentMethod_checkout"]:checked').value;
			xhr.open("POST",
					"order_tables_praveen?action=add_order_from_cart&paymentMethod="
							+ selectedPayment, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();
		}

		/**
		method to show cart items
		 */
		function fetchCartItems(event) {
			event.preventDefault();
			const formData = new FormData(document.getElementById("cart_form"));
			const params = new URLSearchParams(formData).toString();
			const xhr = new XMLHttpRequest();

			xhr.open("GET", "cart_item?" + params, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("cart_item_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		/**
		method to create cart
		 */
		function create_cart(event) {
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "create_cart", true);
			xhr.onreadystatechange = function() {
			};
			xhr.send();
			console.log("create cart");
		}

		/**
		method to add products in cart
		 */
		function addToCart(event) {
			event.preventDefault();
			const form = event.target;
			const productId = form.querySelector('input[name="productId"]').value;

			const formData = new FormData(form);
			const params = new URLSearchParams(formData).toString();
			console.log(params);
			const xhr = new XMLHttpRequest();
			console.log(params);
			xhr.open("GET", "cart_item?" + params, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("cart_item_container").innerHTML = xhr.responseText;
					const button = form.querySelector('button'); // Get the button within the form

					// Change the button to a tick icon
					button.innerHTML = '<i class="bi bi-check-circle"></i>'; // Change to tick icon
					button.classList.remove('btn-success'); // Remove the success class
					button.classList.add('btn-info'); // Change to a non-clickable style
					button.disabled = true;
				}
			};
			xhr.send();
			console.log("add to cart");
		}

		/**
		method to clear cart
		 */
		function clearCart(event) {
			event.preventDefault();
			const formData = new FormData(document
					.getElementById("clear_cart_form"));
			const params = new URLSearchParams(formData).toString();
			const xhr = new XMLHttpRequest();

			xhr.open("GET", "cart_item?" + params, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					document.getElementById("cart_item_container").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}

		/**
		method to remove cart items
		 */
		function deleteItem(button) {
			const listItem = button.closest('li');
			const itemId = listItem.getAttribute('data-id'); // Get the item ID

			// Send GET request to the server
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "cart_item?id=" + itemId
					+ "&action=delete_cart_item", true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					listItem.remove();
				} else if (xhr.readyState === 4) {
					console.error('Failed to delete item:', xhr.status,
							xhr.statusText);
				}
			};

			xhr.send(); // Send the request
		}

		/**
		method to open payment modal
		 */
		function openPaymentModal(button) {
			const productId = button.getAttribute('data-product-id');

			const modal = document.getElementById('paymentModal');
			modal.setAttribute('data-product-id', productId);
			currentBuyButton = button;
			$('#paymentModal').modal('show');
		}

		/**
		method to create order in the order table
		 */
		function submitPayment() {
			const selectedPayment = document
					.querySelector('input[name="paymentMethod"]:checked').value;

			const modal = document.getElementById('paymentModal');
			const productId = modal.getAttribute('data-product-id');

			const params = new URLSearchParams({
				action : "add_order",
				paymentMethod : selectedPayment,
				productId : productId
			});
			const xhr = new XMLHttpRequest();
			console.log(params.toString());
			xhr.open("POST", "order_tables_praveen?" + params.toString(), true);

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

			currentBuyButton.innerHTML = '<i class="bi bi-check-circle"></i>';
			currentBuyButton.classList.remove('btn-warning');
			currentBuyButton.classList.add('btn-info');
			currentBuyButton.disabled = true;

			$('#paymentModal').modal('hide');
		}
	</script>
</body>
</html>