package com.easycab.models;

import com.easycab.utils.Hasher;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author a2-miljau
 */
public class User {

    public enum UserType {
        Driver, Customer, Admin;

        public static UserType userTypeFromString(String type) {
            switch (type.toUpperCase()) {
                case "DRIVER":
                    return Driver;
                case "CUSTOMER":
                    return Customer;
                case "ADMIN":
                    return Admin;
                default:
                    return null;
            }

        }
    }
    
    public enum DriverStatus {
        Available, Busy, Enroute;
        
        public static DriverStatus driverStatusFromString(String status) {
            if (status == null) { return null; }
            switch (status.toUpperCase()){
                case "AVAILABLE": return Available;
                case "BUSY": return Busy;
                case "ENROUTE": return Enroute;
                default: return null;
            }
        }
    }
    
    private int id;
    private String name;
    private String email;
    private String contactNumber;
    private String hash;
    private UserType type;
    private String vehicalRegistrationNumber;
    private String licenseNumber;
    private DriverStatus driverStatus;
    
    public static User fromResultSet(ResultSet set) throws SQLException {   
        User user = new User();
        user.setId(set.getInt("id"));
        user.setName(set.getString("name"));
        user.setEmail(set.getString("email"));
        user.setContactNumber(set.getString("contactNumber"));
        user.setType(UserType.userTypeFromString(set.getString("type")));
        user.setHashRaw(set.getString("hash"));
        user.setVehicalRegistrationNumber(set.getString("vehicalRegistrationNumber"));
        user.setLicenseNumber( set.getString("licenseNumber") );
        user.setDriverStatus( DriverStatus.driverStatusFromString(set.getString("driverStatus")));
        return user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVehicalRegistrationNumber() {
        return vehicalRegistrationNumber;
    }

    public DriverStatus getDriverStatus() {
        return driverStatus;
    }

    public void setDriverStatus(DriverStatus driverStatus) {
        this.driverStatus = driverStatus;
    }

    public void setVehicalRegistrationNumber(String vehicalRegistrationNumber) {
        this.vehicalRegistrationNumber = vehicalRegistrationNumber;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public UserType getType() {
        return type;
    }

    public void setType(UserType type) {
        this.type = type;
    }

    public void setHash(String password) throws NoSuchAlgorithmException {
        this.hash = Hasher.hash(password);
    }

    public void setHashRaw(String hash) {
        this.hash = hash;
    }

    public boolean verifyHash(String password) {
        return Hasher.verify(password, hash);
    }
    
    public String getHash(){
        return this.hash;
    }
}
