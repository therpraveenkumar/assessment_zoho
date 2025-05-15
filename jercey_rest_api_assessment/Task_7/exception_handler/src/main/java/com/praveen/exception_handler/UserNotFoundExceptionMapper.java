package com.praveen.exception_handler;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class UserNotFoundExceptionMapper implements ExceptionMapper<UserNotFoundException> {

	@Override
    public Response toResponse(UserNotFoundException exception) {
        // Returning a 404 error with the exception message
        ErrorMessage errorMessage = new ErrorMessage(exception.getMessage());

        return Response.status(Response.Status.NOT_FOUND)
                       .entity(errorMessage)
                       .type(MediaType.APPLICATION_JSON)
                       .build();
    }
}

