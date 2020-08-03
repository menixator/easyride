package com.easyride.notifservice;

import com.easyride.dao.NotifDao;
import com.easyride.models.Notif;
import com.easyride.utils.EasyCabSession;
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
    @Path("/")
    public NotifResponse getNotifs(@QueryParam("rideId") int rideId,
            @Context HttpServletRequest request) {

        ArrayList<Notif> notifs = NotifDao.getNotifsForRide(rideId);
        if (notifs == null) {
            NotifResponse response = new NotifResponse();
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
        response.setNotifs(newNotifs);
        return response;
    }
}
