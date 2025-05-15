package com.praveen.rest.praveen_jersey_shop;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.util.DbConnection;
import com.praveen.model.User;

@Path("/users")
public class UserController {
	private static String hashPassword(String password) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hashBytes = digest.digest(password.getBytes());

			StringBuilder hexString = new StringBuilder();
			for (byte b : hashBytes) {
				String hex = Integer.toHexString(0xff & b);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}

			return hexString.toString();
		} catch (NoSuchAlgorithmException exception) {
			throw new RuntimeException("Error hashing password");
		}
	}

	@POST
	@Path("/valid")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response isValidUser(User user) {

		String email = user.getEmail();
		String password = hashPassword(user.getPassword());
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"userId\", \"userName\", password, email, \"phoneNumber\", \"userRole\", address_line, city, state, pincode, country, hint, \"DOB\" FROM public.\"user\" WHERE email=\'"
					+ email + "\' and password=\'" + password + "\'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet.next()) {
					return Response.status(Response.Status.OK).entity("user found").build();
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_FOUND).entity("not found").build();
	}

	@POST
	@Path("/adduser")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addNewUser(User user) {
		System.out.println(user.toString());
		if (user.getUserName() == null || user.getUserName().isEmpty() || user.getCity() == null
				|| user.getCity().isEmpty() || user.getPassword() == null || user.getPassword().isEmpty()
				|| user.getEmail() == null || user.getEmail().isEmpty() || user.getPhoneNumber() == null
				|| user.getPhoneNumber().isEmpty() || user.getAddressLine() == null || user.getAddressLine().isEmpty()
				|| user.getState() == null || user.getState().isEmpty() || user.getCountry() == null
				|| user.getCountry().isEmpty() || user.getPincode() == null || user.getPincode().isEmpty()
				|| user.getHint() == null || user.getHint().isEmpty() || user.getDob() == null
				|| user.getDob().isEmpty()) {
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("empty param is not accepted").build();
		} else if (!validateUserData(user)) {
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("param format is not accepted").build();
		}
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"user\"(\"userName\", password, email, \"phoneNumber\", \"userRole\", address_line, city, state, pincode, country, hint, \"DOB\")VALUES ( ?, ?, ?, ?, (CAST(? AS user_role)), ?, ?, ?, ?, ?, ?, (CAST(? AS DATE)))";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, user.getUserName());
				pstmt.setObject(2, hashPassword(user.getPassword()));
				pstmt.setObject(3, user.getEmail());
				pstmt.setObject(4, user.getPhoneNumber());
				pstmt.setObject(5, "customer");
				pstmt.setObject(6, user.getAddressLine());
				pstmt.setObject(7, user.getCity());
				pstmt.setObject(8, user.getState());
				pstmt.setObject(9, user.getPincode());
				pstmt.setObject(10, user.getCountry());
				pstmt.setObject(11, user.getHint());
				pstmt.setObject(12, "'" + user.getDob().toString() + "'");
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("user created").build();

			}
		} catch (SQLException exception) {
			if (exception.getMessage().contains("unique"))
				return Response.status(Response.Status.OK).entity("user already exists with the given details").build();
			else
				System.out.println("issue in adding a user");
		}
		return Response.status(Response.Status.NOT_FOUND).entity("not found").build();
	}

	public boolean validateUserData(User user) {
		// Email regex
		String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
		// Mobile number regex
		String mobileRegex = "^\\d{10}$";
		// Pincode regex
		String pincodeRegex = "^\\d{1,6}$";
		// Password regex
		String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$";
		// State/City/Country regex (alpha only)
		String alphaRegex = "^[a-zA-Z]+(\\s[a-zA-Z]+)*$";

		String dobRegex = "^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\\d{4}$";
		if (user.getDob().matches(dobRegex)) {
			// Now check if age is between 18 and 150
			if (!isValidAge(user.getDob()))
				return false;
		} else {
			return false;
		}

		// Validate Email
		System.out.println("emai");
		if (!user.getEmail().matches(emailRegex))
			return false;
		System.out.println("mob");
		// Validate Mobile
		if (!user.getPhoneNumber().matches(mobileRegex))
			return false;
		System.out.println("pin");
		// Validate Pincode
		if (!user.getPincode().matches(pincodeRegex))
			return false;
		System.out.println("pas");
		// Validate Password
		if (!user.getPassword().matches(passwordRegex))
			return false;
		System.out.println("state");
		// Validate State
		if (!user.getState().matches(alphaRegex))
			return false;
		System.out.println("city");
		// Validate City
		if (!user.getCity().matches(alphaRegex))
			return false;
		System.out.println("country");
		// Validate Country
		if (!user.getCountry().matches(alphaRegex))
			return false;
		System.out.println("df");
		return true;
	}

	public static boolean isValidAge(String dobString) {
		try {
			// Parse the date of birth string to LocalDate
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			LocalDate dob = LocalDate.parse(dobString, formatter);

			// Get the current date
			LocalDate currentDate = LocalDate.now();

			// Calculate the age
			int age = Period.between(dob, currentDate).getYears();

			// Check if age is between 18 and 150
			return age >= 18 && age <= 150;
		} catch (DateTimeParseException e) {
			System.out.println("Invalid Date of Birth format: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Method processing HTTP GET requests, producing "text/plain" MIME media
	 * type.
	 * 
	 * @return String that will be send back as a response of type "text/plain".
	 */
	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> getUsers() {
		List<User> customers = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"userId\", \"userName\", email, \"phoneNumber\", \"userRole\", address_line, city, state, pincode, country, hint, \"DOB\" FROM public.\"user\" where \"userRole\"='customer'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						User user = updateUserData(resultSet);
						if (user != null)
							customers.add(user);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while make customer as admin");
		}
		return customers;
	}

	@PUT
	@Path("/makeadmin")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response updateUserRole(User user) {
		System.out.println(user.getUserId());
		System.out.println(user.getUserRole());
		if (user.getUserRole() == null || !user.getUserRole().equals("admin")) {
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("wrong user role").build();
		}

		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"user\" SET \"userRole\"=(CAST(? AS user_role)) WHERE \"userId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, user.getUserRole());
				pstmt.setObject(2, user.getUserId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in updating user role");
		}
		return Response.status(Response.Status.BAD_REQUEST).entity("issue to update").build();
	}

	@GET
	@Path("/getuserbyid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public User getUserById(@QueryParam("userid") int userId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"userId\", \"userName\", password, email, \"phoneNumber\", \"userRole\", address_line, city, state, pincode, country, hint, \"DOB\" FROM public.\"user\" where \"userId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, userId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						return updateUserData(resultSet);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while make customer as admin");
		}
		return null;
	}

	@GET
	@Path("/getuserbyemail")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public User getUserByEmail(@QueryParam("email") String email) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"userId\", \"userName\", password, email, \"phoneNumber\", \"userRole\", address_line, city, state, pincode, country, hint, \"DOB\" FROM public.\"user\" where email=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, email);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					return updateUserData(resultSet);
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while make customer as admin");
		}
		return null;
	}

	@GET
	@Path("/customerwithoutorder")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> userWithoutOrder() {
		List<User> customers = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "select u.\"userId\", u.\"userName\", u.email, u.\"userRole\", u.\"userId\", u.\"userName\", u.email, u.\"phoneNumber\", u.\"userRole\", u.address_line, u.city, u.state, u.pincode, u.country, u.hint, u.\"DOB\" FROM Public.\"user\" u LEFT JOIN public.\"Order\" o ON u.\"userId\"=o.\"userId\" WHERE o.\"userId\" IS NULL AND u.\"userRole\"='customer' ";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						User user = updateUserData(resultSet);
						if (user != null)
							customers.add(user);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while make customer as admin");
		}
		return customers;
	}

	public User updateUserData(ResultSet resultSet) {
		try {
			User user = new User();
			user.setUserId(resultSet.getInt("userId"));
			user.setUserName(resultSet.getString("userName"));
			user.setEmail(resultSet.getString("email"));
			user.setPhoneNumber(resultSet.getString("phoneNumber"));
			user.setUserRole(resultSet.getString("userRole"));
			user.setAddressLine(resultSet.getString("address_line"));
			user.setCity(resultSet.getString("city"));
			user.setState(resultSet.getString("state"));
			user.setPincode(resultSet.getString("pincode"));
			user.setCountry(resultSet.getString("country"));
			user.setHint(resultSet.getString("hint"));
			user.setDob(resultSet.getString("DOB"));
			return user;
		} catch (IllegalAccessException e) {
			System.out.println("illegal access");
		} catch (SQLException e) {
			System.out.println("issue while make customer as admin");
		}
		return null;
	}
}
