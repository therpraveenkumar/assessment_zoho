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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.praveen.util.DbConnection;
import com.praveen.model.Payment;

@Path("payment")
public class PaymentController {
	@POST
	@Path("/addpayment")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response makePayment(Payment payment) {
		if (payment.getPaymentMethod() == null || payment.getPaymentMethod().isEmpty())
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		else if (!payment.getPaymentMethod().equals("COD") && !payment.getPaymentMethod().equals("UPI"))
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid payment method").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "INSERT INTO public.\"Payment\"(\"orderId\", \"paymentMethod\", \"paymentStatus\") VALUES ( ?,(CAST(? AS payment_method)),(CAST(? AS payment_status)) )";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, payment.getOrderId());
				pstmt.setObject(2, payment.getPaymentMethod());
				String paymentMethod = payment.getPaymentMethod();
				if (paymentMethod.equals("COD")) {
					pstmt.setObject(3, "pending");
				} else {
					pstmt.setObject(3, "completed");
				}
				pstmt.executeUpdate();
				return Response.status(Response.Status.OK).entity("payment record created successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@PUT
	@Path("/paymentdone")
	@Consumes({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public Response paymentDone(Payment payment) {
		System.out.println(payment.toString());
		if (payment.getOrderId() < 1)
			return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "UPDATE public.\"Payment\" SET \"paymentStatus\"='completed' WHERE \"orderId\"=? AND \"paymentMethod\"='COD'";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				pstmt.setObject(1, payment.getOrderId());
				int affectedRows = pstmt.executeUpdate();
				if (affectedRows > 0)
					return Response.status(Response.Status.OK).entity("payment record updated successfully").build();
			}
		} catch (SQLException exception) {
			System.out.println("wrong value");
		}
		return Response.status(Response.Status.NOT_ACCEPTABLE).entity("invalid data").build();
	}

	@GET
	@Path("/getpayments")
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<Payment> getAllPayments() {
		List<Payment> records = new LinkedList<>();
		try (Connection connection = Objects.requireNonNull(DbConnection.getInstance()).getConnection()) {
			String query = "SELECT \"paymentId\", \"orderId\", \"paymentMethod\", \"paymentStatus\", \"paymentDate\" FROM public.\"Payment\" order by \"paymentId\";";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
				ResultSet resultSet = pstmt.executeQuery();
				if (resultSet != null) {
					while (resultSet.next()) {
						Payment payment = new Payment();
						payment.setPaymentId(resultSet.getInt("paymentId"));
						payment.setOrderId(resultSet.getInt("orderId"));
						payment.setPaymentDate(resultSet.getString("paymentDate"));
						payment.setPaymentStatus(resultSet.getString("paymentStatus"));
						payment.setPaymentMethod(resultSet.getString("paymentMethod"));
						records.add(payment);
					}
				}
			} catch (IllegalAccessException exception) {
				System.out.println("illegal access");
			}
		} catch (SQLException exception) {
			System.out.println("sql issue in getting all payments");
		}
		return records;
	}
}
