/**
 * @title Payment
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.model;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class OrderItem implements Serializable {
    private int orderItemId_;
    private int orderId_;
    private int productId_;
    private int quantity_;
    private double price_;

    /**
     * OrderItem constructor
     */
    public OrderItem() {
        //no-arg constructor
    }

    /**
     * get orderItemId_
     *
     * @return int
     */
    public int getOrderItemId() {
        return orderItemId_;
    }

    /**
     * set orderItemId_
     */
    public void setOrderItemId(int orderItemId) throws IllegalAccessException {
        if (orderItemId < 1)
            throw new IllegalAccessException("id should not be non-positive value");
        this.orderItemId_ = orderItemId;
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
     * get productId_
     *
     * @return int
     */
    public int getProductId() {
        return productId_;
    }

    /**
     * set productId_
     */
    public void setProductId(int productId) throws IllegalAccessException {
        if (productId < 1)
            throw new IllegalAccessException("id should not be non-positive value");
        this.productId_ = productId;
    }

    /**
     * get quantity_
     *
     * @return int
     */
    public int getQuantity() {
        return quantity_;
    }

    /**
     * set quantity_
     */
    public void setQuantity(int quantity) throws IllegalAccessException {
        if (quantity < 1)
            throw new IllegalAccessException("quantity should not be non-positive value");
        this.quantity_ = quantity;
    }

    /**
     * get price_
     *
     * @return double
     */
    public double getPrice() {
        return price_;
    }

    /**
     * set price_
     */
    public void setPrice(double price) throws IllegalAccessException {
        if (price < 0)
            throw new IllegalAccessException("price should not be non-positive value");
        this.price_ = price;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "order item id:" + orderItemId_ + " Order id: " + orderId_ + " Product id: " + productId_ + " quantity:" + quantity_ + " price:" + price_;
    }
}
