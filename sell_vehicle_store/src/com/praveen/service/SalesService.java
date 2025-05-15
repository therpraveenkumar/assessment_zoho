package com.praveen.service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.dao.BikeDaoImple;
import com.praveen.dao.BillDao;
import com.praveen.dao.BillDaoImpl;
import com.praveen.dao.SalesDao;
import com.praveen.dao.SalesDaoImpl;
import com.praveen.dao.VehicleDaoImple;
import com.praveen.factory.Vehicle;
import com.praveen.model.Bill;
import com.praveen.model.Sales;
import com.praveen.parser.JsonParse;

public class SalesService {
	private SalesDao salesDao_;

	/**
	 * Method to create seller
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	public boolean createSales(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		Sales sales = new Sales();
		if (parsedJson.containsKey("customer_id") && parsedJson.containsKey("seller_id")
				&& parsedJson.containsKey("vehicle_id")) {

			if (parsedJson.get("customer_id").trim().isEmpty())
				return false;
			if (parsedJson.get("seller_id").trim().isEmpty())
				return false;
			if (parsedJson.get("vehicle_id").trim().isEmpty())
				return false;

			sales.setCustomer_id(Integer.parseInt(parsedJson.get("customer_id")));
			sales.setSeller_id(Integer.parseInt(parsedJson.get("seller_id")));
			sales.setVehicle_id(Integer.parseInt(parsedJson.get("vehicle_id")));
			sales.setDate(LocalDate.now().toString());

			salesDao_ = new SalesDaoImpl();
			boolean flag = salesDao_.createSale(sales);

			if (flag) {
				int salesId = salesDao_.getLastSalesId();

				
				VehicleDaoImple vehicleDao_ = new BikeDaoImple();
				Vehicle vehicle = vehicleDao_.getVehicleById(Integer.parseInt(parsedJson.get("vehicle_id")));
				vehicleDao_.vehicleIsSold(vehicle.getVehicle_id());
				
				Bill bill = new Bill();

				int gstAmount = (int)(vehicle.getPrice() * 10) / 100;

				bill.setSales_id(salesId);
				bill.setGst_amount(gstAmount);
				bill.setTotal_amount(gstAmount + vehicle.getPrice());
				
				BillDao billDao = new BillDaoImpl();
				flag = billDao.createBill(bill);
				
				if (flag) {
					flag = billDao.createBill(bill);

				}

			}
			return flag;
		} else {
			resp.setContentType("application/json");
			resp.setStatus(200);
			resp.getWriter().write("{\"message\":\"successfully sales is not created\"}");
			return false;
		}
	}

	public void getSales(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			salesDao_ = new SalesDaoImpl();
			List<Sales> receivedSales = salesDao_.getSales();
			if (receivedSales != null && !receivedSales.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (Sales receivedSale : receivedSales) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"sales_id\":\"" + receivedSale.getSales_id() + "\"");
					resp.getWriter().write("\"customer_id\":\"" + receivedSale.getCustomer_id() + "\",");
					resp.getWriter().write("\"seller_id\":\"" + receivedSale.getSeller_id() + "\",");
					resp.getWriter().write("\"vehicle_id\":\"" + receivedSale.getVehicle_id() + "\",");
					resp.getWriter().write("\"sale_date\":\"" + receivedSale.getDate() + "\"");

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

	public void getSalesById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String pathInfo = req.getPathInfo();
			int id = Integer.parseInt(pathInfo.substring(1));
			salesDao_ = new SalesDaoImpl();
			Sales receivedSale = salesDao_.getSalesById(id);
			if (receivedSale != null) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");

				resp.getWriter().write("{");
				resp.getWriter().write("\"sales_id\":\"" + receivedSale.getSales_id() + "\"");
				resp.getWriter().write("\"customer_id\":\"" + receivedSale.getCustomer_id() + "\",");
				resp.getWriter().write("\"seller_id\":\"" + receivedSale.getSeller_id() + "\",");
				resp.getWriter().write("\"vehicle_id\":\"" + receivedSale.getVehicle_id() + "\",");
				resp.getWriter().write("\"sale_date\":\"" + receivedSale.getDate() + "\"");

				resp.getWriter().write("},");

				resp.getWriter().write("\"}");
				return;
			}

		} catch (Exception e) {
			e.fillInStackTrace();
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"no sales data\"}");
	}
}
