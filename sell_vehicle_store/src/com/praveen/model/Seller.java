package com.praveen.model;

public class Seller {
	private int seller_id;
	private String name;
	private String email;
	private String phone;
	private String store_name;
	private String address;
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "Seller [seller_id=" + seller_id + ", name=" + name + ", email=" + email + ", phone=" + phone
				+ ", store_name=" + store_name + ", address=" + address + "]";
	}
	
	
}
