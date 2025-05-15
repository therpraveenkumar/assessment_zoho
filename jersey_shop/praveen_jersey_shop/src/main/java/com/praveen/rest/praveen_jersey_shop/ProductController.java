package com.praveen.rest.praveen_jersey_shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.util.DbConnection;
import com.praveen.model.Product;

@Path("/products")
public class ProductController {
	@POST
	@Path("/addproduct")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addNewProduct(Product product) {
		System.out.println(product.toString());
		if (product.getProductName() == null || product.getDescription() == null || product.getDescription() == null
				|| product.getPrice() < 0 || product.getStockQuantity() < 0 || product.getCategoryId() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"Product\"( \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\") VALUES (?, ?, ?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, product.getProductName());
				pstmt.setObject(2, product.getDescription());
				pstmt.setObject(3, product.getPrice());
				pstmt.setObject(4, product.getStockQuantity());
				pstmt.setObject(5, product.getCategoryId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("added successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue while adding a new product");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/searchproduct")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Product> searchProduct(@QueryParam("search") String searchQuery) {
		List<Product> listOfProduct = new ArrayList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT p.\"productId\", p.\"productName\", p.description, p.unit_price, p.\"stockQuantity\", p.\"categoryId\" FROM public.\"Product\" p JOIN public.\"ProductCategory\" pc on p.\"categoryId\"=pc.\"categoryId\" WHERE \"stockQuantity\">0 AND p.\"productName\" ILIKE '%"
					+ searchQuery + "%' OR pc.\"categoryName\" ILIKE '%" + searchQuery + "%'  and \"stockQuantity\">0;";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				while (resultSet.next()) {
					Product product = updateProductValue(resultSet);
					listOfProduct.add(product);
				}
			}
		} catch (SQLException exception) {
			System.out.println("issue while searching a product");
		}
		return listOfProduct;
	}

	@GET
	@Path("/getproductbyid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Product getProductById(@QueryParam("productid") int productId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"productId\", \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\" FROM public.\"Product\" where \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					return updateProductValue(resultSet);

				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}

	@PUT
	@Path("/updatestock")
	public Response updateStockQuantity(Product product) {
		if (product.getProductId() < 1 || product.getStockQuantity() < 0)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = DbConnection.getInstance().getConnection()) {
			String query = "UPDATE public.\"Product\" SET \"stockQuantity\"=? WHERE \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, product.getStockQuantity());
				pstmt.setObject(2, product.getProductId());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("stock updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("issue in updating a stock quantity");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getallproducts")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Product> getAllProductRecords() {
		List<Product> listOfProduct = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"productId\", \"productName\", description, unit_price, \"stockQuantity\", \"categoryId\" FROM public.\"Product\" ORDER BY \"productId\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Product product = updateProductValue(resultSet);
						if (product != null)
							listOfProduct.add(product);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return listOfProduct;
	}

	@DELETE
	@Path("/removeproduct")
	public Response removeProductById(@QueryParam("productid") int id) {
		System.out.println(id);
		if (id < 0)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "DELETE FROM public.\"Product\" WHERE \"productId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, id);
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("deleted successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	public Product updateProductValue(ResultSet resultSet) {
		try {
			Product product = new Product();
			product.setProductId(resultSet.getInt("productId"));
			product.setProductName(resultSet.getString("productName"));
			product.setDescription(resultSet.getString("description"));
			product.setPrice(resultSet.getDouble("unit_price"));
			product.setStockQuantity(resultSet.getInt("stockQuantity"));
			product.setCategoryId(resultSet.getInt("categoryId"));
			return product;
		} catch (IllegalAccessException exception) {
			System.out.println("illegal access");
		} catch (SQLException exception) {
			System.out.println("issue in update product value");
		}
		return null;
	}
}
