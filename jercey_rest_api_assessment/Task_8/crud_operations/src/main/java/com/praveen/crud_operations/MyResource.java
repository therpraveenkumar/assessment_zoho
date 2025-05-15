
package com.praveen.crud_operations;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Example resource class hosted at the URI path "/myresource"
 */
@Path("/users")
public class MyResource {

	/**
	 * Method processing HTTP GET requests, producing "text/plain" MIME media type.
	 * 
	 * @return String that will be send back as a response of type "text/plain".
	 */
	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> getUsers() {
		List<User> users = new ArrayList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT user_id, user_name, country FROM public.\"user\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				while (resultSet.next()) {
					User user = new User();
					user.setUser_id(resultSet.getInt("user_id"));
					user.setUser_name(resultSet.getString("user_name"));
					user.setCountry(resultSet.getString("country"));
					System.out.println(user);
					users.add(user);
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return users;
	}

	private User getUser(User updatedUser) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT user_id, user_name, country FROM public.\"user\" WHERE user_id=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, updatedUser.getUser_id());
				System.out.println("updated "+updatedUser.toString());
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet!=null && resultSet.next()) {
					User user = new User();
					user.setUser_id(resultSet.getInt("user_id"));
					user.setUser_name(resultSet.getString("user_name"));
					user.setCountry(resultSet.getString("country"));

					return user;
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}
	
	@POST
	@Path("/create_user")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response createUser(User updatedUser) {
		System.out.println(updatedUser.toString());
		
		if (updatedUser.getUser_name()==null || updatedUser.getCountry()==null) {
			return Response.status(Response.Status.NOT_FOUND).entity("invalid data")
					.type(MediaType.APPLICATION_JSON).build();
		}
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"user\"( user_name, country) VALUES (?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				
				pstmt.setObject(1, updatedUser.getUser_name());
				pstmt.setObject(2, updatedUser.getCountry());
				pstmt.executeUpdate();
			}
		} catch (SQLException exception) {
			return Response.status(Response.Status.NOT_FOUND).entity("user is not found")
					.type(MediaType.APPLICATION_JSON).build();
		}
		return Response.ok("created successfully").build();
	}

	@PUT
	@Path("/update_user")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response updateUser(User updatedUser) {
		
		User existingUser = getUser(updatedUser);
		if (existingUser == null) {
			return Response.status(Response.Status.NOT_FOUND).entity("user is not found")
					.type(MediaType.APPLICATION_JSON).build();
		}
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"user\" SET user_name=?, country=? WHERE user_id=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, updatedUser.getUser_name());
				pstmt.setObject(2, updatedUser.getCountry());
				pstmt.setObject(3, updatedUser.getUser_id());
				pstmt.executeUpdate();
			}
		} catch (SQLException exception) {
			return Response.status(Response.Status.NOT_FOUND).entity("user is not found")
					.type(MediaType.APPLICATION_JSON).build();
		}
		return Response.ok("updated successfully").build();
	}
	
	@DELETE
	@Path("/delete_user")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response deleteUser(User updatedUser) {
		
		User existingUser = getUser(updatedUser);
		if (existingUser == null) {
			return Response.status(Response.Status.NOT_FOUND).entity("user is not found")
					.type(MediaType.APPLICATION_JSON).build();
		}
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"user\" WHERE user_id=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				
				pstmt.setObject(1, updatedUser.getUser_id());
				pstmt.executeUpdate();
			}
		} catch (SQLException exception) {
			return Response.status(Response.Status.NOT_FOUND).entity("user is not found")
					.type(MediaType.APPLICATION_JSON).build();
		}
		return Response.ok("deleted successfully").build();
	}
}
