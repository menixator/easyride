package com.easycab.dao;

import com.easycab.models.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author a2-miljau
 */
public class UserDao extends BaseDao {

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

    public static boolean createUser(User user) {
        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("INSERT INTO USERS(name, email, contactNumber, type, hash) VALUES(?, ?, ?, ?, ?)");
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getContactNumber());
            statement.setString(4, user.getType().toString());
            statement.setString(5, user.getHash());
            statement.execute();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
}
