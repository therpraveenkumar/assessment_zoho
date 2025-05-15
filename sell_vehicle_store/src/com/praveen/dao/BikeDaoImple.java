package com.praveen.dao;

import java.sql.Connection;
import java.sql.SQLException;

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
import com.praveen.factory.Bike;
import com.praveen.factory.Vehicle;

public class BikeDaoImple extends VehicleDaoImple {

	@Override
	public boolean createVehicle(Vehicle vehicle) {
		if (!(vehicle instanceof Bike)) {
			throw new IllegalArgumentException("Invalid vehicle type for BikeDAO");
		}
		Bike bike = (Bike) vehicle;
		Row row = new Row("vehicle");
		row.set("vehicle_type", bike.getVehicle_type());
		row.set("model", bike.getModel());
		row.set("manufacturer", bike.getManufacturer());
		row.set("color", bike.getColor());
		row.set("issold", bike.getIsSold());
		row.set("price", bike.getPrice());

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
	public Vehicle getLastVehicle() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("vehicle");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column modelColumns = new Column("vehicle", "*");
			selectQuery.addSelectColumn(modelColumns);
			SortColumn sortColumn = new SortColumn(Column.getColumn("vehicle", "vehicle_id"), false);
			selectQuery.addSortColumn(sortColumn);

			Criteria criteria = new Criteria(new Column("vehicle", "vehicle_type"), "bike", QueryConstants.EQUAL);
			selectQuery.setCriteria(criteria);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			if (dataSet.next()) {
				Vehicle bike = new Bike(0, null, null, null, null, 0, 0, 0, null);

				try {
					bike.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				return bike;
			}
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean createAttributes(Vehicle vehicle) {
		Bike bike = (Bike) vehicle;
		Row row = new Row("vehiclespecificattributes");
		row.set("vehicle_id", vehicle.getVehicle_id());
		row.set("attribute_key", "enginecc");
		row.set("attribute_value", bike.getEngineCc());

		Row shifterRow = new Row("vehiclespecificattributes");
		shifterRow.set("vehicle_id", vehicle.getVehicle_id());
		shifterRow.set("attribute_key", "quickshifter");
		shifterRow.set("attribute_value", bike.getQuickShifter());

		DataObject dataObject = new WritableDataObject();
		try {
			dataObject.addRow(row);
			dataObject.addRow(shifterRow);
			DataAccess.add(dataObject);
			return true;
		} catch (DataAccessException e) {
			System.out.println(e.toString());
		}
		return false;
	}

}
