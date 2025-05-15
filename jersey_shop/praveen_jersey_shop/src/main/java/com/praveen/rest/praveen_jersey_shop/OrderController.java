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
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.util.DbConnection;
import com.praveen.model.Order;

@Path("order")
public class OrderController {
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
				return Response.status(Response.Status.OK).entity("order record created successfully").build();
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
					Order order = getOrderWithValue(resultSet);
					System.out.println(order.toString());
					return order;
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
}
