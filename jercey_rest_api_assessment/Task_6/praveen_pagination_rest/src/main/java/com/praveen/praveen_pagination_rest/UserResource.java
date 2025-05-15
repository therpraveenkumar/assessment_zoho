package com.praveen.praveen_pagination_rest;

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
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import service.UserService;


@Path("users")
public class UserResource {

	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> getUsers() {
		User user = new User();
		
		List<User> ls = new ArrayList<>();
		ls.add(user);
		return ls;
	}
	
	@GET
	@Path("/user")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<User> getBooks(@QueryParam("page") @DefaultValue("1") int page,
			@QueryParam("size") @DefaultValue("10") int pageSize) {
		// Get paginated books
		UserService us = new UserService();
		List<User> paginatedBooks = us.getUsers(page, pageSize);

		// Return response with pagination info in the headers
		return paginatedBooks;
	}

}
