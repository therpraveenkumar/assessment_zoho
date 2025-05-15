/**
 * SELLVehicle customer controller.
 * @author praveen-22566
 */
package com.praveen.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.service.CustomerService;

@WebServlet("/api/customers")
public class CustomerController extends HttpServlet {
	private CustomerService customerService_;

	/**
	 * Method to handle get request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		customerService_ = new CustomerService();
		customerService_.getCustomers(req, resp);

	}

	/**
	 * Method to handle post request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		customerService_ = new CustomerService();
		boolean isCreated = customerService_.createCustomer(req, resp);
		if (isCreated) {
			resp.setContentType("application/json");
			resp.setStatus(200);
			resp.getWriter().write("{\"message\":\"successfully user is created\"}");
		} else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"message\":\"user not create. check params and use unique email and phone\"}");
		}
	}
	
	/**
	 * Method to handle delete request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		customerService_ = new CustomerService();
		customerService_.deleteCustomer(req, resp);
	}

	/**
	 * Method to handle put request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		customerService_ = new CustomerService();
		customerService_.updateCustomer(req, resp);
	}
}
