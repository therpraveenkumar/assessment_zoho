/**
 * @title Cart
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.model;

import java.io.Serializable;
import java.time.OffsetDateTime;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Cart implements Serializable {
    private int cartId_;
    private int userId_;
    private String createdAt_;

    /**
     * cart constructor
     */
    public Cart() {
        //no-arg constructor
    }

    /**
     * get cartId_
     *
     * @return int
     */
    public int getCartId() {
        return cartId_;
    }

    /**
     * set cartId_
     */
    public void setCartId(int cartId) throws IllegalAccessException {
        if (cartId < 1)
            throw new IllegalAccessException("id should be non-positive value");
        this.cartId_ = cartId;
    }

    /**
     * get userId_
     *
     * @return userId_
     */
    public int getUserId() {
        return userId_;
    }

    /**
     * set userId
     */
    public void setUserId(int userId) throws IllegalAccessException {
        if (userId < 1)
            throw new IllegalAccessException("id should be non-positive value");
        this.userId_ = userId;
    }

    /**
     * get createdAt_
     *
     * @return OffsetDateTime
     */
    public String getCreatedAt() {
        return createdAt_;
    }

    /**
     * set createdAt_
     */
    public void setCreatedAt(String createdAt) throws IllegalAccessException {
        if (createdAt == null)
            throw new IllegalAccessException("null value is not accepted");
        this.createdAt_ = createdAt;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "card id:" + cartId_ + " created at:" + createdAt_ + " user id: " + userId_;
    }
}