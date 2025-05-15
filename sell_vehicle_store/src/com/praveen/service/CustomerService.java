/**
 * SELLVehicle customer service.
 * @author praveen-22566
 */
package com.praveen.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.dao.CustomerDao;
import com.praveen.dao.CustomerDaoImpl;
import com.praveen.model.Customer;
import com.praveen.parser.JsonParse;

public class CustomerService {
	private CustomerDao customerDao;

	/**
	 * Method to create customer
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public boolean createCustomer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		Customer customer = new Customer();
		if (parsedJson.containsKey("name") && parsedJson.containsKey("email") && parsedJson.containsKey("phone")&& parsedJson.containsKey("address")) {
			if (parsedJson.get("name").trim().isEmpty())
				return false;
			if (parsedJson.get("email").trim().isEmpty())
				return false;
			if (parsedJson.get("phone").trim().length() != 10)
				return false;

			customer.setName(parsedJson.get("name"));
			customer.setEmail(parsedJson.get("email"));
			customer.setPhone(parsedJson.get("phone"));
			customer.setAddress(parsedJson.get("address"));
			customerDao = new CustomerDaoImpl();
			return customerDao.createCustomer(customer);
		} else {
			return false;
		}
	}

	/**
	 * Method to get customer
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void getCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			customerDao = new CustomerDaoImpl();
			List<Customer> receivedCustomers = customerDao.getCustomers();
			if (receivedCustomers != null && !receivedCustomers.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (Customer receivedCustomer : receivedCustomers) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"customer_id\":\"" + receivedCustomer.getCustomer_id() + "\"");
					resp.getWriter().write("\"name\":\"" + receivedCustomer.getName() + "\",");
					resp.getWriter().write("\"email\":\"" + receivedCustomer.getEmail() + "\",");
					resp.getWriter().write("\"phone\":\"" + receivedCustomer.getPhone() + "\",");
					resp.getWriter().write("\"address\":\"" + receivedCustomer.getAddress() + "\"");
					resp.getWriter().write("},");
				}
				resp.getWriter().write("\"}");
				return;
			}

		} catch (Exception e) {
			e.fillInStackTrace();
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"no customers\"}");
	}

	/**
	 * Method to delete customer
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		customerDao = new CustomerDaoImpl();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		Customer customer = new Customer();
		if(parsedJson.containsKey("customer_id")){
			customer.setCustomer_id(Integer.parseInt(parsedJson.get("customer_id")));
			boolean isDeleted = customerDao.deleteCustomer(customer);
			if (isDeleted) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully customer is removed\"}");
				return;
			} 
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"customer not removed\"}");
	}

	/**
	 * Method to update customer
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void updateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		customerDao = new CustomerDaoImpl();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);
		
		if (parsedJson.containsKey("customer_id") && parsedJson.containsKey("name")) {
			Customer customer = new Customer();
			customer.setCustomer_id(Integer.parseInt(parsedJson.get("customer_id")));
			customer.setName(parsedJson.get("name"));
			boolean isupdated = customerDao.updateName(customer);
			if(isupdated){
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"customer name is updated\"}");
				return;
			}
		}

		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"customer name is not updated\"}");
	}
}
