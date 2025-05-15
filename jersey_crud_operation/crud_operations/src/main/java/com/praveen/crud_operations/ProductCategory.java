/**
 * @title ProductCategory
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.crud_operations;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ProductCategory implements Serializable {
    private int categoryId_;
    private String categoryName_;

    /**
     * ProductCategory constructor
     */
    public ProductCategory() {
        //no-arg constructor
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
     * get categoryName_
     *
     * @return String
     */
    public String getCategoryName() {
        return categoryName_;
    }

    /**
     * set categoryName_
     */
    public void setCategoryName(String categoryName) throws IllegalAccessException {
        if (categoryName == null || categoryName.isEmpty())
            throw new IllegalAccessException("null or empty value is not accepted");
        this.categoryName_ = categoryName;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "category id:" + categoryId_ + " category name:" + categoryName_;
    }
}
