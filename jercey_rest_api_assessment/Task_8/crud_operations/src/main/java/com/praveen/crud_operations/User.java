package com.praveen.crud_operations;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class User {
	int user_id;
	String user_name;
	String country;
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_name=" + user_name + ", country=" + country + "]";
	}
	
}
