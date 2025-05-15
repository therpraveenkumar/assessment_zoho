package com.praveen.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.praveen.dao.SellerDao;
import com.praveen.dao.SellerDaoImpl;
import com.praveen.model.Seller;
import com.praveen.parser.JsonParse;

public class SellerService {
	private SellerDao sellerDao_;
	/**
	 * Method to create seller
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public boolean createSeller(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		Seller seller = new Seller();
		if (parsedJson.containsKey("name") && parsedJson.containsKey("email") && parsedJson.containsKey("phone")&& parsedJson.containsKey("address")&&parsedJson.containsKey("store_name")) {
			if (parsedJson.get("name").trim().isEmpty())
				return false;
			if (parsedJson.get("email").trim().isEmpty())
				return false;
			if (parsedJson.get("phone").trim().length() != 10)
				return false;

			seller.setName(parsedJson.get("name"));
			seller.setEmail(parsedJson.get("email"));
			seller.setPhone(parsedJson.get("phone"));
			seller.setAddress(parsedJson.get("address"));
			seller.setStore_name(parsedJson.get("store_name"));
			sellerDao_ = new SellerDaoImpl();
			return sellerDao_.createSeller(seller);
		} else {
			return false;
		}
	}
	
	
	/**
	 * Method to get seller
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void getSellers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			sellerDao_ = new SellerDaoImpl();
			List<Seller> receivedSellers = sellerDao_.getSellers();
			if (receivedSellers != null && !receivedSellers.isEmpty()) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"");
				for (Seller receivedSeller : receivedSellers) {
					resp.getWriter().write("{");
					resp.getWriter().write("\"seller_id\":\"" + receivedSeller.getSeller_id() + "\"");
					resp.getWriter().write("\"name\":\"" + receivedSeller.getName() + "\",");
					resp.getWriter().write("\"email\":\"" + receivedSeller.getEmail() + "\",");
					resp.getWriter().write("\"phone\":\"" + receivedSeller.getPhone() + "\",");
					resp.getWriter().write("\"address\":\"" + receivedSeller.getAddress() + "\",");
					resp.getWriter().write("\"store_name\":\"" + receivedSeller.getStore_name() + "\"");
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
		resp.getWriter().write("{\"message\":\"no sellers\"}");
	}

	/**
	 * Method to delete seller
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void deleteSeller(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		sellerDao_ = new SellerDaoImpl();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);

		Seller seller = new Seller();
		if(parsedJson.containsKey("seller_id")){
			seller.setSeller_id(Integer.parseInt(parsedJson.get("seller_id")));
			boolean isDeleted = sellerDao_.deleteSeller(seller);
			if (isDeleted) {
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"successfully seller is removed\"}");
				return;
			} 
		}
		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"seller not removed\"}");
	}

	/**
	 * Method to update seller
	 * @param HttpServeltRequest
	 * @param HttpServletResponse
	 * */
	public void updateSeller(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		sellerDao_ = new SellerDaoImpl();
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		Map<String, String> parsedJson = JsonParse.parseJson(body);
		
		if (parsedJson.containsKey("seller_id") && parsedJson.containsKey("name")) {
			Seller seller = new Seller();
			seller.setSeller_id(Integer.parseInt(parsedJson.get("seller_id")));
			seller.setName(parsedJson.get("name"));
			boolean isupdated = sellerDao_.updateName(seller);
			if(isupdated){
				resp.setContentType("application/json");
				resp.setStatus(200);
				resp.getWriter().write("{\"message\":\"seller name is updated\"}");
				return;
			}
		}

		resp.setContentType("application/json");
		resp.setStatus(400);
		resp.getWriter().write("{\"message\":\"seller name is not updated\"}");
	}
}
