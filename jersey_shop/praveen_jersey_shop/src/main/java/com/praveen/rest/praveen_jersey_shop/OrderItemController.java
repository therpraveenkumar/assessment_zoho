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

import com.praveen.util.DbConnection;
import com.praveen.model.OrderItem;

@Path("orderitem")
public class OrderItemController {
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
