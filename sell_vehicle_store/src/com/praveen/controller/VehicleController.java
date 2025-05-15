package com.praveen.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.service.VehicleService;

@WebServlet("/api/vehicles/*")
public class VehicleController extends HttpServlet {
	private VehicleService vehicleService_;

	/**
	 * Method to handle get request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		vehicleService_ = new VehicleService();
		if (pathInfo.equals("/")||pathInfo == null ) {

			vehicleService_.getVehicles(req, resp);
		} else {

			vehicleService_.getVehiclesById(req, resp);
		}

	}

	/**
	 * Method to handle post request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		vehicleService_ = new VehicleService();
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/createvehicle")) {
			boolean isCreated = vehicleService_.createVehicle(req, resp);
			if (isCreated) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully vehicle is created\"}");
			} else {
				resp.setContentType("application/json");
				resp.setStatus(400);
				resp.getWriter().write("{\"message\":\"vehicle not create\"}");
			}
		} else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid post endpoint\"}");
		}
	}

	/**
	 * Method to handle delete request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/deletevehicle")) {
			vehicleService_ = new VehicleService();
			vehicleService_.deleteVehicle(req, resp);
		} else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid delete endpoint\"}");
		}

	}

	/**
	 * Method to handle put request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/updatevehicle")) {
			vehicleService_ = new VehicleService();
			vehicleService_.updateVehicle(req, resp);
		} else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid put endpoint\"}");
		}

	}
}
