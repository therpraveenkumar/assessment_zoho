/**
 * SELLVehicle customer dao implementation.
 * @author praveen-22566
 */
package com.praveen.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.adventnet.db.api.RelationalAPI;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.DataSet;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.QueryConstructionException;
import com.adventnet.ds.query.SelectQuery;
import com.adventnet.ds.query.SelectQueryImpl;
import com.adventnet.ds.query.Table;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.praveen.model.Customer;

public class CustomerDaoImpl implements CustomerDao {

	/**
	 * Method to create customer
	 * @param {@codeCustomer} customer
	 * @return boolean
	 * */
	@Override
	public boolean createCustomer(Customer customer) {
		Row row = new Row("customer");
		row.set("name", customer.getName());
		row.set("email", customer.getEmail());
		row.set("phone", customer.getPhone());
		row.set("address", customer.getAddress());
		DataObject dataObject = new WritableDataObject();
		try {
			dataObject.addRow(row);
			DataAccess.add(dataObject);
			return true;
		} catch (DataAccessException e) {
			System.out.println(e.toString());
		}
		return false;
	}

	/**
	 * Method to update customer
	 * @param {@codeCustomer} customer
	 * @return boolean
	 * */
	@Override
	public boolean updateName(Customer customer) {
		Criteria criteria = new Criteria(new Column("customer", "customer_id"), customer.getCustomer_id(),
				QueryConstants.EQUAL);
		try {
			DataObject dataObject = DataAccess.get("customer", criteria);
			Row row = dataObject.getRow("customer");
			row.set("name", customer.getName());
			dataObject.updateRow(row);
			DataAccess.update(dataObject);
			return true;
		} catch (DataAccessException exception) {
			System.out.println(exception.toString());
		}
		return false;
	}

	/**
	 * Method to get customer
	 * @return List<Customer>
	 * */
	@Override
	public List<Customer> getCustomers() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("customer");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("customer", "*");
			selectQuery.addSelectColumn(customerColumns);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);
			List<Customer> customers = new ArrayList<>();
			while (dataSet.next()) {
				Customer customer = new Customer();

				try {
					customer.setCustomer_id(Integer.parseInt(dataSet.getValue("customer_id").toString()));
					customer.setName(dataSet.getValue("name").toString());
					customer.setEmail(dataSet.getValue("email").toString());
					customer.setPhone(dataSet.getValue("phone").toString());
					customer.setAddress(dataSet.getValue("address").toString());
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				customers.add(customer);
			}
			return customers;
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Method to delete customer
	 * @param {@codeCustomer} customer
	 * @return boolean
	 * */
	@Override
	public boolean deleteCustomer(Customer customer) {
		Criteria criteria = new Criteria(new Column("customer", "customer_id"), customer.getCustomer_id(),
				QueryConstants.EQUAL);

		try {
			DataObject customerDO = DataAccess.get("customer", (Criteria) null);
			customerDO.deleteRows("customer", criteria);
			DataAccess.update(customerDO);
			return true;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return false;
	}

}
