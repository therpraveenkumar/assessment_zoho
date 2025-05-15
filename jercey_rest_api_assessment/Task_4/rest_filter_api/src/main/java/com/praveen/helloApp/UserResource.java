package com.praveen.helloApp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
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
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.adventnet.ds.query.Criteria;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.praveen.util.DbConnection;

@Path("users")
public class UserResource {

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

	@GET
	@Path("filter_user")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> updateCountry(@QueryParam("name") String name, @QueryParam("country") String country) {
		List<User> users = new ArrayList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			StringBuilder query = new StringBuilder(
					"SELECT user_id, user_name, country FROM public.\"user\" WHERE 1=1 ");
			if (name != null && !name.isEmpty()) {
				query.append(" AND user_name ILIKE ?");
			}
			if (country != null && !country.isEmpty()) {
				query.append(" AND country = ?");
			}
			try (PreparedStatement pstmt = connection.prepareStatement(query.toString())) {

				int index = 1;
				if (name != null && !name.isEmpty()) {
					pstmt.setString(index++, "%" + name + "%");
				}
				if (country != null && !country.isEmpty()) {
					pstmt.setString(index++, country);
				}
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
}
