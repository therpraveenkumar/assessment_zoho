
package com.praveen.helloApp;

import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.MatrixParam;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Example resource class hosted at the URI path "/myresource"
 */
@Path("/myresource")
public class MyResource {

	/**
	 * Method processing HTTP GET requests, producing "text/plain" MIME media
	 * type.
	 * 
	 * @return String that will be send back as a response of type "text/plain".
	 */
	@GET
	@Produces("text/plain")
	public String getIt() {
		return "Hello world by praveen!";
	}

	@GET
	@Path("/header")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getHeaderParams(@HeaderParam("User-Agent") String userAgent) {

		String message = "Headers - User-Agent: " + userAgent;
		return Response.ok(message).build();
	}

	@GET
	@Path("/{param1}/{param2}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getMatrixParams(@PathParam("param1") String param1, @PathParam("param2") String param2,
			@MatrixParam("matrixParam1") String matrixParam1, @MatrixParam("matrixParam2") String matrixParam2) {

		String message = "Path Params: " + param1 + ", " + param2 + " Matrix Params: " + matrixParam1 + ", "
				+ matrixParam2;

		return Response.ok(message).build();
	}
}
