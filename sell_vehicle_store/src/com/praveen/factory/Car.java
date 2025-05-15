package com.praveen.factory;

public class Car extends Vehicle {
	private String sunRoof;
	private int seatingCapacity;
	private int bootSpace;
	private String infotainment;

	public Car(int vehicleId, String vehicleType, String model, String color, String manufacturer, int isSold,
			double price, String sunRoof, int seatingCapacity, int bootSpace, String infotainment) {
		super(vehicleId, vehicleType, model, color, manufacturer, isSold, price);
		this.sunRoof = sunRoof;
		this.seatingCapacity = seatingCapacity;
		this.bootSpace = bootSpace;
		this.infotainment = infotainment;
	}

	public String getSunRoof() {
		return sunRoof;
	}

	public void setSunRoof(String sunRoof) {
		this.sunRoof = sunRoof;
	}

	public int getSeatingCapacity() {
		return seatingCapacity;
	}

	public void setSeatingCapacity(int seatingCapacity) {
		this.seatingCapacity = seatingCapacity;
	}

	public int getBootSpace() {
		return bootSpace;
	}

	public void setBootSpace(int bootSpace) {
		this.bootSpace = bootSpace;
	}

	public String getInfotainment() {
		return infotainment;
	}

	public void setInfotainment(String infotainment) {
		this.infotainment = infotainment;
	}

}
