package com.easyride.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class Ride {

    // An enum to represent the state of the ride.
    public enum RideStatus {
        // The customer is waiting for a pickup
        Waiting,
        // The ride is in progress.
        InProgress,
        // The ride has ended.
        Ended,
        // No drivers accepted the request.
        Failed;

        /**
         * Coerces a string to a ride status
         *
         * @param status
         * @return RideStatus|null
         */
        public static RideStatus rideStatusFromString(String status) {
            switch (status.toUpperCase()) {
                case "WAITING":
                    return RideStatus.Waiting;
                case "INPROGRESS":
                    return RideStatus.InProgress;
                case "ENDED":
                    return RideStatus.Ended;
                case "FAILED":
                    return RideStatus.Failed;
                default:
                    return null;
            }
        }
    }

    private int id;
    private int userId;
    private int driverId;
    private RideStatus status;
    private double pickupLocationLongitude;
    private double pickupLocationLatitude;
    private double destinationLongitude;
    private double destinationLatitude;
    private double fare;
    private Timestamp requestedTimestamp;
    private Timestamp endTimestamp;

    public static Ride fromResultSet(ResultSet set) throws SQLException {
        Ride ride = new Ride();
        ride.setId(set.getInt("id"));
        ride.setUserId(set.getInt("userId"));
        ride.setDriverId(set.getInt("driverId"));
        ride.setStatus(RideStatus.rideStatusFromString(set.getString("status")));
        ride.setPickupLocationLongitude(set.getDouble("pickupLocationLongitude"));
        ride.setPickupLocationLatitude(set.getDouble("pickupLocationLatitiude"));
        ride.setDestinationLongitude(set.getDouble("destinationLongitude"));
        ride.setDestinationLatitude(set.getDouble("destinationLatitude"));
        ride.setFare(set.getDouble("fare"));
        ride.setRequestedTimestamp(set.getTimestamp("requestedTimestamp"));
        ride.setEndTimestamp(set.getTimestamp("endTimestamp"));
        return ride;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public RideStatus getStatus() {
        return status;
    }

    public void setStatus(RideStatus status) {
        this.status = status;
    }

    public double getPickupLocationLongitude() {
        return pickupLocationLongitude;
    }

    public void setPickupLocationLongitude(double pickupLocationLongitude) {
        this.pickupLocationLongitude = pickupLocationLongitude;
    }

    public double getPickupLocationLatitude() {
        return pickupLocationLatitude;
    }

    public void setPickupLocationLatitude(double pickupLocationLatitiude) {
        this.pickupLocationLatitude = pickupLocationLatitiude;
    }

    public double getDestinationLongitude() {
        return destinationLongitude;
    }

    public void setDestinationLongitude(double destinationLongitude) {
        this.destinationLongitude = destinationLongitude;
    }

    public double getDestinationLatitude() {
        return destinationLatitude;
    }

    public void setDestinationLatitude(double destinationLatitude) {
        this.destinationLatitude = destinationLatitude;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public Timestamp getRequestedTimestamp() {
        return requestedTimestamp;
    }

    public void setRequestedTimestamp(Timestamp requestedTimestamp) {
        this.requestedTimestamp = requestedTimestamp;
    }

    public Timestamp getEndTimestamp() {
        return endTimestamp;
    }

    public void setEndTimestamp(Timestamp endTimestamp) {
        this.endTimestamp = endTimestamp;
    }

}
