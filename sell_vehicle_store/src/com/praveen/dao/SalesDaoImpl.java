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
import com.adventnet.ds.query.SortColumn;
import com.adventnet.ds.query.Table;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.praveen.model.Sales;

public class SalesDaoImpl implements SalesDao {

	@Override
	public boolean createSale(Sales sales) {
		Row row = new Row("sales");
		row.set("customer_id", sales.getCustomer_id());
		row.set("vehicle_id", sales.getVehicle_id());
		row.set("seller_id", sales.getSeller_id());
		row.set("sale_date", sales.getDate());
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

	@Override
	public List<Sales> getSales() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("sales");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("sales", "*");
			selectQuery.addSelectColumn(customerColumns);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);
			List<Sales> salesList = new ArrayList<>();
			while (dataSet.next()) {
				Sales sales = new Sales();

				try {
					sales.setSales_id(Integer.parseInt(dataSet.getValue("sales_id").toString()));
					sales.setCustomer_id(Integer.parseInt(dataSet.getValue("customer_id").toString()));
					sales.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
					sales.setSeller_id(Integer.parseInt(dataSet.getValue("seller_id").toString()));
					sales.setDate(dataSet.getValue("sale_date").toString());
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				salesList.add(sales);
			}
			return salesList;
		} catch (Exception exception) {
			System.out.println(exception.toString());
		}
		return null;
	}

	@Override
	public Sales getSalesById(int id) {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("sales");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("sales", "*");
			selectQuery.addSelectColumn(customerColumns);

			Criteria criteria = new Criteria(new Column("sales", "sales_id"), id, QueryConstants.EQUAL);
			selectQuery.setCriteria(criteria);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			if (dataSet.next()) {
				Sales sales = new Sales();

				try {
					sales.setSales_id(Integer.parseInt(dataSet.getValue("sales_id").toString()));
					sales.setCustomer_id(Integer.parseInt(dataSet.getValue("customer_id").toString()));
					sales.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
					sales.setSeller_id(Integer.parseInt(dataSet.getValue("seller_id").toString()));
					sales.setDate(dataSet.getValue("sale_date").toString());
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				return sales;
			}
		} catch (Exception exception) {
			System.out.println(exception.toString());
		}
		return null;
	}

	@Override
	public int getLastSalesId() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("sales");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column modelColumns = new Column("sales", "*");
			selectQuery.addSelectColumn(modelColumns);
			SortColumn sortColumn = new SortColumn(Column.getColumn("sales", "sales_id"), false);
			selectQuery.addSortColumn(sortColumn);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			if (dataSet.next()) {
				return Integer.parseInt(dataSet.getValue("sales_id").toString());
			}
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return 0;
	}

}
