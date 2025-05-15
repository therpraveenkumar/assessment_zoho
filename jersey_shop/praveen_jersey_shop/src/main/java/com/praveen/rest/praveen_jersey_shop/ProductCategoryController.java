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
import com.praveen.model.ProductCategory;

@Path("/productcategory")
public class ProductCategoryController {
	@GET
	@Path("/getcategorybyid")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public ProductCategory getProductCategoryById(@QueryParam("categoryid") int productCategoryId) {
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"categoryId\", \"categoryName\" FROM public.\"ProductCategory\" WHERE \"categoryId\"=?";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productCategoryId);
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null && resultSet.next()) {
					ProductCategory productCategory = new ProductCategory();
					productCategory.setCategoryId(resultSet.getInt("categoryId"));
					productCategory.setCategoryName(resultSet.getString("categoryName"));
					return productCategory;
				}
			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return null;
	}

	@GET
	@Path("/getallcategory")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<ProductCategory> getAllProductCategoryRecords() {
		List<ProductCategory> records = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"categoryId\", \"categoryName\" FROM public.\"ProductCategory\"";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						ProductCategory productCategory = updateValueCategory(resultSet);
						if (productCategory != null)
							records.add(productCategory);
					}
				}
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return records;
	}

	/**
	 * add record in ProductCategory table
	 */
	@POST
	@Path("/addcategory")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response addProductCategory(ProductCategory productCategory) {
		if (productCategory.getCategoryName() == null || productCategory.getCategoryName().isEmpty())
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"ProductCategory\"(\"categoryName\") VALUES (?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, productCategory.getCategoryName());
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("category record created successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	/**
	 * update retrieved value to productCategory
	 */
	public ProductCategory updateValueCategory(ResultSet resultSet) {
		try {
			ProductCategory productCategory = new ProductCategory();
			productCategory.setCategoryId(resultSet.getInt("categoryId"));
			productCategory.setCategoryName(resultSet.getString("categoryName"));
			return productCategory;
		} catch (IllegalAccessException exception) {
			System.out.println("illegal exception");
		} catch (SQLException exception) {
			System.out.println("SQL exception");
		}
		return null;
	}
}
