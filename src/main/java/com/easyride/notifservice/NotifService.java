package com.easyride.notifservice;

import com.easyride.dao.NotifDao;
import com.easyride.dao.RideDao;
import com.easyride.dao.UserDao;
import com.easyride.models.Notif;
import com.easyride.models.Ride;
import com.easyride.models.Ride.RideStatus;
import com.easyride.models.User;
import com.easyride.utils.EasyCabSession;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class NotifService {

    @GET
    @Path("/all")
    public NotifResponse getNotifs(@QueryParam("rideId") int rideId,
            @Context HttpServletRequest request) {
        Ride ride = RideDao.getRide(rideId);
        if (ride == null) {
            NotifResponse response = new NotifResponse();
            response.setCurrentRideStatus(null);
            ArrayList<String> errors = new ArrayList<>();
            errors.add("Failed to retrieve ride");
            response.setErrors(errors);
            return response;
        }

        ArrayList<Notif> notifs = NotifDao.getNotifsForRide(rideId);
        if (notifs == null) {
            NotifResponse response = new NotifResponse();
            response.setCurrentRideStatus(ride.getStatus().toString());
            ArrayList<String> errors = new ArrayList<>();
            errors.add("Failed to retrieve notifs");
            response.setErrors(errors);
            return response;
        }
        // Prime example of why java is a horrible language. There isnt a standardized way of mapping a list onto another
        // before java 8.
        ArrayList<NotifModel> newNotifs = new ArrayList();
        for (Notif notif : notifs) {
            newNotifs.add(new NotifModel(notif.getId(), notif.getRideId(), notif.getCreatedTimestamp().getTime(), notif.getData(), notif.getType().toString()));
        }
        NotifResponse response = new NotifResponse();
        response.setCurrentRideStatus(ride.getStatus().toString());
        response.setNotifs(newNotifs);
        return response;
    }

    @GET
    @Path("/activeRideId")
    public Integer getActiveRide(@Context HttpServletRequest request) {
        EasyCabSession session = (EasyCabSession) request.getSession(false).getAttribute(EasyCabSession.ATTR_NAME);
        return RideDao.getActiveRideId(session.getUser());
    }

    @GET
    @Path("/setRideStatus")
    public String setRideStatus(@Context HttpServletRequest request, @QueryParam("nextStatus") String strRideStatus, @QueryParam("rideId") int rideId) {
        if (strRideStatus == null) {
            return "err";
        }
        RideStatus rideStatus = RideStatus.rideStatusFromString(strRideStatus);
        if (rideStatus == null) {
            return "err";
        }
        Ride ride = RideDao.getRide(rideId);
        if (ride == null || ride.getStatus() == rideStatus){
            return "err";
        }
        switch (rideStatus) {
            case WaitingForCustomerToEnter: {
                Notif getInNotif = new Notif();
                getInNotif.setData("{}");
                getInNotif.setType(Notif.NotifType.WaitingForCustomerToEnterNotif);
                getInNotif.setRideId(rideId);

                ride.setStatus(RideStatus.WaitingForCustomerToEnter);
                RideDao.updateRide(ride);
                NotifDao.createNotif(getInNotif);
                return "ok";
            }
            case InProgress: {
                Notif inProgressNotif = new Notif();
                inProgressNotif.setData("{}");
                inProgressNotif.setType(Notif.NotifType.InProgressNotif);
                inProgressNotif.setRideId(rideId);
                NotifDao.createNotif(inProgressNotif);
                ride.setStatus(RideStatus.InProgress);
                RideDao.updateRide(ride);
                return "ok";
            }
            case Ended: {
                Notif endNotif = new Notif();
                endNotif.setData("{}");
                endNotif.setType(Notif.NotifType.RideEndedNotif);
                endNotif.setRideId(rideId);
                NotifDao.createNotif(endNotif);
                ride.setStatus(RideStatus.Ended);
                ride.setEndTimestamp(Timestamp.from(Instant.now()));
                RideDao.updateRide(ride);
                UserDao.setDriverStatusById(ride.getDriverId(), User.DriverStatus.Available);
                return "ok";
            }
            default: {
                return "err";
            }
        }

    }
}
