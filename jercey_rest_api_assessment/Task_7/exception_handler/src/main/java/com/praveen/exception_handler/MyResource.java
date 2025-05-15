
package com.praveen.exception_handler;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/** Example resource class hosted at the URI path "/myresource"
 */
@Path("/myresource")
public class MyResource {
    
    /** Method processing HTTP GET requests, producing "text/plain" MIME media
     * type.
     * @return String that will be send back as a response of type "text/plain".
     */
    @GET 
    @Produces("text/plain")
    public String getIt() {
        return "Hi there!";
    }
    
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUser(@PathParam("id") int id) throws UserNotFoundException {
        // Simulate the case where the user is not found
        if (id != 1) {
        	try {
        		throw new UserNotFoundException("User with ID " + id + " not found.");
        	}
        	catch(UserNotFoundException exception) {
        		 return Response.status(Response.Status.NOT_FOUND)
                         .entity("user is not found")
                         .type(MediaType.APPLICATION_JSON)
                         .build();
        	}
            
        }
        
        // If found, return a mock user response
        return Response.ok("{ \"id\": " + id + ", \"name\": \"John Doe\" }").build();
    }
}
