/**
 * @title Order
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.model;

import java.io.Serializable;
import java.time.OffsetDateTime;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Order implements Serializable {
    private int orderId_;
    private int userId_;
    private double totalAmount_;

    private String orderDate_;
    private String orderStatus_;


    enum enumOrderStatus {
        pending,
        completed,
        canceled
    }

    /**
     * Order constructor
     */
    public Order() {
        //no-arg constructor
    }

    /**
     * get orderId_
     *
     * @return orderId_
     */
    public int getOrderId() {
        return orderId_;
    }

    /**
     * set orderId_
     */
    public void setOrderId(int orderId) throws IllegalAccessException {
        if (orderId < 1)
            throw new IllegalAccessException("id should not be non-positive value");
        this.orderId_ = orderId;
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
            throw new IllegalAccessException("id should not be non-positive value");
        this.userId_ = userId;
    }

    /**
     * get totalAmount_
     *
     * @return double
     */
    public double getTotalAmount() {
        return totalAmount_;
    }

    /**
     * set totalAmount_
     */
    public void setTotalAmount(double totalAmount) throws IllegalAccessException {
        if (totalAmount < 1)
            throw new IllegalAccessException("amount should not be non-positive value");
        this.totalAmount_ = totalAmount;
    }

    /**
     * get orderDate_
     *
     * @return orderDate_
     */
    public String getOrderDate() {
        return orderDate_;
    }

    /**
     * set orderDate_
     */
    public void setOrderDate(String orderDate) throws IllegalAccessException {
        if (orderDate == null)
            throw new IllegalAccessException("null value is not accepted");
        this.orderDate_ = orderDate;
    }

    /**
     * get orderStatus_
     *
     * @return orderStatus_
     */
    public String getOrderStatus() {
        return orderStatus_;
    }

    /**
     * set orderStatus_
     */
    public void setOrderStatus(String orderStatus) throws IllegalAccessException {
        if (orderStatus == null || orderStatus.isEmpty())
            throw new IllegalAccessException("null or empty value is not accepted");
        try {
            this.orderStatus_ = orderStatus;
        } catch (Exception exception) {
            throw new IllegalAccessException("invalid value");
        }
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "order id:" + orderId_ + " order created:" + orderDate_ + " Total amount: " + totalAmount_ + " Status: " + orderStatus_;
    }

}
