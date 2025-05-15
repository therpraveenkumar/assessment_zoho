/**
 * @title User
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.model;

import java.io.Serializable;
import java.time.LocalDate;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class User implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int userId_;
	private String userName_;
	private String email_;
	private String phoneNumber_;
	private String addressLine_;
	private String state_;
	private String city_;
	private String pincode_;
	private String country_;
	private String userRole_;
	private String hint;
	private String dob;
	private String password;
	

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}
	 

	/**
	 * User constructor
	 */
	public User() {
		// no-arg constructor
	}

	/**
	 * get hint_
	 *
	 * @return String
	 */
	public String getHint() {
		return hint;
	}
//	public String getHint_() {
//		return hint;
//	}

	/**
	 * set hint_
	 */
//	public void setHint(String hint) throws IllegalAccessException {
//		if (hint == null || hint.isEmpty())
//			throw new IllegalAccessException("input should not be non-positive value");
//		this.hint = hint;
//	}
	public void setHint(String hint) throws IllegalAccessException {
		if (hint == null || hint.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.hint = hint;
	}
	
	

	/**
	 * set dob
	 */
	

	public enum currentUserRole {
		customer, admin
	}

	/**
	 * get userId_
	 *
	 * @return int
	 */
	public int getUserId() {
		return userId_;
	}

	/**
	 * set userId_
	 */
	public void setUserId(int userId) throws IllegalAccessException {
		if (userId < 1)
			throw new IllegalAccessException("input should not be non-positive value");
		this.userId_ = userId;
	}

	/**
	 * get userName_
	 *
	 * @return String
	 */
	public String getUserName() {
		return userName_;
	}

	/**
	 * set userName_
	 */
	public void setUserName(String userName) throws IllegalAccessException {
		if (userName == null || userName.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.userName_ = userName;
	}

	/**
	 * get email_
	 *
	 * @return String
	 */
	public String getEmail() {
		return email_;
	}

	/**
	 * set email_
	 */
	public void setEmail(String email) throws IllegalAccessException {
		if (email == null || email.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.email_ = email;
	}

	/**
	 * get phoneNumber_
	 *
	 * @return String
	 */
	public String getPhoneNumber() {
		return phoneNumber_;
	}

	/**
	 * set phoneNumber_
	 */
	public void setPhoneNumber(String phoneNumber) throws IllegalAccessException {
		if (phoneNumber == null || phoneNumber.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.phoneNumber_ = phoneNumber;
	}

	/**
	 * get addressLine_
	 *
	 * @return String
	 */
	public String getAddressLine() {
		return addressLine_;
	}

	/**
	 * set addressLine_
	 */
	public void setAddressLine(String addressLine) throws IllegalAccessException {
		if (addressLine == null || addressLine.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.addressLine_ = addressLine;
	}

	/**
	 * get state_
	 *
	 * @return String
	 */
	public String getState() {
		return state_;
	}

	/**
	 * set state_
	 */
	public void setState(String state) throws IllegalAccessException {
		if (state == null || state.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.state_ = state;
	}

	/**
	 * get city_
	 *
	 * @return String
	 */
	public String getCity() {
		return city_;
	}

	/**
	 * set city_
	 */
	public void setCity(String city) throws IllegalAccessException {
		if (city == null || city.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.city_ = city;
	}

	/**
	 * get pincode_
	 *
	 * @return String
	 */
	public String getPincode() {
		return pincode_;
	}

	/**
	 * set pinCode
	 */
	public void setPincode(String pincode) throws IllegalAccessException {
		if (pincode == null || pincode.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.pincode_ = pincode;
	}

	/**
	 * get userRole_
	 *
	 * @return String
	 */
	public String getUserRole() {
		return userRole_;
	}

	/**
	 * set userRole_
	 */
	public void setUserRole(String userRole) throws IllegalAccessException {
		
		this.userRole_ = userRole;
	}

	/**
	 * get country_
	 *
	 * @return String
	 */
	public String getCountry() {
		return country_;
	}

	/**
	 * set country_
	 */
	public void setCountry(String country) throws IllegalAccessException {
		if (country == null || country.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.country_ = country;
	}
	
	public String getDob() {
		return dob;
	}

	/**
	 * set dob
	 */
	public void setDob(String dob) throws IllegalAccessException {
		if (dob == null || dob.isEmpty())
			throw new IllegalAccessException("null or empty value is not accepted");
		this.dob = dob;
	}
//
//	/**
//	 * get DOB
//	 *
//	 * @return Date
//	 */
//	 public String getDob_() {
//	 return dob;
//	 }
//	
//	 /**
//	 * set DOB
//	 */
//	 public void setDob(String dob) {
//	 this.dob = dob;
//	 }

	/**
	 * override toString method
	 *
	 * @return String
	 */
	@Override
	public String toString() {
		return "-> user id->" + userId_ + " userName-> " + userName_ + " DOB-> "+dob + " email-> " + email_ + " phNumber-> "
				+ phoneNumber_ + " Address-> " + addressLine_ + " State-> " + state_ + " City-> " + city_
				+ " Pin code-> " + pincode_ + " Country-> " + country_ + " hint-> " + hint;
	}
}
