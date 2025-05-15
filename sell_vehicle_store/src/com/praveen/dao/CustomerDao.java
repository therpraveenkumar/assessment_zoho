/**
 * SELLVehicle customer dao.
 * @author praveen-22566
 */
package com.praveen.dao;

import java.util.List;

import com.praveen.model.Customer;

public interface CustomerDao {
	boolean createCustomer(Customer customer);
	boolean updateName(Customer customer);
	List<Customer> getCustomers();
	boolean deleteCustomer(Customer customer);
}
