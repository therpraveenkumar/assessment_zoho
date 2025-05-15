package com.praveen.model;

public class Bill {
	private int bill_id;
	private int sales_id;
	private int gst_amount;
	private double total_amount;
	public int getBill_id() {
		return bill_id;
	}
	public void setBill_id(int bill_id) {
		this.bill_id = bill_id;
	}
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
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
	@Override
	public String toString() {
		return "Bill [bill_id=" + bill_id + ", sales_id=" + sales_id + ", gst_amount=" + gst_amount + ", total_amount="
				+ total_amount + "]";
	}
}
