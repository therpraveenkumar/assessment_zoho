/**
 * @title CartItem
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.crud_operations;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class CartItem implements Serializable {
    private int cartItemId_;
    private int cartId_;
    private int productId_;
    private int quantity_;

    /**
     * cartItem constructor
     */
    public CartItem() {
        //no-arg constructor
    }

    /**
     * get cartItemId_
     *
     * @return int
     */
    public int getCartItemId() {
        return cartItemId_;
    }

    /**
     * set cartItemId_
     */
    public void setCartItemId(int cartItemId) throws IllegalAccessException {
        if (cartItemId < 1)
            throw new IllegalAccessException("id should not be non-positive value");
        this.cartItemId_ = cartItemId;
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
            throw new IllegalAccessException("id should not be non-positive value");
        this.cartId_ = cartId;
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
     * @return quantity_
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
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "card item id:" + cartItemId_ + " quantity:" + quantity_ + " Cart id: " + cartId_;
    }
}
