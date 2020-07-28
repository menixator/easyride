/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.dao;

import com.easyride.models.Notif;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
