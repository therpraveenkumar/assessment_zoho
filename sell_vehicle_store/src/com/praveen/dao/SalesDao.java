package com.praveen.dao;

import java.util.List;

import com.praveen.model.Sales;

public interface SalesDao {
	boolean createSale(Sales sales);
	List<Sales> getSales();
	Sales getSalesById(int id);
	int getLastSalesId();
}
