package com.praveen.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.dao.BikeDaoImple;
import com.praveen.dao.CarDaoImple;
import com.praveen.dao.SellerDaoImpl;
import com.praveen.dao.VehicleDaoImple;
import com.praveen.factory.Bike;
import com.praveen.factory.Car;
import com.praveen.factory.Vehicle;
import com.praveen.model.Seller;
import com.praveen.parser.JsonParse;

public class VehicleService {
	private VehicleDaoImple vehicleDao_;

	/**
	 * Method to create vehicle
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public boolean createVehicle(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		if (parsedJson.containsKey("vehicle_type") && parsedJson.containsKey("model") && parsedJson.containsKey("color")
				&& parsedJson.containsKey("manufacturer") && parsedJson.containsKey("price")) {
			if (parsedJson.get("vehicle_type").trim().equals("bike") && parsedJson.containsKey("quickshifter")
					&& parsedJson.containsKey("enginecc")) {

				Vehicle bike = new Bike(0, parsedJson.get("vehicle_type"), parsedJson.get("model"),
						parsedJson.get("color"), parsedJson.get("manufacturer"), 1,
						Double.parseDouble(parsedJson.get("price")), Integer.parseInt(parsedJson.get("enginecc")),
						parsedJson.get("quickshifter"));

				vehicleDao_ = new BikeDaoImple();
				boolean flag = vehicleDao_.createVehicle(bike);

				if (flag) {
					Vehicle lastAddedBike = (Bike) vehicleDao_.getLastVehicle();
					if (lastAddedBike != null) {
						bike.setVehicle_id(lastAddedBike.getVehicle_id());
						vehicleDao_.createAttributes(bike);
					} else {
						flag = false;
					}
				}
				return flag;

			} else if (parsedJson.get("vehicle_type").trim().equals("car") && parsedJson.containsKey("sunroof")
					&& parsedJson.containsKey("seatingcapacity") && parsedJson.containsKey("bootspace")
					&& parsedJson.containsKey("infotainment")) {

				Vehicle car = new Car(0, parsedJson.get("vehicle_type"), parsedJson.get("model"),
						parsedJson.get("color"), parsedJson.get("manufacturer"), 1,
						Double.parseDouble(parsedJson.get("price")), parsedJson.get("sunroof"),
						Integer.parseInt(parsedJson.get("seatingcapacity")),
						Integer.parseInt(parsedJson.get("bootspace")), parsedJson.get("infotainment"));
				vehicleDao_ = new CarDaoImple();
				boolean flag = vehicleDao_.createVehicle(car);
				if (flag) {
					Vehicle lastAddedBike = (Bike) vehicleDao_.getLastVehicle();
					if (lastAddedBike != null) {
						car.setVehicle_id(lastAddedBike.getVehicle_id());
						vehicleDao_.createAttributes(car);
					} else {
						flag = false;
					}
				}
				return flag;
			}
		}
		return false;
	}

	/**
	 * Method to delete vehicle
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public void deleteVehicle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		vehicleDao_ = new BikeDaoImple();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		if (parsedJson.containsKey("vehicle_id")) {

			boolean isDeleted = vehicleDao_.deleteVehicle(Integer.parseInt(parsedJson.get("vehicle_id")));
			if (isDeleted) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully vehicle is removed\"}");
				return;
			}
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"vehicle not removed\"}");
	}

	/**
	 * Method to update seller
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public void updateVehicle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		vehicleDao_ = new BikeDaoImple();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		if (parsedJson.containsKey("vehicle_id") && parsedJson.containsKey("price")) {
			Vehicle vehicle = new Bike(0, null, null, null, null, 0, 0, 0, null);
			vehicle.setVehicle_id(Integer.parseInt(parsedJson.get("vehicle_id")));
			vehicle.setPrice(Double.parseDouble(parsedJson.get("price")));
			boolean isupdated = vehicleDao_.updateVehiclePrice(vehicle);
			if (isupdated) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"vehicle price is updated\"}");
				return;
			}
		}

		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"vehicle price is not updated\"}");
	}

	/**
	 * Method to get vehicles
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public void getVehicles(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			vehicleDao_ = new BikeDaoImple();
			List<Vehicle> receivedVehicles = vehicleDao_.getVehicles();
			if (receivedVehicles != null && !receivedVehicles.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (Vehicle receivedVehicle : receivedVehicles) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"vehicle_id\":\"" + receivedVehicle.getVehicle_id() + "\"");
					resp.getWriter().write("\"model\":\"" + receivedVehicle.getModel() + "\",");
					resp.getWriter().write("\"color\":\"" + receivedVehicle.getColor() + "\",");
					resp.getWriter().write("\"manufacturer\":\"" + receivedVehicle.getManufacturer() + "\",");
					resp.getWriter().write("\"Price\":\"" + receivedVehicle.getPrice() + "\",");
					resp.getWriter().write("\"isSold\":\"" + receivedVehicle.getIsSold() + "\",");
					resp.getWriter().write("\"vehicle_type\":\"" + receivedVehicle.getVehicle_type() + "\",");
					if (receivedVehicle instanceof Bike) {
						Bike bike = (Bike) receivedVehicle;
						resp.getWriter().write("\"enginecc\":\"" + bike.getEngineCc() + "\",");
						resp.getWriter().write("\"quickshifter\":\"" + bike.getQuickShifter() + "\"");
					} else if (receivedVehicle instanceof Car) {
						Car car = (Car) receivedVehicle;
						resp.getWriter().write("\"sunroof\":\"" + car.getSunRoof() + "\",");
						resp.getWriter().write("\"seatingcapacity\":\"" + car.getSeatingCapacity() + "\",");
						resp.getWriter().write("\"bootspace\":\"" + car.getBootSpace() + "\",");
						resp.getWriter().write("\"infotainment\":\"" + car.getInfotainment() + "\"");
					}
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
		resp.getWriter().write("{\"message\":\"no vehicles\"}");
	}

	/**
	 * Method to get vehicles
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public void getVehiclesById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			vehicleDao_ = new BikeDaoImple();
			String pathInfo = req.getPathInfo();
			int id = Integer.parseInt(pathInfo.substring(1));
			Vehicle receivedVehicle = vehicleDao_.getVehicleById(id);
			if (receivedVehicle != null) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");

				resp.getWriter().write("{");
				resp.getWriter().write("\"vehicle_id\":\"" + receivedVehicle.getVehicle_id() + "\"");
				resp.getWriter().write("\"model\":\"" + receivedVehicle.getModel() + "\",");
				resp.getWriter().write("\"color\":\"" + receivedVehicle.getColor() + "\",");
				resp.getWriter().write("\"manufacturer\":\"" + receivedVehicle.getManufacturer() + "\",");
				resp.getWriter().write("\"Price\":\"" + receivedVehicle.getPrice() + "\",");
				resp.getWriter().write("\"isSold\":\"" + receivedVehicle.getIsSold() + "\",");
				resp.getWriter().write("\"vehicle_type\":\"" + receivedVehicle.getVehicle_type() + "\",");
				if (receivedVehicle instanceof Bike) {
					Bike bike = (Bike) receivedVehicle;
					resp.getWriter().write("\"enginecc\":\"" + bike.getEngineCc() + "\",");
					resp.getWriter().write("\"quickshifter\":\"" + bike.getQuickShifter() + "\"");
				} else if (receivedVehicle instanceof Car) {
					Car car = (Car) receivedVehicle;
					resp.getWriter().write("\"sunroof\":\"" + car.getSunRoof() + "\",");
					resp.getWriter().write("\"seatingcapacity\":\"" + car.getSeatingCapacity() + "\",");
					resp.getWriter().write("\"bootspace\":\"" + car.getBootSpace() + "\",");
					resp.getWriter().write("\"infotainment\":\"" + car.getInfotainment() + "\"");
				}
				resp.getWriter().write("},");

				resp.getWriter().write("\"}");
				return;
			}

		} catch (Exception e) {
			e.fillInStackTrace();
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"no vehicles\"}");
	}
}
