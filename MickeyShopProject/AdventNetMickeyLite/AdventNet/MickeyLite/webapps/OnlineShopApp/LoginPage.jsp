<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="container d-flex align-items-center justify-content-center"
		style="min-height: 40vh; margin-top: 20vh; margin-left: 35%">
		<div class="centre-div align-items-center justify-content-center">
			<div class="card" style="width: 400px;">
				<h3 class="text-center">ONLINE SHOPPING</h3>
				<div class="card-body">
					<h5 class="card-title text-center">Login</h5>
					<form method="post" action="validator">
						<input type="hidden" name="action" value="login">
						<div class="mb-3">
							<label for="email" class="form-label">Email address</label> <input
								type="email" class="form-control" id="email" name="email"
								required>
						</div>
						<br>
						<div class="mb-3">
							<label for="password" class="form-label">Password</label> <input
								type="password" class="form-control" id="password"
								name="password" required>
						</div>
						<br>
						<button type="submit" class="btn btn-primary w-100">Login</button>
					</form>
					<div class="text-center mt-3">
						<a href="#" data-toggle="modal" data-target="#emailModal">Forgot
							your password?</a>

						<!-- forgot password Modal -->
						<div class="modal fade" id="emailModal" tabindex="-1"
							aria-labelledby="addCategoryModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="addCategoryModalLabel">Forgot
											password</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span>&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<p>Enter email:</p>
										<input type="email" class="form-control" id="email_"
											placeholder="enter email" required>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
										<button type="button" class="btn btn-warning"
											onclick="handleEmailSubmit(event)">Submit</button>
									</div>
								</div>
							</div>
						</div>

					</div>
					<div class="text-center mt-2">
						<a href="signup">Create an account</a>
					</div>
				</div>
			</div>
		</div>


	</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script>
		/**
		method to handle forgot password
		 */
		function handleEmailSubmit(event) {
			event.preventDefault();
			const email = document.getElementById('email_').value;

			if (!email) {
				alert("Please fill the email field");
				return;
			} else if (!validateEmail(email)) {
				alert("invalid email format.");
				return;
			}

			const xhr = new XMLHttpRequest();
			xhr.open("POST", "validator?action=forgot_password&email=" + email,
					true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					alert(xhr.responseText);
				}
			};
			xhr.send();

			document.getElementById('email_').value = '';
		}

		/**
		validate email format
		 */
		function validateEmail(email) {
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			return emailRegex.test(email);
		}
	</script>
</body>
</html>