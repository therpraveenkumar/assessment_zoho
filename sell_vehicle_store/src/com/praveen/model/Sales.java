package com.praveen.model;

public class Sales {
	private int sales_id;
	private int seller_id;
	private int customer_id;
	private int vehicle_id;
	private String date;
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getVehicle_id() {
		return vehicle_id;
	}
	public void setVehicle_id(int vehicle_id) {
		this.vehicle_id = vehicle_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Sales [sales_id=" + sales_id + ", seller_id=" + seller_id + ", customer_id=" + customer_id
				+ ", vehicle_id=" + vehicle_id + ", date=" + date + "]";
	}
	
	
	
}
