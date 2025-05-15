/**
 * @title Payment
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.crud_operations;

import java.io.Serializable;
import java.time.OffsetDateTime;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Payment implements Serializable {
    private int paymentId_;
    private int orderId_;
    private String paymentDate_;
    private String paymentMethod_;
    private String paymentStatus_;

    /**
     * Payment constructor
     */
    public Payment() {
        //no-arg constructor
    }

    enum paymentMethods {
        UPI,
        COD
    }

    enum enumPaymentStatus {
        pending,
        completed
    }

    /**
     * get paymentId_
     *
     * @return int
     */
    public int getPaymentId() {
        return paymentId_;
    }

    /**
     * set paymentId_
     */
    public void setPaymentId(int paymentId) throws IllegalAccessException {
        if (paymentId < 1)
            throw new IllegalAccessException("id should not be non-positive value");
        this.paymentId_ = paymentId;
    }

    /**
     * get orderId_
     *
     * @return int
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
     * get paymentDate_
     *
     * @return ZonedDateTime
     */
    public String getPaymentDate() {
        return paymentDate_;
    }

    /**
     * set paymentDate_
     */
    public void setPaymentDate(String paymentDate) throws IllegalAccessException {
        if (paymentDate == null)
            throw new IllegalAccessException("null value is not accepted");
        this.paymentDate_ = paymentDate;
    }

    /**
     * get paymentMethod_
     *
     * @return paymentMethods
     */
    public String getPaymentMethod() {
        return paymentMethod_;
    }

    /**
     * set paymentMethod_
     */
    public void setPaymentMethod(String paymentMethod) throws IllegalAccessException {
        if (paymentMethod == null)
            throw new IllegalAccessException("null value is not accepted");
        this.paymentMethod_ = paymentMethod;
    }

    /**
     * get paymentStatus-
     */
    public String getPaymentStatus() {
        return paymentStatus_;
    }

    /**
     * set paymentStatus_
     */
    public void setPaymentStatus(String paymentStatus) throws IllegalAccessException {
        if (paymentStatus == null)
            throw new IllegalAccessException("null value is not accepted");
        this.paymentStatus_ = paymentStatus;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "payment id:" + paymentId_ + " Payment method: " + paymentMethod_ + " payment status: " + paymentStatus_ + " date:" + paymentDate_+"order id: "+orderId_;
    }
}
