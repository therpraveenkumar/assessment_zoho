<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Signup Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
}

.signup-container {
	max-width: 600px;
	margin: auto;
	padding: 30px;
	background: white;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<div class="signup-container mt-5">
		<h2 class="text-center">Sign Up</h2>
		<form onsubmit="validateInputs(event)">
			<div class="mb-3">
				<label for="username" class="form-label">User Name</label> <input
					type="text" class="form-control" id="username" required>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Password (min 8
					characters, at least one lowercase and one uppercase)</label> <input
					type="password" class="form-control" id="password" required>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" required>
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">Phone Number</label> <input
					type="tel" class="form-control" id="phone" required>
			</div>
			<div class="mb-3">
				<label for="address" class="form-label">Address</label>
				<textarea class="form-control" id="address" rows="3" required></textarea>
			</div>
			<div class="mb-3">
				<label for="city" class="form-label">City</label> <input type="text"
					class="form-control" id="city" required>
			</div>
			<div class="mb-3">
				<label for="state" class="form-label">State</label> <input
					type="text" class="form-control" id="state" required>
			</div>
			<div class="mb-3">
				<label for="pincode" class="form-label">Pin Code</label> <input
					type="number" class="form-control" id="pincode" required>
			</div>
			<div class="mb-3">
				<label for="country" class="form-label">Country</label> <input
					type="text" class="form-control" id="country" required>
			</div>
			<div class="mb-3">
				<label for="hint" class="form-label">Hint (to remember
					password) <input type="text" class="form-control" id="hint_"
					required>
			</div>
			<div class="mb-3">
				<label for="dob" class="form-label">Date of Birth</label> <input
					type="date" class="form-control" id="dob" required>
			</div>
			<button type="submit" class="btn btn-primary w-100">Sign Up</button>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	/**
	form the date
	 */
	function formatDateToDDMMYYYY(date) {
	    const day = String(date.getDate()).padStart(2, '0');
	    const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
	    const year = date.getFullYear();
	    return day+"-"+month+"-"+year;
	}
	/**
	validate signup form and create user
	 */
	function validateInputs(event) {
	    event.preventDefault();
	
	    const username = document.getElementById('username').value.trim();
	    const password = document.getElementById('password').value.trim();
	    const email = document.getElementById('email').value.trim();
	    const phone = document.getElementById('phone').value.trim();
	    const city = document.getElementById('city').value.trim();
	    const state = document.getElementById('state').value.trim();
	    const country = document.getElementById('country').value.trim();
	    const address = document.getElementById('address').value.trim();
	    const pincode = document.getElementById('pincode').value.trim();
	    const dob = new Date(document.getElementById('dob').value);
	    const hint = document.getElementById('hint_').value.trim();
		
	    const usernameRegex = /^[A-Za-z][A-Za-z0-9]*$/;
	    if (!usernameRegex.test(username)) {
	        alert("Username must start with a letter and contain only letters and numbers.");
	        return;
	    }
	
	    const phoneRegex = /^\d{10}$/;
	    if (!phoneRegex.test(phone)) {
	        alert("Phone number must be exactly 10 digits.");
	        return;
	    }
	
	    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
	    if (!passwordRegex.test(password)) {
	        alert("Password must be at least 8 characters long, with at least one lowercase and one uppercase letter.");
	        return;
	    }
	
	    const alphaRegex = /^[A-Za-z\s]+$/;
	    if (!alphaRegex.test(city) || !alphaRegex.test(state) || !alphaRegex.test(country)) {
	        alert("City, State, and Country must contain only letters.");
	        return;
	    }
	
	    if (address.length === 0) {
	        alert("Address cannot be empty.");
	        return;
	    }
	
	    if (isNaN(pincode) || pincode <= 0) {
	        alert("Pin Code must be a positive number.");
	        return;
	    }
	
	    const today = new Date();
	    let age = today.getFullYear() - dob.getFullYear();
	    const monthDiff = today.getMonth() - dob.getMonth();
	    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
	        age--;
	    }
	    
	
	    if (age < 18 || age > 150) {
	        alert("You must be at least 18 years old and less than 150 years old.");
	        return;
	    }
	    
	    const xhr = new XMLHttpRequest();
	    const formattedDob = formatDateToDDMMYYYY(dob);
	
	    const params = new URLSearchParams({
	        action: 'add_user',
	        userName: username,
	        password: password,
	        phone: phone,
	        city: city,
	        state: state,
	        country: country,
	        address: address,
	        pincode: pincode,
	        dob: formattedDob,
	        hint: hint,
	        email: email
	    });
	    
	    xhr.open("POST", "validator?" + params.toString(), true);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				alert(xhr.responseText);
			}
		};
		xhr.send();
	}
</script>
</body>
</html>