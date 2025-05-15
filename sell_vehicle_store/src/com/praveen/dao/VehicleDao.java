package com.praveen.dao;

import java.util.List;

import com.praveen.factory.Vehicle;

public interface VehicleDao {
	List<Vehicle> getVehicles();
	Vehicle getVehicleById(int id);
	boolean updateVehiclePrice(Vehicle vehicle);
	boolean deleteVehicle(int id);
	boolean vehicleIsSold(int id);
}

