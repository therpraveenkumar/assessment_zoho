package com.praveen.dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.adventnet.db.api.RelationalAPI;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.DataSet;
import com.adventnet.ds.query.Join;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.SelectQuery;
import com.adventnet.ds.query.SelectQueryImpl;
import com.adventnet.ds.query.Table;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.praveen.dto.VehicleSalesBill;
import com.praveen.model.Bill;

public class BillDaoImpl implements BillDao {

	@Override
	public boolean createBill(Bill bill) {
		Row row = new Row("bill");
		row.set("sales_id", bill.getSales_id());
		row.set("gst_amount", bill.getGst_amount());
		row.set("total_amount", bill.getTotal_amount());
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
	public List<Bill> getBills() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("bill");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("bill", "*");
			selectQuery.addSelectColumn(customerColumns);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);
			List<Bill> bills = new ArrayList<>();
			while (dataSet.next()) {
				Bill bill = new Bill();

				try {
					bill.setBill_id(Integer.parseInt(dataSet.getValue("bill_id").toString()));
					bill.setSales_id(Integer.parseInt(dataSet.getValue("sales_id").toString()));
					bill.setGst_amount(Integer.parseInt(dataSet.getValue("gst_amount").toString()));
					bill.setTotal_amount(Double.parseDouble(dataSet.getValue("total_amount").toString()));

				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				bills.add(bill);
			}
			return bills;
		} catch (Exception exception) {
			System.out.println(exception.toString());
		}
		return null;
	}

	@Override
	public Bill getBillById(int id) {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("bill");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("bill", "*");
			selectQuery.addSelectColumn(customerColumns);

			Criteria criteria = new Criteria(new Column("bill", "bill_id"), id, QueryConstants.EQUAL);
			selectQuery.setCriteria(criteria);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			if (dataSet.next()) {
				Bill bill = new Bill();

				try {
					bill.setBill_id(Integer.parseInt(dataSet.getValue("bill_id").toString()));
					bill.setSales_id(Integer.parseInt(dataSet.getValue("sales_id").toString()));
					bill.setGst_amount(Integer.parseInt(dataSet.getValue("gst_amount").toString()));
					bill.setTotal_amount(Double.parseDouble(dataSet.getValue("total_amount").toString()));

				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				return bill;
			}
		} catch (Exception exception) {
			System.out.println(exception.toString());
		}
		return null;
	}

	@Override
	public List<VehicleSalesBill> getBillSlips() {
		List<VehicleSalesBill> listOfSlips = new ArrayList<>();
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection();) {
			Table table = new Table("bill");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column billColumns = new Column("bill", "*");
			Column salesColumns = new Column("sales", "*");
			Column vehicleColumns = new Column("vehicle", "*");
			Column sellerColumns = new Column("seller", "*");

			List<Column> columnsList = new ArrayList<>();
			columnsList.add(billColumns);
			columnsList.add(salesColumns);
			columnsList.add(vehicleColumns);
			columnsList.add(sellerColumns);

			selectQuery.addSelectColumns(columnsList);

			Join joinBillSales = new Join("bill", "sales", new String[] { "sales_id" }, new String[] { "sales_id" },
					Join.LEFT_JOIN);
			selectQuery.addJoin(joinBillSales);
			Join joinSalesVehicle = new Join("sales", "vehicle", new String[] { "vehicle_id" },
					new String[] { "vehicle_id" }, Join.LEFT_JOIN);
			selectQuery.addJoin(joinSalesVehicle);
			Join joinSalesSeller = new Join("sales", "seller", new String[] { "seller_id" },
					new String[] { "seller_id" }, Join.LEFT_JOIN);
			selectQuery.addJoin(joinSalesSeller);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			while (dataSet.next()) {
				VehicleSalesBill vehicleSalesBill = new VehicleSalesBill();
				vehicleSalesBill.setBill_id(Integer.parseInt(dataSet.getValue(1).toString()));
				vehicleSalesBill.setVehicle_id(Integer.parseInt(dataSet.getValue(8).toString()));
				vehicleSalesBill.setCustomer_id(Integer.parseInt(dataSet.getValue(6).toString()));
				vehicleSalesBill.setGst_amount(Integer.parseInt(dataSet.getValue(3).toString()));
				vehicleSalesBill.setTotal_amount(Double.parseDouble(dataSet.getValue(4).toString()));
				vehicleSalesBill.setManufacturer(dataSet.getValue(13).toString());
				vehicleSalesBill.setModel(dataSet.getValue(12).toString());
				vehicleSalesBill.setSeller_name(dataSet.getValue(18).toString());
				vehicleSalesBill.setStore_name(dataSet.getValue(21).toString());
				vehicleSalesBill.setSales_id(Integer.parseInt(dataSet.getValue(2).toString()));
				vehicleSalesBill.setSeller_id(Integer.parseInt(dataSet.getValue(7).toString()));

				listOfSlips.add(vehicleSalesBill);
			}
		} catch (Exception exception) {
			System.out.println(exception.toString());
		}

		return listOfSlips;
	}
}
