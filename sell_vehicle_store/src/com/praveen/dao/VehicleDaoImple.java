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
import com.praveen.factory.Bike;
import com.praveen.factory.Car;
import com.praveen.factory.Vehicle;

public abstract class VehicleDaoImple implements VehicleDao {
	abstract public boolean createVehicle(Vehicle vehicle);

	abstract public boolean createAttributes(Vehicle vehicle);

	abstract public Vehicle getLastVehicle();

	@Override
	public boolean updateVehiclePrice(Vehicle vehicle) {
		Criteria criteria = new Criteria(new Column("vehicle", "vehicle_id"), vehicle.getVehicle_id(),
				QueryConstants.EQUAL);
		try {
			DataObject dataObject = DataAccess.get("vehicle", criteria);
			Row row = dataObject.getRow("vehicle");
			row.set("price", vehicle.getPrice());
			dataObject.updateRow(row);
			DataAccess.update(dataObject);
			return true;
		} catch (DataAccessException exception) {
			System.out.println(exception.toString());
		}
		return false;
	}
	
	@Override
	public boolean vehicleIsSold(int id){
		Criteria criteria = new Criteria(new Column("vehicle", "vehicle_id"), id,
				QueryConstants.EQUAL);
		try {
			DataObject dataObject = DataAccess.get("vehicle", criteria);
			Row row = dataObject.getRow("vehicle");
			row.set("issold",0);
			dataObject.updateRow(row);
			DataAccess.update(dataObject);
			return true;
		} catch (DataAccessException exception) {
			System.out.println(exception.toString());
		}
		return false;
	}

