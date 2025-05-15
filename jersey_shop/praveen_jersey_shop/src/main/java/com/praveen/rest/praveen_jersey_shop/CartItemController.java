package com.praveen.rest.praveen_jersey_shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.model.Cart;
import com.praveen.model.CartItem;
import com.praveen.util.DbConnection;

@Path("cartitem")
public class CartItemController {
	@POST
	@Path("/addcartitem")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response createCartItem(CartItem cartItem) {
		if (cartItem.getQuantity() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"CartItem\"( \"cartId\", \"productId\", quantity) VALUES (?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {

				pstmt.setObject(1, cartItem.getCartId());
				pstmt.setObject(2, cartItem.getProductId());
				pstmt.setObject(3, cartItem.getQuantity());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("cartItem record updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getcartitems")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<CartItem> getCartItems(Cart cart) {
		List<CartItem> cartItems = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"cartItemId\", \"cartId\", \"productId\", quantity\n"
					+ "\tFROM public.\"CartItem\" where  \"cartId\"=? order by \"cartItemId\"";

			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cart.getCartId());
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						CartItem cartItem = new CartItem();
						cartItem.setCartId(resultSet.getInt("cartId"));
						cartItem.setCartItemId(resultSet.getInt("cartItemId"));
						cartItem.setQuantity(resultSet.getInt("quantity"));
						cartItem.setProductId(resultSet.getInt("productId"));
						cartItems.add(cartItem);
					}
				}

			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			} catch (Exception exception) {
				System.out.println("Something went wrong. Please try later");
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return cartItems;
	}

	@DELETE
	@Path("/removecartitemsbycartid")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response removeCartItems(Cart cart) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"CartItem\" WHERE \"cartId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cart.getCartId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("cartItem record removed successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@DELETE
	@Path("/removecartitemsbycartitemid")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response removeCartItemById(CartItem cartItem) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"CartItem\" WHERE \"cartItemId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, cartItem.getCartItemId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("cartItem record removed successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("can't delete a cart item");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}
}
