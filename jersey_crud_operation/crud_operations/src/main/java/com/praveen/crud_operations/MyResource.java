
package com.praveen.crud_operations;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Example resource class hosted at the URI path "/myresource"
 */
@Path("/users")
public class MyResource {
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
		}
		else if(!validateUserData(user)){
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

	// PRODUCTS TABLE

	@POST
	@Path("/addproduct")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addNewProduct(Product product) {
		System.out.println(product.toString());
		if (product.getProductName() == null || product.getDescription() == null || product.getDescription() == null
				|| product.getPrice() < 0 || product.getStockQuantity() < 0 || product.getCategoryId() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"Product\"( \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\") VALUES (?, ?, ?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, product.getProductName());
				pstmt.setObject(2, product.getDescription());
				pstmt.setObject(3, product.getPrice());
				pstmt.setObject(4, product.getStockQuantity());
				pstmt.setObject(5, product.getCategoryId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("added successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue while adding a new product");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/searchproduct")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Product> searchProduct(@QueryParam("search") String searchQuery) {
		List<Product> listOfProduct = new ArrayList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT p.\"productId\", p.\"productName\", p.description, p.unit_price, p.\"stockQuantity\", p.\"categoryId\" FROM public.\"Product\" p JOIN public.\"ProductCategory\" pc on p.\"categoryId\"=pc.\"categoryId\" WHERE \"stockQuantity\">0 AND p.\"productName\" ILIKE '%"
					+ searchQuery + "%' OR pc.\"categoryName\" ILIKE '%" + searchQuery + "%'  and \"stockQuantity\">0;";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				while (resultSet.next()) {
					Product product = updateProductValue(resultSet);
					listOfProduct.add(product);
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while searching a product");
		}
		return listOfProduct;
	}

	@GET
	@Path("/getproductbyid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Product getProductById(@QueryParam("productid") int productId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"productId\", \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\" FROM public.\"Product\" where \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					return updateProductValue(resultSet);

				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}

	@PUT
	@Path("/updatestock")
	public Response updateStockQuantity(Product product) {
		if (product.getProductId() < 1 || product.getStockQuantity() < 0)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = DbConnection.getInstance().getConnection()) {
			String query = "UPDATE public.\"Product\" SET \"stockQuantity\"=? WHERE \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, product.getStockQuantity());
				pstmt.setObject(2, product.getProductId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("stock updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in updating a stock quantity");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getallproducts")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Product> getAllProductRecords() {
		List<Product> listOfProduct = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"productId\", \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\" FROM public.\"Product\" ORDER BY \"productId\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Product product = updateProductValue(resultSet);
						if (product != null)
							listOfProduct.add(product);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return listOfProduct;
	}

	@DELETE
	@Path("/removeproduct")
	public Response removeProductById(@QueryParam("productid") int id) {
		System.out.println(id);
		if (id < 0)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"Product\" WHERE \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, id);
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("deleted successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	public Product updateProductValue(ResultSet resultSet) {
		try {
			Product product = new Product();
			product.setProductId(resultSet.getInt("productId"));
			product.setProductName(resultSet.getString("productName"));
			product.setDescription(resultSet.getString("description"));
			product.setPrice(resultSet.getDouble("unit_price"));
			product.setStockQuantity(resultSet.getInt("stockQuantity"));
			product.setCategoryId(resultSet.getInt("categoryId"));
			return product;
		} catch (IllegalAccessException exception) {
			System.out.println("illegal access");
		} catch (SQLException exception) {
			System.out.println("issue in update product value");
		}
		return null;
	}

	// CANCEL TABLE
	/**
	 * add record on cancel table
	 */
	@POST
	@Path("/addcancel")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addCancel(Cancel cancel) {
		System.out.println(cancel.toString());
		if (cancel.getReason_() == null || cancel.getReason_().isEmpty() || cancel.getOrderId_() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"Cancel\"(\"orderId\", reason) VALUES (?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cancel.getOrderId_());
				pstmt.setObject(2, cancel.getReason_());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("cancel record created successfully").build();
			}

		} catch (SQLException exception) {
			System.out.println("issue in adding a cancel record");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	/**
	 * get all cancel records
	 *
	 * @return List<Cancel>
	 */

	@GET
	@Path("/getcancel")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Cancel> getAllCancelRecords() {
		System.out.println("called cancel");
		List<Cancel> cancelRecords = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"cancelId\", \"orderId\", reason, \"canceledAt\" FROM public.\"Cancel\" order by \"cancelId\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Cancel cancel = new Cancel();
						cancel.setCancelId_(resultSet.getInt("cancelId"));
						cancel.setReason_(resultSet.getString("reason"));
						cancel.setOrderId_(resultSet.getInt("orderId"));
						cancel.setCanceledAt_(resultSet.getString("canceledAt"));
						cancelRecords.add(cancel);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in getting all cancel records");
		}
		return cancelRecords;
	}

	// PRODUCT CATEGORY
	@GET
	@Path("/getcategorybyid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public ProductCategory getProductCategoryById(@QueryParam("categoryid") int productCategoryId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"categoryId\", \"categoryName\" FROM public.\"ProductCategory\" WHERE \"categoryId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productCategoryId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					ProductCategory productCategory = new ProductCategory();
					productCategory.setCategoryId(resultSet.getInt("categoryId"));
					productCategory.setCategoryName(resultSet.getString("categoryName"));
					return productCategory;
				}
			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}

	@GET
	@Path("/getallcategory")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<ProductCategory> getAllProductCategoryRecords() {
		List<ProductCategory> records = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"categoryId\", \"categoryName\" FROM public.\"ProductCategory\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						ProductCategory productCategory = updateValueCategory(resultSet);
						if (productCategory != null)
							records.add(productCategory);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return records;
	}

	/**
	 * add record in ProductCategory table
	 */
	@POST
	@Path("/addcategory")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addProductCategory(ProductCategory productCategory) {
		if (productCategory.getCategoryName() == null || productCategory.getCategoryName().isEmpty())
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"ProductCategory\"(\"categoryName\") VALUES (?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productCategory.getCategoryName());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("category record created successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	/**
	 * update retrieved value to productCategory
	 */
	public ProductCategory updateValueCategory(ResultSet resultSet) {
		try {
			ProductCategory productCategory = new ProductCategory();
			productCategory.setCategoryId(resultSet.getInt("categoryId"));
			productCategory.setCategoryName(resultSet.getString("categoryName"));
			return productCategory;
		} catch (IllegalAccessException exception) {
			System.out.println("illegal exception");
		} catch (SQLException exception) {
			System.out.println("SQL exception");
		}
		return null;
	}

	// CART TABLE

	@POST
	@Path("/addcart")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Cart createCart(User user) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			Cart cart = isCartExisting(user.getUserId());
			if (cart != null) {
				return cart;
			} else {
				String query = "INSERT INTO public.\"Cart\"(\"userId\")VALUES (?)";
				try (PreparedStatement pstmt = connection.prepareStatement(query)) {
					pstmt.setObject(1, user.getUserId());
					pstmt.executeUpdate();
					String lastValQuery = "SELECT LASTVAL()";
					Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(lastValQuery);
					if (resultSet.next()) {
						Cart newCart = new Cart();
						newCart.setCartId(resultSet.getInt(1));
						newCart.setUserId(user.getUserId());
						newCart.setCreatedAt(LocalDate.now().toString());
						return newCart;
					}
				} catch (IllegalAccessException exception) {
					System.out.println("issue in creating a cart");
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in create cart");
		}

		return null;
	}

	/**
	 * get record if exists
	 *
	 * @return Cart
	 */
	public Cart isCartExisting(int userId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"cartId\", \"userId\", \"createdAt\" FROM public.\"Cart\" where \"userId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, userId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet.next()) {
					Cart cart = new Cart();
					cart.setUserId(resultSet.getInt("userId"));
					cart.setCartId(resultSet.getInt("cartId"));
					cart.setCreatedAt(resultSet.getString("createdAt"));
					return cart;
				}

			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart");
		}
		return null;
	}

	// PAYMENT
	@POST
	@Path("/addpayment")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response makePayment(Payment payment) {
		if (payment.getPaymentMethod() == null || payment.getPaymentMethod().isEmpty())
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		else if (!payment.getPaymentMethod().equals("COD") && !payment.getPaymentMethod().equals("UPI"))
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid payment method").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"Payment\"(\"orderId\", \"paymentMethod\", \"paymentStatus\") VALUES ( ?,(CAST(? AS payment_method)),(CAST(? AS payment_status)) )";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, payment.getOrderId());
				pstmt.setObject(2, payment.getPaymentMethod());
				String paymentMethod = payment.getPaymentMethod();
				if (paymentMethod.equals("COD")) {
					pstmt.setObject(3, "pending");
				} else {
					pstmt.setObject(3, "completed");
				}
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("payment record created successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@PUT
	@Path("/paymentdone")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response paymentDone(Payment payment) {
		System.out.println(payment.toString());
		if (payment.getOrderId() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"Payment\" SET \"paymentStatus\"='completed' WHERE \"orderId\"=? AND \"paymentMethod\"='COD'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, payment.getOrderId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("payment record updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getpayments")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Payment> getAllPayments() {
		List<Payment> records = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"paymentId\", \"orderId\", \"paymentMethod\", \"paymentStatus\", \"paymentDate\" FROM public.\"Payment\" order by \"paymentId\";";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Payment payment = new Payment();
						payment.setPaymentId(resultSet.getInt("paymentId"));
						payment.setOrderId(resultSet.getInt("orderId"));
						payment.setPaymentDate(resultSet.getString("paymentDate"));
						payment.setPaymentStatus(resultSet.getString("paymentStatus"));
						payment.setPaymentMethod(resultSet.getString("paymentMethod"));
						records.add(payment);
					}
				}
			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("sql issue in getting all payments");
		}
		return records;
	}

	// CART ITEM
	@POST
	@Path("/addcartitem")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response createCartItem(CartItem cartItem) {
		if (cartItem.getQuantity() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"CartItem\"( \"cartId\", \"productId\", quantity) VALUES (?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {

				pstmt.setObject(1, cartItem.getCartId());
				pstmt.setObject(2, cartItem.getProductId());
				pstmt.setObject(3, cartItem.getQuantity());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("cartItem record updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getcartitems")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<CartItem> getCartItems(Cart cart) {
		List<CartItem> cartItems = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"cartItemId\", \"cartId\", \"productId\", quantity\n"
					+ "\tFROM public.\"CartItem\" where  \"cartId\"=? order by \"cartItemId\"";

			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cart.getCartId());
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						CartItem cartItem = new CartItem();
						cartItem.setCartId(resultSet.getInt("cartId"));
						cartItem.setCartItemId(resultSet.getInt("cartItemId"));
						cartItem.setQuantity(resultSet.getInt("quantity"));
						cartItem.setProductId(resultSet.getInt("productId"));
						cartItems.add(cartItem);
					}
				}

			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			} catch (Exception exception) {
				System.out.println("Something went wrong. Please try later");
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return cartItems;
	}

	@DELETE
	@Path("/removecartitemsbycartid")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response removeCartItems(Cart cart) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"CartItem\" WHERE \"cartId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cart.getCartId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("cartItem record removed successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@DELETE
	@Path("/removecartitemsbycartitemid")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response removeCartItemById(CartItem cartItem) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"CartItem\" WHERE \"cartItemId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cartItem.getCartItemId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("cartItem record removed successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't delete a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	// ORDER TABLE

	@POST
	@Path("/addorder")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addOrderpraveen(Order order) {
		System.out.println(order.toString());
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {

			String insertQuery = "INSERT INTO public.\"Order\"(\n" + "\t \"userId\", \"totalAmount\", status)\n"
					+ "\tVALUES (?, ?, 'pending')";
			// String lastValQuery = "SELECT LASTVAL()";
			try (PreparedStatement pstmt = connection.prepareStatement(insertQuery)) {
				pstmt.setObject(1, order.getUserId());
				pstmt.setObject(2, order.getTotalAmount());
				pstmt.executeUpdate();
				// Statement statement = connection.createStatement();
				// ResultSet resultSet = statement.executeQuery(lastValQuery);
				// int orderId = -1;
				// if (resultSet.next()) {
				// orderId = resultSet.getInt(1);
				// } else
				// System.out.println("No order id found");
				return Response.status(Response.Status.OK).entity("order record removed successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in adding a order");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getpendingorderbyorderid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Order getOrderById(@QueryParam("orderid") int orderId) {
		System.out.println(orderId);
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"orderId\", \"userId\", \"totalAmount\", \"orderDate\", status FROM public.\"Order\" WHERE \"orderId\"=? AND status='pending'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, orderId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					return getOrderWithValue(resultSet);
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in getting orders. Please try later");
		}
		return null;
	}

	@GET
	@Path("/getorderbyuserid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Order> getOrdersByUserId(@QueryParam("userid") int userid) {
		List<Order> orderRecords = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"orderId\", \"userId\", \"totalAmount\", \"orderDate\", status FROM public.\"Order\" WHERE \"userId\"=? ORDER BY \"orderId\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, userid);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Order order = getOrderWithValue(resultSet);
						if (order != null)
							orderRecords.add(order);
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("issue in getting a order with status");
		}
		return orderRecords;
	}

	@PUT
	@Path("/cancelorder")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response cancelOrderById(Order order) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"Order\" SET status='canceled' WHERE \"orderId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, order.getOrderId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("canceled order successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in getting orders. Please try later");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getallorders")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Order> getAllOrders() {
		List<Order> orders = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"orderId\", \"userId\", \"totalAmount\", \"orderDate\", status FROM public.\"Order\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Order order = getOrderWithValue(resultSet);
						orders.add(order);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in getting orders. Please try later");
		}
		return orders;
	}

	@GET
	@Path("/getorderbystatus")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Order> getOrderByStatus(@QueryParam("status") String status) {
		List<Order> orders = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"orderId\", \"userId\", \"totalAmount\", \"orderDate\", status FROM public.\"Order\" WHERE status=(CAST(? AS status))";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, status);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Order order = getOrderWithValue(resultSet);
						if (order != null)
							orders.add(order);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in getting orders. Please try later");
		}
		return orders;
	}

	@PUT
	@Path("/deliverorder")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response orderDelivered(Order order) {
		System.out.println(order.toString());
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"Order\" SET status='completed' WHERE \"orderId\"=? AND status='pending'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, order.getOrderId());
				int affectedRows = pstmt.executeUpdate();

				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("delivered order successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in updating orders status. Please try later");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	public Order getOrderWithValue(ResultSet resultSet) {
		try {
			Order order = new Order();
			order.setOrderId(resultSet.getInt("orderId"));
			order.setUserId(resultSet.getInt("userId"));
			order.setTotalAmount(resultSet.getDouble("totalAmount"));
			order.setOrderDate(resultSet.getString("orderDate"));
			order.setOrderStatus(resultSet.getString("status"));
			return order;
		} catch (IllegalAccessException exception) {
			System.out.println("illegal access");
		} catch (SQLException e) {
			System.out.println("issue in getting a order with status");
		}
		return null;
	}

	// ORDER ITEM TABLE
	@POST
	@Path("/addorderitem")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addOrderItem(OrderItem orderItem) {
		System.out.print(orderItem.toString());
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"OrderItem\"(\n" + "\t \"orderId\", \"productId\", quantity, price)\n"
					+ "\tVALUES (?, ?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, orderItem.getOrderId());
				pstmt.setObject(2, orderItem.getProductId());
				pstmt.setObject(3, orderItem.getQuantity());
				pstmt.setObject(4, orderItem.getPrice());

				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("created order item successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in adding a order item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getorderitembyorderid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<OrderItem> getOrderItemsByOrderId(@QueryParam("orderid") int orderid) {
		System.out.println(orderid);
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"orderItemId\", \"orderId\", \"productId\", quantity, price FROM public.\"OrderItem\" where \"orderId\"=? order by \"orderItemId\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, orderid);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					List<OrderItem> orderItems = new LinkedList<>();
					while (resultSet.next()) {
						OrderItem orderItem = new OrderItem();
						orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
						orderItem.setOrderId(resultSet.getInt("orderId"));
						orderItem.setProductId(resultSet.getInt("productId"));
						orderItem.setQuantity(resultSet.getInt("quantity"));
						orderItem.setPrice(resultSet.getDouble("price"));
						orderItems.add(orderItem);
					}
					return orderItems;
				}
			} catch (IllegalAccessException exception) {
				System.out.println(exception.getMessage());
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}

	@GET
	@Path("/morethanonecartitem")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<OrderItem> getMoreThanOneOrderItemWithSameOrderId(@QueryParam("userid") int userId) {
		System.out.print(userId);
		List<OrderItem> orderItems = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT oi.\"orderItemId\", oi.\"orderId\", oi.\"productId\", oi.quantity, oi.price FROM public.\"OrderItem\" oi JOIN public.\"Order\" o ON oi.\"orderId\"=o.\"orderId\" WHERE o.\"userId\"=? AND oi.\"orderId\" IN (SELECT \"orderId\" FROM public.\"OrderItem\" GROUP BY \"orderId\" HAVING COUNT(*)>1);";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, userId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {

					while (resultSet.next()) {
						OrderItem orderItem = new OrderItem();
						orderItem.setOrderItemId(resultSet.getInt("orderItemId"));
						orderItem.setOrderId(resultSet.getInt("orderId"));
						orderItem.setProductId(resultSet.getInt("productId"));
						orderItem.setQuantity(resultSet.getInt("quantity"));
						orderItem.setPrice(resultSet.getDouble("price"));
						orderItems.add(orderItem);
					}
					return orderItems;
				}
			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return orderItems;
	}

}
