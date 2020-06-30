/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.dao;

import com.easyride.models.Ride;
import com.easyride.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;

/**
 *
 * @author miljau_a
 */
public class RideDao extends BaseDao {

    public static boolean createRide(Ride ride) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("INSERT INTO rides(userId, driverId, status, pickupLocationLongitude, pickupLocationLatitude, destinationLongitude, destinationLatitude, fare, requestedTimestamp, endTimestamp, distance) VALUES(?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?, ?)");
            statement.setInt(1, ride.getUserId());
            statement.setInt(2, ride.getDriverId());
            statement.setString(3, ride.getStatus().toString());
            statement.setDouble(4, ride.getPickupLocationLongitude());
            statement.setDouble(5, ride.getPickupLocationLatitude());
            statement.setDouble(6, ride.getDestinationLongitude());
            statement.setDouble(7, ride.getDestinationLatitude());
            statement.setDouble(8, ride.getFare());
            statement.setTimestamp(9, Timestamp.from(Instant.now()));
            statement.setTimestamp(10, ride.getEndTimestamp());
            statement.setDouble(11, ride.getDistance());
            statement.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return false;
        }
    }

    public static Ride getActiveRideForDriver(User driver) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("SELECT id, userId, driverId, status, pickupLocationLongitude, pickupLocationLatitiude, destinationLongitude, destinationLatitude, fare, requestedTimestamp, endTimestamp, distance where driverId = ? AND status='InProgress'");
            statement.setInt(1, driver.getId());
            ResultSet set = statement.executeQuery();

            if (!set.next()) {
                return null;
            }

            return Ride.fromResultSet(set);
        } catch (SQLException ex) {
            return null;
        }
    }

    public static boolean updateRide(Ride ride) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("UPDATE rides userId=?, driverId=?, status=?, pickupLocationLongitude=?, pickupLocationLatitiude=?, destinationLongitude=?, destinationLatitude=?, fare=?, requestedTimestamp=?, endTimestamp=?, distance=? WHERE id =?");
            statement.setInt(1, ride.getUserId());
            statement.setInt(2, ride.getDriverId());
            statement.setString(3, ride.getStatus().toString());
            statement.setDouble(4, ride.getPickupLocationLongitude());
            statement.setDouble(5, ride.getPickupLocationLatitude());
            statement.setDouble(6, ride.getDestinationLongitude());
            statement.setDouble(7, ride.getDestinationLatitude());
            statement.setDouble(8, ride.getFare());
            statement.setTimestamp(9, ride.getRequestedTimestamp());
            statement.setTimestamp(10, ride.getEndTimestamp());
            statement.setDouble(11, ride.getDistance());
            statement.setInt(12, ride.getId());
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
}
