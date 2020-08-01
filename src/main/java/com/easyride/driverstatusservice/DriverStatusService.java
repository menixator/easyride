/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.driverstatusservice;

import com.easyride.dao.NotifDao;
import com.easyride.dao.UserDao;
import com.easyride.models.Notif;
import com.easyride.models.User;
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
public class DriverStatusService {

    @GET
    @Path("/")
    public String getStatus(@Context HttpServletRequest request) {
        // Session creation
        HttpSession session = request.getSession(false);
        EasyCabSession easyCabSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
        return easyCabSession.getUser().getDriverStatus().toString();
    }

    @POST
    @Path("/{newStatus}")
    public DriverStatusResponse setStatus(@PathParam("newStatus") String newStatus,
            @Context HttpServletRequest request) {
        // Session creation
        HttpSession session = request.getSession(false);
        EasyCabSession easyCabSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);

        User.DriverStatus status = User.DriverStatus.driverStatusFromString(newStatus);

        User driver = easyCabSession.getUser();
        DriverStatusResponse response = new DriverStatusResponse();
        if (status != null) {
            driver.setDriverStatus(status);
            UserDao.setDriverStatus(driver, status);
            response.setNewStatus(newStatus);
        } else {
            ArrayList<String> errors = new ArrayList<>();
            errors.add("Unknown status");
            response.setErrors(errors);
        }
        return response;
    }
}
