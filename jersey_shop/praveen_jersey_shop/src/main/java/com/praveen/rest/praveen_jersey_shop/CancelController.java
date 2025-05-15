package com.praveen.rest.praveen_jersey_shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.model.Cancel;
import com.praveen.util.DbConnection;
import com.praveen.model.ProductCategory;

@Path("cancel")
public class CancelController {
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

}
