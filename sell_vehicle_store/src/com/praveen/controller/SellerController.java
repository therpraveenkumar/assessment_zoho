package com.praveen.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.service.CustomerService;
import com.praveen.service.SellerService;

@WebServlet("/api/sellers/*")
public class SellerController  extends HttpServlet{
	private SellerService sellerService_;
	/**
	 * Method to handle get request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		sellerService_ = new SellerService();
		sellerService_.getSellers(req, resp);
	}
	
	/**
	 * Method to handle post request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/createsaller")) {
			sellerService_ = new SellerService();
			boolean isCreated = sellerService_.createSeller(req, resp);
			if (isCreated) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully user is created\"}");
			} else {
				resp.setContentType("application/json");
				resp.setStatus(400);
				resp.getWriter().write("{\"message\":\"user not create. check params and use unique email and phone\"}");
			}
		}else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid post endpoint\"}");
		}
		
	}
	
	/**
	 * Method to handle delete request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/deletesaller")){
			sellerService_ = new SellerService();
			sellerService_.deleteSeller(req, resp);
		}else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid delete endpoint\"}");
		}
		
	}

	/**
	 * Method to handle put request
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String pathInfo = req.getPathInfo();
		if (pathInfo.startsWith("/updatesaller")){
			sellerService_ = new SellerService();
			sellerService_.updateSeller(req, resp);
		}else {
			resp.setContentType("application/json");
			resp.setStatus(400);
			resp.getWriter().write("{\"error\":\"Invalid put endpoint\"}");
		}
		
	}
}
