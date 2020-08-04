package com.easyride.dao;

import com.easyride.models.Ride;
import com.easyride.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author a2-miljau
 */
public class UserDao extends BaseDao {

    public static String getEarningsForTheDay(int driverId) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("SELECT CASE WHEN sum(fare) IS NULL THEN CAST(0 AS DOUBLE) ELSE sum(fare) END as fare from rides where driverId = ? and CAST(endTimestamp AS DATE)= CURRENT_DATE");
            statement.setInt(1, driverId);
            ResultSet rs = statement.executeQuery();

            if (!rs.next()) {
                return "0";
            }
            
            return String.format("%.2f", rs.getDouble(1));
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return "0";
        }
    }

      public static ArrayList<Ride> getRidesForToday(int driverId) {
        try {
            Connection con = getConnection();
            ArrayList<Ride> rides = new ArrayList<>();
            PreparedStatement statement = con.prepareStatement("SELECT * from rides where driverId = ? and CAST(endTimestamp AS DATE)= CURRENT_DATE");
            statement.setInt(1, driverId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                rides.add(Ride.fromResultSet(rs));
            }
            
            return rides;
        } catch (SQLException ex) {
            return null;
        }
    }

    public static User getUserByEmail(String email) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("SELECT id, name, email, contactNumber, type, hash, vehicalRegistrationNumber, licenseNumber, driverStatus FROM USERS WHERE email = ?");
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            if (!rs.next()) {
                System.out.println("empty result set");
                return null;
            }

            return User.fromResultSet(rs);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return null;
        }
    }

    public static int getAvailableDriverCount() {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("SELECT COUNT(*) AS CNT FROM USERS WHERE type = 'Driver' AND driverStatus = 'Available'");
            ResultSet rs = statement.executeQuery();

            if (!rs.next()) {
                return 0;
            }
            return rs.getInt("CNT");
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
    }

    public static boolean setDriverStatusById(int driverId, User.DriverStatus newStatus) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("UPDATE users set driverStatus =?  WHERE id =?");
            statement.setString(1, newStatus.toString());
            statement.setInt(2, driverId);
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }

    }

    public static boolean setDriverStatus(User user, User.DriverStatus newStatus) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("UPDATE users set driverStatus =?  WHERE id =?");
            statement.setString(1, newStatus.toString());
            statement.setInt(2, user.getId());
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }

    }

    public static boolean createUser(User user) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("INSERT INTO USERS(name, email, contactNumber, type, hash, licenseNumber, vehicalRegistrationNumber, driverStatus) VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getContactNumber());
            statement.setString(4, user.getType().toString());
            statement.setString(5, user.getHash());
            statement.setString(6, user.getLicenseNumber());
            statement.setString(7, user.getVehicalRegistrationNumber());
            String driverStatus = null;
            if (user.getDriverStatus() != null) {
                driverStatus = user.getDriverStatus().toString();
            }
            statement.setString(8, driverStatus);
            statement.execute();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
}
