package com.easyride.models;

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
    private Timestamp startTime;
    private Timestamp endTime;
    private RideStatus status;

    private int driverId;
    private int customerId;

}
