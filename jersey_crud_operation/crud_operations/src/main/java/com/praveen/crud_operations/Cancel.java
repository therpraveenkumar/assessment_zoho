/**
 * @title Cancel
 * @author praveenkumar raja
 * @version 1.0
 */
package com.praveen.crud_operations;

import java.io.Serializable;
import java.time.OffsetDateTime;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Cancel implements Serializable {
    private int cancelId_;
    private int orderId_;
    private String reason_;
    private String canceledAt_;

    /**
     * cancel constructor
     */
    public Cancel() {
        //no-argue
    }

    /**
     * get cancelId_
     *
     * @return int
     */
    public int getCancelId_() {
        return cancelId_;
    }

    /**
     * set cancelId_
     */
    public void setCancelId_(int cancelId_) {
        this.cancelId_ = cancelId_;
    }

    /**
     * get orderId_
     *
     * @return int
     */
    public int getOrderId_() {
        return orderId_;
    }

    /**
     * set orderId_
     */
    public void setOrderId_(int orderId) {
        this.orderId_ = orderId;
    }

    /**
     * get reason_
     *
     * @return String
     */
    public String getReason_() {
        return reason_;
    }

    /**
     * set reason_
     */
    public void setReason_(String reason) {
        this.reason_ = reason;
    }

    /**
     * get canceledAt
     *
     * @return OffsetDateTime
     */
    public String getCanceledAt_() {
        return canceledAt_;
    }

    /**
     * set canceledAt_
     */
    public void setCanceledAt_(String canceledAt_) {
        this.canceledAt_ = canceledAt_;
    }

    /**
     * override toString method
     *
     * @return String
     */
    @Override
    public String toString() {
        return "cancel id:" + cancelId_ + " Reason: " + reason_ + " created at:" + canceledAt_ + " order id: " + orderId_;
    }
}
