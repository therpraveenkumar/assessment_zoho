package com.praveen.factory;

public class Bike extends Vehicle {
	private int engineCc;
	private String quickShifter;

	public Bike(int vehicleId, String vehicleType, String model, String color, String manufacturer, int isSold,
			double price, int engineCc, String quickShifter) {
		super(vehicleId, vehicleType, model, color, manufacturer, isSold, price);
		this.engineCc = engineCc;
		this.quickShifter = quickShifter;
	}

	public int getEngineCc() {
		return engineCc;
	}

	public void setEngineCc(int engineCc) {
		this.engineCc = engineCc;
	}

	public String getQuickShifter() {
		return quickShifter;
	}

	public void setQuickShifter(String quickShifter) {
		this.quickShifter = quickShifter;
	}

	@Override
	public String toString() {
		return "Bike [engineCc=" + engineCc + ", quickShifter=" + quickShifter + "]";
	}
	
	

}
