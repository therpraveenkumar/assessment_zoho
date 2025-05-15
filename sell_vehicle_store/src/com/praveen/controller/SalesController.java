package com.praveen.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.parser.JsonParse;
import com.praveen.service.SalesService;
import com.praveen.service.SellerService;
import com.praveen.service.VehicleService;

@WebServlet("/api/sales/*")
public class SalesController extends HttpServlet {
	private SalesService SalesService_;

	/**
	 * Method to handle post request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/createsales")) {
			SalesService_ = new SalesService();
			boolean isCreated = SalesService_.createSales(req, resp);
			
			if (isCreated) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully sales is created\"}");
			} else {
				resp.setContentType("application/json");
				resp.setStatus(400);
				resp.getWriter().write("{\"message\":\"sales not create. \"}");
			}
		} else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid post endpoint\"}");
		}
	}

	/**
	 * Method to handle get request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		SalesService_ = new SalesService();
		if (pathInfo.equals("/") || pathInfo == null) {

			SalesService_.getSales(req, resp);
		} else {
			SalesService_.getSalesById(req, resp);
		}

	}
}
