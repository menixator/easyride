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
    public NotifResponse getNotifs(@QueryParam("since") long since,
            @Context HttpServletRequest request) {
        // Session creation
        HttpSession session = request.getSession(false);
        EasyCabSession easyCabSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
        ArrayList<Notif> notifs = NotifDao.getNotifsForUserSince(easyCabSession.getUser(), since);
        // Prime example of why java is a horrible language. There isnt a standardized way of mapping a list onto another
        // before java 8.
        ArrayList<NotifModel> newNotifs = new ArrayList();
        for (Notif notif: notifs){
            newNotifs.add(new NotifModel(notif.getId(), notif.getRideId(), notif.getCreatedTimestamp().getTime()));
        }
        NotifResponse response = new NotifResponse();
        response.setNotifs(newNotifs);
        return response;
    }
}
