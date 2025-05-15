package com.praveen.dto;

public class VehicleSalesBill {
	private int vehicle_id;
	private String manufacturer;
	private String model;
	
	private int customer_id;
	private int sales_id;
	
	private int bill_id;
	private int gst_amount;
	private double total_amount;
	
	private int seller_id;
	private String seller_name;
	private String store_name;
	public int getVehicle_id() {
		return vehicle_id;
	}
	public void setVehicle_id(int vehicle_id) {
		this.vehicle_id = vehicle_id;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	public int getBill_id() {
		return bill_id;
	}
	public void setBill_id(int bill_id) {
		this.bill_id = bill_id;
	}
	public int getGst_amount() {
		return gst_amount;
	}
	public void setGst_amount(int gst_amount) {
		this.gst_amount = gst_amount;
	}
	public double getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(double total_amount) {
		this.total_amount = total_amount;
	}
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public String getSeller_name() {
		return seller_name;
	}
	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	@Override
	public String toString() {
		return "VehicleSalesBill [vehicle_id=" + vehicle_id + ", manufacturer=" + manufacturer + ", model=" + model
				+ ", customer_id=" + customer_id + ", sales_id=" + sales_id + ", bill_id=" + bill_id + ", gst_amount="
				+ gst_amount + ", total_amount=" + total_amount + ", seller_id=" + seller_id + ", seller_name="
				+ seller_name + ", store_name=" + store_name + "]";
	}
	
	
	
}
