/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.notifservice;

/**
 *
 * @author miljau_a
 */
public class NotifModel {
    int id;
    int rideId;
    long timeStamp;

    public NotifModel(int id, int rideId, long timeStamp) {
        this.id = id;
        this.rideId = rideId;
        this.timeStamp = timeStamp;
    }
    
    
}
