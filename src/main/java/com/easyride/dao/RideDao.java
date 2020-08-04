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
            PreparedStatement statement = con.prepareStatement("INSERT INTO rides(userId, driverId, status, pickupLocationLongitude, pickupLocationLatitude, destinationLongitude, destinationLatitude, fare, requestedTimestamp, endTimestamp, distance) VALUES(?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?  ,?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
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
            statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                ride.setId(rs.getInt(1));
            }

            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return false;
        }
    }

    public static int getTotalCustomersServed(int driverId) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("SELECT COUNT(*) AS CNT FROM rides WHERE driverId = ? and CAST(requestedTimestamp AS DATE)= CURRENT_DATE");
            statement.setInt(1, driverId);
            ResultSet rs = statement.executeQuery();

            if (!rs.next()) {

                return 0;
            }
            return rs.getInt("CNT");
        } catch (SQLException ex) {
            return 0;
        }
    }

    public static Ride getRide(int id) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("SELECT * FROM rides where id = ?");
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return Ride.fromResultSet(rs);
            }
            return null;
        } catch (SQLException ex) {
            System.out.println("a" + ex.toString());
            return null;
        }
    }

    public static Integer getActiveRideId(User driver) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("SELECT id FROM rides where status != 'Ended' AND driverId = ? ORDER BY requestedTimestamp DESC FETCH FIRST 1 ROWS ONLY");
            statement.setInt(1, driver.getId());
            ResultSet set = statement.executeQuery();

            if (!set.next()) {
                return null;
            }
            return set.getInt("id");

        } catch (SQLException ex) {
            return null;
        }
    }

    public static User getNextDriver() {
        try {
            Connection con = getConnection();
            // RIP no string literals. S
            PreparedStatement statement = con.prepareStatement("SELECT usr.* FROM users usr LEFT JOIN ( select ride.driverId, MAX(ride.endTimestamp) as lastRideActivityTimestamp from rides ride GROUP BY ride.driverId ) rideOrdering ON rideOrdering.driverId = usr.id WHERE usr.type = 'Driver' and usr.driverStatus = 'Available' ORDER BY rideOrdering.lastRideActivityTimestamp ASC FETCH FIRST 1 ROWS ONLY");
            ResultSet set = statement.executeQuery();

            if (!set.next()) {
                return null;
            }

            return User.fromResultSet(set);
        } catch (SQLException ex) {
            return null;
        }
    }

    public static Ride getActiveRideForDriver(User driver) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("SELECT id, userId, driverId, status, pickupLocationLongitude, pickupLocationLatitude, destinationLongitude, destinationLatitude, fare, requestedTimestamp, endTimestamp, distance where driverId = ? AND status='InProgress'");
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
            PreparedStatement statement = con.prepareStatement("UPDATE rides SET userId=?, driverId=?, status=?, pickupLocationLongitude=?, pickupLocationLatitude=?, destinationLongitude=?, destinationLatitude=?, fare=?, requestedTimestamp=?, endTimestamp=?, distance=? WHERE id =?");
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
