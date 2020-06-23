package com.easycab.utils;

import com.easycab.models.User;

/**
 *
 * @author a2-miljau
 */
public class EasyCabSession {

    public static final String ATTR_NAME = "appSession";

    public enum SessionUserType {
        Admin, Customer, Driver, Anonymous;

        public static SessionUserType fromUserType(User.UserType type) {
            switch (type) {
                case Admin:
                    return Admin;
                case Customer:
                    return Customer;
                case Driver:
                    return Driver;
            }
            return null;
        }
    };

    private SessionUserType userType;
    private User user = null;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public SessionUserType getUserType() {
        return userType;
    }

    public void setUserType(SessionUserType userType) {
        this.userType = userType;
    }

    public EasyCabSession() {
        this.userType = SessionUserType.Anonymous;
    }

}
