package com.praveen.dao;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

public class UserDaoImpl implements UserDao {
	
	
	@GET
	@Produces("application/json")
	@Override
	public void filterUsers(@QueryParam("name") String name, @QueryParam("country") String category) {
		
	}

}
