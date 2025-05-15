package com.praveen.dao;

import java.util.List;

import com.praveen.model.Seller;

public interface SellerDao {
	boolean createSeller(Seller seller);
	boolean updateName(Seller seller);
	List<Seller> getSellers();
	boolean deleteSeller(Seller seller);
}
