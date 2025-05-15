package com.praveen.rest.praveen_jersey_shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;

import com.praveen.model.Cart;
import com.praveen.util.DbConnection;
import com.praveen.model.User;

@Path("cart")
public class CartController {
	@POST
	@Path("/addcart")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Cart createCart(User user) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			Cart cart = isCartExisting(user.getUserId());
			if (cart != null) {
				return cart;
			} else {
				String query = "INSERT INTO public.\"Cart\"(\"userId\")VALUES (?)";
				try (PreparedStatement pstmt = connection.prepareStatement(query)) {
					pstmt.setObject(1, user.getUserId());
					pstmt.executeUpdate();
					String lastValQuery = "SELECT LASTVAL()";
					Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(lastValQuery);
					if (resultSet.next()) {
						Cart newCart = new Cart();
						newCart.setCartId(resultSet.getInt(1));
						newCart.setUserId(user.getUserId());
						newCart.setCreatedAt(LocalDate.now().toString());
						return newCart;
					}
				} catch (IllegalAccessException exception) {
					System.out.println("issue in creating a cart");
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue in create cart");
		}

		return null;
	}

	/**
	 * get record if exists
	 *
	 * @return Cart
	 */
	public Cart isCartExisting(int userId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"cartId\", \"userId\", \"createdAt\" FROM public.\"Cart\" where \"userId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, userId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet.next()) {
					Cart cart = new Cart();
					cart.setUserId(resultSet.getInt("userId"));
					cart.setCartId(resultSet.getInt("cartId"));
					cart.setCreatedAt(resultSet.getString("createdAt"));
					return cart;
				}

			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("can't create a cart");
		}
		return null;
	}
}
