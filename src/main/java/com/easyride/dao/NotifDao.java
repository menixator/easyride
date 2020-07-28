/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.dao;

import static com.easyride.dao.BaseDao.getConnection;
import com.easyride.models.Notif;
import com.easyride.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author miljau_a
 */
public class NotifDao extends BaseDao {

    public static boolean createNotif(Notif notif) {
        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("INSERT INTO notifs(type, rideId) VALUES(?, ?);");
            statement.setString(1, notif.getType().toString());
            statement.setInt(2, notif.getRideId());
            statement.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return false;
        }
    }

    public static ArrayList<Notif> getNotifsForUserSince(User user, long since) {
        ArrayList<Notif> notifs = new ArrayList<>();

        try {
            Connection con = getConnection();
            // Only one row will be returned because there is a unique constraint on email.
            PreparedStatement statement = con.prepareStatement("SELECT notif.* FROM notifs notif LEFT JOIN rides ride on ride.id = notif.rideId LEFT JOIN  users u ON u.id = ride.userId OR u.id = ride.driverId WHERE u.id = ? AND notif.createdTimestamp >= ?");
            statement.setInt(1, user.getId());
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                notifs.add(Notif.fromResultSet(rs));
            }
            return notifs;
        } catch (SQLException ex) {
            return notifs;
        }
    }
}
