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
import com.praveen.model.Seller;

public class SellerDaoImpl implements SellerDao{

	@Override
	public boolean createSeller(Seller seller) {
		Row row = new Row("seller");
		row.set("name", seller.getName());
		row.set("email", seller.getEmail());
		row.set("phone", seller.getPhone());
		row.set("address", seller.getAddress());
		row.set("store_name", seller.getStore_name());
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
	public boolean updateName(Seller seller) {
		Criteria criteria = new Criteria(new Column("seller", "seller_id"), seller.getSeller_id(),
				QueryConstants.EQUAL);
		try {
			DataObject dataObject = DataAccess.get("seller", criteria);
			Row row = dataObject.getRow("seller");
			row.set("name", seller.getName());
			dataObject.updateRow(row);
			DataAccess.update(dataObject);
			return true;
		} catch (DataAccessException exception) {
			System.out.println(exception.toString());
		}
		return false;
	}

	@Override
	public List<Seller> getSellers() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("seller");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("seller", "*");
			selectQuery.addSelectColumn(customerColumns);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);
			List<Seller> sellers = new ArrayList<>();
			while (dataSet.next()) {
				Seller seller = new Seller();

				try {
					seller.setSeller_id(Integer.parseInt(dataSet.getValue("seller_id").toString()));
					seller.setName(dataSet.getValue("name").toString());
					seller.setEmail(dataSet.getValue("email").toString());
					seller.setPhone(dataSet.getValue("phone").toString());
					seller.setAddress(dataSet.getValue("address").toString());
					seller.setStore_name(dataSet.getValue("store_name").toString());
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}

				sellers.add(seller);
			}
			return sellers;
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean deleteSeller(Seller seller) {
		Criteria criteria = new Criteria(new Column("seller", "seller_id"), seller.getSeller_id(),
				QueryConstants.EQUAL);

		try {
			DataObject customerDO = DataAccess.get("seller", (Criteria) null);
			customerDO.deleteRows("seller", criteria);
			DataAccess.update(customerDO);
			return true;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return false;
	}

}
