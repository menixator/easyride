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
public class NotifDataTypes {

    public static class Location {

        double lng;
        double lat;

        public Location(double lng, double lat) {
            this.lng = lng;
            this.lat = lat;
        }

    }

    public static class CustomerInitialNotif {

        String driverName;
        String vehicalRegisitrationNumber;

        public CustomerInitialNotif(String driverName, String vehicalRegisitrationNumber) {
            this.driverName = driverName;
            this.vehicalRegisitrationNumber = vehicalRegisitrationNumber;
        }
    }

    public static class DriverInitialNotif {

        Location pickup;
        Location destination;
        double fare;
        String customerName;

        public DriverInitialNotif(Location pickup, Location destination, double fare, String customerName) {
            this.pickup = pickup;
            this.destination = destination;
            this.fare = fare;
            this.customerName = customerName;
        }
    }
}
