package com.easyride.controllers;

import com.easyride.dao.UserDao;
import com.easyride.models.User;
import com.easyride.utils.EasyCabSession;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author a2-miljau
 */
public class LogoutServlet extends BaseServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logout(request, response);

    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EasyCabSession session = getSession(request);

        User driver = session.getUser();
        if (driver.getType() == User.UserType.Driver) {
            driver.setDriverStatus(User.DriverStatus.Offline);
            UserDao.setDriverStatus(driver, User.DriverStatus.Offline);
        }
        request.getSession(false).removeAttribute(EasyCabSession.ATTR_NAME);
        response.sendRedirect("/public/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logout(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
