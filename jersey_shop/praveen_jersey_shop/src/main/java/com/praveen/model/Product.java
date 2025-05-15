/**
 * @title Product
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.model;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Product implements Serializable {
    private int productId_;
    private String productName_;
    private String description_;
    private double unit_price_;
    private int stockQuantity_;
    private int categoryId_;

    /**
     * Product constructor
     */
    public Product() {
        //no-arg constructor
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
     * get productName_
     *
     * @return String
     */
    public String getProductName() {
        return productName_;
    }

    /**
     * set productName_
     */
    public void setProductName(String productName) throws IllegalAccessException {
        if (productName == null || productName.isEmpty())
            throw new IllegalAccessException("null or empty value is not accepted");
        this.productName_ = productName;
    }

    /**
     * get description_
     *
     * @return String
     */
    public String getDescription() {
        return description_;
    }

    /**
     * set description_
     */
    public void setDescription(String description) throws IllegalAccessException {
        if (description == null || description.isEmpty())
            throw new IllegalAccessException("null or empty value is not accepted");
        this.description_ = description;
    }

    /**
     * get price_
     *
     * @return double
     */
    public double getPrice() {
        return unit_price_;
    }

    /**
     * set price_
     */
    public void setPrice(double price) throws IllegalAccessException {
        if (price < 1)
            throw new IllegalAccessException("input should not be non-positive value");
        this.unit_price_ = price;
    }

    /**
     * get stockQuantity_
     *
     * @return int
     */
    public int getStockQuantity() {
        return stockQuantity_;
    }

    /**
     * set stockQuantity_
     */
    public void setStockQuantity(int stockQuantity) throws IllegalAccessException {
        if (stockQuantity < 0)
            throw new IllegalAccessException("input should not be non-positive value");
        this.stockQuantity_ = stockQuantity;
    }

    /**
     * get categoryId_
     *
     * @return int
     */
    public int getCategoryId() {
        return categoryId_;
    }

    /**
     * set categoryId_
     */
    public void setCategoryId(int categoryId) throws IllegalAccessException {
        if (categoryId < 1)
            throw new IllegalAccessException("input should not be non-positive value");
        this.categoryId_ = categoryId;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "product id:" + productId_ + " Product name: " + productName_ + " quantity:" + stockQuantity_ + " Description: " + description_ + " Price: " + unit_price_;
    }
}
