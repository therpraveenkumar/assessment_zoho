package com.praveen.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.dao.BillDao;
import com.praveen.dao.BillDaoImpl;
import com.praveen.dao.SalesDao;
import com.praveen.dao.SalesDaoImpl;
import com.praveen.dto.VehicleSalesBill;
import com.praveen.model.Bill;
import com.praveen.model.Sales;

public class BillService {
	private BillDao BillDao_;

	public void getBills(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BillDao_ = new BillDaoImpl();
			List<Bill> receivedBills = BillDao_.getBills();
			if (receivedBills != null && !receivedBills.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (Bill receivedBill : receivedBills) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"bill_id\":\"" + receivedBill.getBill_id() + "\"");
					resp.getWriter().write("\"gst_amount\":\"" + receivedBill.getGst_amount() + "\",");
					resp.getWriter().write("\"total_amount\":\"" + receivedBill.getTotal_amount() + "\",");
					resp.getWriter().write("\"sales_id\":\"" + receivedBill.getSales_id() + "\"");

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

	public void getBillById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String pathInfo = req.getPathInfo();
			int id = Integer.parseInt(pathInfo.substring(1));
			BillDao_ = new BillDaoImpl();
			Bill receivedBill = BillDao_.getBillById(id);
			if (receivedBill != null) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");

				resp.getWriter().write("{");
				resp.getWriter().write("\"bill_id\":\"" + receivedBill.getBill_id() + "\"");
				resp.getWriter().write("\"gst_amount\":\"" + receivedBill.getGst_amount() + "\",");
				resp.getWriter().write("\"total_amount\":\"" + receivedBill.getTotal_amount() + "\",");
				resp.getWriter().write("\"sales_id\":\"" + receivedBill.getSales_id() + "\"");

				resp.getWriter().write("}");

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

	public void getBillSlips(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BillDao_ = new BillDaoImpl();
			List<VehicleSalesBill> receivedBills = BillDao_.getBillSlips();
			if (receivedBills != null && !receivedBills.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (VehicleSalesBill receivedBill : receivedBills) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"bill_id\":\"" + receivedBill.getBill_id() + "\",");
					resp.getWriter().write("\"seller_id\":\"" + receivedBill.getSeller_id() + "\",");
					resp.getWriter().write("\"customer_id\":\"" + receivedBill.getCustomer_id() + "\",");
					resp.getWriter().write("\"vehicle_id\":\"" + receivedBill.getVehicle_id() + "\",");
					resp.getWriter().write("\"sales_id\":\"" + receivedBill.getSales_id() + "\"");
					resp.getWriter().write("\"model\":\"" + receivedBill.getModel() + "\",");
					resp.getWriter().write("\"manufacturer\":\"" + receivedBill.getManufacturer() + "\",");
					resp.getWriter().write("\"seller_name\":\"" + receivedBill.getSeller_name() + "\",");
					resp.getWriter().write("\"store_name\":\"" + receivedBill.getStore_name() + "\",");
					resp.getWriter().write("\"gst_amount\":\"" + receivedBill.getGst_amount() + "\",");
					resp.getWriter().write("\"total_amount\":\"" + receivedBill.getTotal_amount() + "\"");

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
}