	@Override
	public boolean deleteVehicle(int id) {
		Criteria criteria = new Criteria(new Column("vehicle", "vehicle_id"), id, QueryConstants.EQUAL);
		Criteria attributeCriteria = new Criteria(new Column("vehiclespecificattributes", "vehicle_id"), id,
				QueryConstants.EQUAL);

		try {
			// delete respective attributes of vehicle
			DataObject attributeDO = DataAccess.get("vehiclespecificattributes", (Criteria) null);
			attributeDO.deleteRows("vehiclespecificattributes", attributeCriteria);
			DataAccess.update(attributeDO);

			// delete vehicle
			DataObject vehicleDO = DataAccess.get("vehicle", (Criteria) null);
			vehicleDO.deleteRows("vehicle", criteria);
			DataAccess.update(vehicleDO);

			return true;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Vehicle> getVehicles() {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("vehicle");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("vehicle", "*");
			selectQuery.addSelectColumn(customerColumns);

			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);
			List<Vehicle> vehicles = new ArrayList<>();
			while (dataSet.next()) {

				try {
					if (dataSet.getValue("vehicle_type").toString().equals("bike")) {

						Bike bike = new Bike(0, null, null, null, null, 0, 0, 0, null);
						bike.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
						bike.setColor(dataSet.getValue("color").toString());
						bike.setManufacturer(dataSet.getValue("manufacturer").toString());
						bike.setModel(dataSet.getValue("model").toString());
						bike.setIsSold(Integer.parseInt(dataSet.getValue("issold").toString()));
						bike.setPrice(Double.parseDouble(dataSet.getValue("price").toString()));
						bike.setVehicle_type(dataSet.getValue("vehicle_type").toString());
						Vehicle vehicle = (Vehicle) bike;

						Table tableAttribute = new Table("vehiclespecificattributes");
						SelectQuery selectQueryAttribute = new SelectQueryImpl(tableAttribute);
						Column attributeColumns = new Column("vehiclespecificattributes", "*");
						selectQueryAttribute.addSelectColumn(attributeColumns);

						Criteria attributeCriteria = new Criteria(new Column("vehiclespecificattributes", "vehicle_id"),
								bike.getVehicle_id(), QueryConstants.EQUAL);
						selectQueryAttribute.setCriteria(attributeCriteria);

						DataSet dataSetAttr = relationalAPI.executeQuery(selectQueryAttribute, connection);
						while (dataSetAttr.next()) {
							if (dataSetAttr.getValue("attribute_key").toString().equals("enginecc")) {
								bike.setEngineCc(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("quickshifter")) {
								bike.setQuickShifter(dataSetAttr.getValue("attribute_value").toString());
							}
						}
						vehicles.add(vehicle);
					} else if (dataSet.getValue("vehicle_type").toString().equals("car")) {
						Car car = new Car(0, null, null, null, null, 0, 0, null, 0, 0, null);
						car.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
						car.setColor(dataSet.getValue("color").toString());
						car.setManufacturer(dataSet.getValue("manufacturer").toString());
						car.setModel(dataSet.getValue("model").toString());
						car.setIsSold(Integer.parseInt(dataSet.getValue("issold").toString()));
						car.setPrice(Double.parseDouble(dataSet.getValue("price").toString()));
						car.setVehicle_type(dataSet.getValue("vehicle_type").toString());
						Vehicle vehicle = (Vehicle) car;

						Table tableAttribute = new Table("vehiclespecificattributes");
						SelectQuery selectQueryAttribute = new SelectQueryImpl(tableAttribute);
						Column attributeColumns = new Column("vehiclespecificattributes", "*");
						selectQueryAttribute.addSelectColumn(attributeColumns);

						Criteria attributeCriteria = new Criteria(new Column("vehiclespecificattributes", "vehicle_id"),
								car.getVehicle_id(), QueryConstants.EQUAL);
						selectQueryAttribute.setCriteria(attributeCriteria);

						DataSet dataSetAttr = relationalAPI.executeQuery(selectQueryAttribute, connection);
						while (dataSetAttr.next()) {
							if (dataSetAttr.getValue("attribute_key").toString().equals("bootspace")) {
								car.setBootSpace(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("seatingcapacity")) {
								car.setBootSpace(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("infotainment")) {
								car.setInfotainment(dataSetAttr.getValue("attribute_value").toString());
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("sunroof")) {
								car.setSunRoof(dataSetAttr.getValue("attribute_value").toString());
							}
						}
						vehicles.add(vehicle);
					}
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			return vehicles;
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Vehicle getVehicleById(int id) {
		RelationalAPI relationalAPI = RelationalAPI.getInstance();
		try (Connection connection = relationalAPI.getConnection()) {
			Table table = new Table("vehicle");
			SelectQuery selectQuery = new SelectQueryImpl(table);
			Column customerColumns = new Column("vehicle", "*");
			selectQuery.addSelectColumn(customerColumns);
			Criteria Criteria = new Criteria(new Column("vehicle", "vehicle_id"), id,
					QueryConstants.EQUAL);
			selectQuery.setCriteria(Criteria);
			DataSet dataSet = relationalAPI.executeQuery(selectQuery, connection);

			if (dataSet.next()) {

				try {
					if (dataSet.getValue("vehicle_type").toString().equals("bike")) {

						Bike bike = new Bike(0, null, null, null, null, 0, 0, 0, null);
						bike.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
						bike.setColor(dataSet.getValue("color").toString());
						bike.setManufacturer(dataSet.getValue("manufacturer").toString());
						bike.setModel(dataSet.getValue("model").toString());
						bike.setIsSold(Integer.parseInt(dataSet.getValue("issold").toString()));
						bike.setPrice(Double.parseDouble(dataSet.getValue("price").toString()));
						bike.setVehicle_type(dataSet.getValue("vehicle_type").toString());
						Vehicle vehicle = (Vehicle) bike;

						Table tableAttribute = new Table("vehiclespecificattributes");
						SelectQuery selectQueryAttribute = new SelectQueryImpl(tableAttribute);
						Column attributeColumns = new Column("vehiclespecificattributes", "*");
						selectQueryAttribute.addSelectColumn(attributeColumns);

						Criteria attributeCriteria = new Criteria(new Column("vehiclespecificattributes", "vehicle_id"),
								bike.getVehicle_id(), QueryConstants.EQUAL);
						selectQueryAttribute.setCriteria(attributeCriteria);

						DataSet dataSetAttr = relationalAPI.executeQuery(selectQueryAttribute, connection);
						while (dataSetAttr.next()) {
							if (dataSetAttr.getValue("attribute_key").toString().equals("enginecc")) {
								bike.setEngineCc(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("quickshifter")) {
								bike.setQuickShifter(dataSetAttr.getValue("attribute_value").toString());
							}
						}
						return vehicle;
					} else if (dataSet.getValue("vehicle_type").toString().equals("car")) {
						Car car = new Car(0, null, null, null, null, 0, 0, null, 0, 0, null);
						car.setVehicle_id(Integer.parseInt(dataSet.getValue("vehicle_id").toString()));
						car.setColor(dataSet.getValue("color").toString());
						car.setManufacturer(dataSet.getValue("manufacturer").toString());
						car.setModel(dataSet.getValue("model").toString());
						car.setIsSold(Integer.parseInt(dataSet.getValue("issold").toString()));
						car.setPrice(Double.parseDouble(dataSet.getValue("price").toString()));
						car.setVehicle_type(dataSet.getValue("vehicle_type").toString());
						Vehicle vehicle = (Vehicle) car;

						Table tableAttribute = new Table("vehiclespecificattributes");
						SelectQuery selectQueryAttribute = new SelectQueryImpl(tableAttribute);
						Column attributeColumns = new Column("vehiclespecificattributes", "*");
						selectQueryAttribute.addSelectColumn(attributeColumns);

						Criteria attributeCriteria = new Criteria(new Column("vehiclespecificattributes", "vehicle_id"),
								car.getVehicle_id(), QueryConstants.EQUAL);
						selectQueryAttribute.setCriteria(attributeCriteria);

						DataSet dataSetAttr = relationalAPI.executeQuery(selectQueryAttribute, connection);
						while (dataSetAttr.next()) {
							if (dataSetAttr.getValue("attribute_key").toString().equals("bootspace")) {
								car.setBootSpace(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("seatingcapacity")) {
								car.setBootSpace(Integer.parseInt(dataSetAttr.getValue("attribute_value").toString()));
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("infotainment")) {
								car.setInfotainment(dataSetAttr.getValue("attribute_value").toString());
							} else if (dataSetAttr.getValue("attribute_key").toString().equals("sunroof")) {
								car.setSunRoof(dataSetAttr.getValue("attribute_value").toString());
							}
						}
						return vehicle;
					}
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException | QueryConstructionException e) {
			e.printStackTrace();
		}
		return null;
	}
}
