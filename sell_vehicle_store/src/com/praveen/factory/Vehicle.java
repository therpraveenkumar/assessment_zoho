package com.praveen.factory;

public abstract class Vehicle {
	private int vehicle_id;
	private String vehicle_type;
	private String model;
    private String color;
    private String manufacturer;
    private int isSold;
    private double price;
    
    public Vehicle(int vehicleId, String vehicleType,String model, String color,String manufacturer,int isSold, double price) {
        this.vehicle_id=vehicleId;
        this.vehicle_type=vehicleType;
    	this.model = model;
        this.color = color;
        this.manufacturer=manufacturer;
        this.isSold=isSold;
        this.price = price;
    }
    
	public int getVehicle_id() {
		return vehicle_id;
	}
	public void setVehicle_id(int vehicle_id) {
		this.vehicle_id = vehicle_id;
	}
	public String getVehicle_type() {
		return vehicle_type;
	}
	public void setVehicle_type(String vehicle_type) {
		this.vehicle_type = vehicle_type;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public int getIsSold() {
		return isSold;
	}
	public void setIsSold(int isSold) {
		this.isSold = isSold;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "Vehicle [vehicle_id=" + vehicle_id + ", vehicle_type=" + vehicle_type + ", model=" + model + ", color="
				+ color + ", manufacturer=" + manufacturer + ", isSold=" + isSold + ", price=" + price + "]";
	}
}
