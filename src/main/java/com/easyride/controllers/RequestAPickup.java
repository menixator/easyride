/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.controllers;

import com.easyride.dao.NotifDao;
import com.easyride.dao.RideDao;
import com.easyride.dao.UserDao;
import com.easyride.models.Notif;
import com.easyride.models.Ride;
import com.easyride.models.User;
import com.easyride.notifservice.NotifDataTypes;
import com.easyride.utils.EasyCabSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author a2-miljau
 */
public class RequestAPickup extends BaseServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("/customer/request-a-pickup.jsp");
    }
    
    private Double validateDouble(HttpServletRequest request, String paramName, String properName, ArrayList<String> errors) {
        String value = request.getParameter(paramName);
        if (value == null) {
            errors.add(String.format("%s should not be empty.", properName));
            return null;
        }
        try {
            double doubleValue = Double.parseDouble(value);
            return doubleValue;
        } catch (NumberFormatException e) {
            errors.add(String.format("Expected a double value for %s", properName));
            return null;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<String> errors = new ArrayList();
        ArrayList<String> messages = new ArrayList();
        request.setAttribute("errors", errors);
        request.setAttribute("messages", messages);
        
        if (UserDao.getAvailableDriverCount() == 0) {
            errors.add("No drivers available. Please try again later.");
            request.getRequestDispatcher("/customer/request-a-pickup.jsp").forward(request, response);
            return;
        }
        
        User driver = RideDao.getNextDriver();
        
        Double pickupLocationLatitude = validateDouble(request, "pickupLocationLatitude", "pickupLocationLatitude", errors);
        Double pickupLocationLongitude = validateDouble(request, "pickupLocationLongitude", "pickupLocationLongitude", errors);
        Double destinationLatitude = validateDouble(request, "destinationLatitude", "destinationLatitude", errors);
        Double destinationLongitude = validateDouble(request, "destinationLongitude", "destinationLongitude", errors);
        Double fare = validateDouble(request, "fare", "fare", errors);
        Double distance = validateDouble(request, "distance", "distance", errors);
        Ride ride = new Ride();
        ride.setStatus(Ride.RideStatus.WaitingForDriverToArrive);
        ride.setPickupLocationLatitude(pickupLocationLatitude);
        ride.setPickupLocationLongitude(pickupLocationLongitude);
        ride.setDestinationLatitude(destinationLatitude);
        ride.setDestinationLongitude(destinationLongitude);
        ride.setFare(fare);
        ride.setDistance(distance);
        ride.setUserId(getSession(request).getUser().getId());
        ride.setDriverId(driver.getId());
        
        if (errors.size() == 0) {
            RideDao.createRide(ride);
            messages.add("Ride requested successfully!");
        } else {
            request.getRequestDispatcher("/customer/request-a-pickup.jsp").forward(request, response);
            return;
        }
        // Redirect the user and inform the driver.
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        Notif customerInitialNotif = new Notif();
        customerInitialNotif.setRideId(ride.getId());
        customerInitialNotif.setType(Notif.NotifType.CustomerInitialNotif);
        NotifDataTypes.CustomerInitialNotif customerData = new NotifDataTypes.CustomerInitialNotif(
                driver.getName(), driver.getVehicalRegistrationNumber()
        );
        customerInitialNotif.setData(new Gson().toJson(customerData));
        NotifDao.createNotif(customerInitialNotif);
        
        Notif driverInitialNotif = new Notif();
        driverInitialNotif.setType(Notif.NotifType.DriverInitialNotif);
        driverInitialNotif.setRideId(ride.getId());
        NotifDataTypes.DriverInitialNotif driverData = new NotifDataTypes.DriverInitialNotif(
                new NotifDataTypes.Location(ride.getPickupLocationLongitude(), ride.getPickupLocationLatitude()),
                new NotifDataTypes.Location(ride.getDestinationLongitude(), ride.getDestinationLatitude()),
                ride.getFare(),
                getSession(request).getUser().getName());
        driverInitialNotif.setData(
                new Gson().toJson(driverData));
        NotifDao.createNotif(driverInitialNotif);
        
        httpResponse.sendRedirect("/customer/story?id=" + ride.getId());
    }
}
