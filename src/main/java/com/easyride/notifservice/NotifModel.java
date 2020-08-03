/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.notifservice;

import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miljau_a
 */
@XmlRootElement
public class NotifModel {
    int id;
    int rideId;
    long timeStamp;
    String type;
    String data;

    public NotifModel(int id, int rideId, long timeStamp, String data, String type) {
        this.id = id;
        this.rideId = rideId;
        this.timeStamp = timeStamp;
        this.data = data;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public long getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(long timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    
}
