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
            PreparedStatement statement = con.prepareStatement("INSERT INTO notifs(type, rideId, data) VALUES(?, ?, ?)");
            statement.setString(1, notif.getType().toString());
            statement.setInt(2, notif.getRideId());
            statement.setString(3, notif.getData());
            statement.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return false;
        }
    }

    public static ArrayList<Notif> getNotifsForRide(int rideId) {
        ArrayList<Notif> notifs = new ArrayList<>();

        try {
            Connection con = getConnection();
            PreparedStatement statement = con.prepareStatement("SELECT notif.* FROM notifs notif where notif.rideId = ? ORDER BY notif.createdTimestamp ASC");
            statement.setInt(1, rideId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                notifs.add(Notif.fromResultSet(rs));
            }
            return notifs;
        } catch (SQLException ex) {
            return null;
        }
    }
}
