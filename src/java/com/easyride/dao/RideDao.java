/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.dao;

import com.easyride.models.Ride;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author miljau_a
 */
public class RideDao extends BaseDao {

    public static boolean createRide(Ride ride) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("INSERT INTO rides(userId, driverId, status, pickupLocationLongitude, pickupLocationLatitiude, destinationLongitude, destinationLatitude, fare, requestedTimestamp, endTimestamp) VALUES(?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?)");
            statement.setInt(1, ride.getUserId());
            statement.setInt(2, ride.getDriverId());
            statement.setString(3, ride.getStatus().toString());
            statement.setDouble(4, ride.getPickupLocationLongitude());
            statement.setDouble(5, ride.getPickupLocationLatitiude());
            statement.setDouble(6, ride.getDestinationLongitude());
            statement.setDouble(7, ride.getDestinationLatitude());
            statement.setDouble(8, ride.getFare());
            statement.setTimestamp(9, ride.getRequestedTimestamp());
            statement.setTimestamp(10, ride.getEndTimestamp());
            statement.execute();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public static boolean updateRide(Ride ride) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("UPDATE rides userId=?, driverId=?, status=?, pickupLocationLongitude=?, pickupLocationLatitiude=?, destinationLongitude=?, destinationLatitude=?, fare=?, requestedTimestamp=?, endTimestamp=? WHERE id =?");
            statement.setInt(1, ride.getUserId());
            statement.setInt(2, ride.getDriverId());
            statement.setString(3, ride.getStatus().toString());
            statement.setDouble(4, ride.getPickupLocationLongitude());
            statement.setDouble(5, ride.getPickupLocationLatitiude());
            statement.setDouble(6, ride.getDestinationLongitude());
            statement.setDouble(7, ride.getDestinationLatitude());
            statement.setDouble(8, ride.getFare());
            statement.setTimestamp(9, ride.getRequestedTimestamp());
            statement.setTimestamp(10, ride.getEndTimestamp());
            statement.setInt(11, ride.getId());
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
}
