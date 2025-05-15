package com.praveen.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.service.BillService;
import com.praveen.service.SalesService;

@WebServlet("/api/bills/*")
public class BillController extends HttpServlet {
	/**
	 * Method to handle get request
	 * 
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		BillService billService = new BillService();
		if (  pathInfo == null || pathInfo.equals("/")) {

			billService.getBills(req, resp);
		} 
		else if(pathInfo.equals("/getbillslips")){
			billService.getBillSlips(req, resp);
		}
		else {
			billService.getBillById(req, resp);
		}

	}
}
