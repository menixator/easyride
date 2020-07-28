package com.easyride.controllers;

import com.easyride.dao.UserDao;
import com.easyride.models.User;
import com.easyride.utils.EasyCabSession;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author a2-miljau
 */
public class LoginServlet extends BaseServlet {

    /**
     * Handles the HTTP <code>GET</code> method to the login route.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EasyCabSession session = getSession(request);
        // If the user is not logged in, redirect to the login page.
        if (session.getUserType() == EasyCabSession.SessionUserType.Anonymous) {
            response.sendRedirect("/public/login.jsp");
        } else {
            // Otherwise, redirect to the index page.
            response.sendRedirect("/index.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserDao.getUserByEmail(email);

        if (user == null) {
            ArrayList<String> errors = new ArrayList();
            errors.add("The Email or Password is Incorrect.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/public/login.jsp").forward(request, response);
            return;
        }

        if (user.verifyHash(password)) {
            getSession(request).setUserType(EasyCabSession.SessionUserType.fromUserType(user.getType()));
            getSession(request).setUser(user);
            if (user.getType() == User.UserType.Driver) {
                ((HttpServletResponse) response).sendRedirect("/driver/dashboard.jsp");
            } else if (user.getType() == User.UserType.Customer) {
                ((HttpServletResponse) response).sendRedirect("/customer/request-a-pickup.jsp");
            } else {
                ((HttpServletResponse) response).sendRedirect("/index.jsp");
            }
        } else {

            ArrayList<String> errors = new ArrayList();
            errors.add("The Email or Password is Incorrect.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/public/login.jsp").forward(request, response);
            return;
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }

}
