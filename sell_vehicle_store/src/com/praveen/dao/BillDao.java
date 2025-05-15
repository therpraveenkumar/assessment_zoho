package com.praveen.dao;

import java.util.List;

import com.praveen.dto.VehicleSalesBill;
import com.praveen.model.Bill;

public interface BillDao {
	boolean createBill(Bill bill);
	List<Bill> getBills();
	Bill getBillById(int id);
	List<VehicleSalesBill> getBillSlips();
}
