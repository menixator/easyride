package com.easyride.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author a2-miljau
 */
public class BaseDao {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException ex) {

        }
        try {
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/easycab", "easycab", "easycab");
        } catch (SQLException ex) {

        }
        return con;
    }
}
