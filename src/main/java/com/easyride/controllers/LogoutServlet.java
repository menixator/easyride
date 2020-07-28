package com.easyride.controllers;

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
public class LogoutServlet extends HttpServlet {

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
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        httpRequest.removeAttribute(EasyCabSession.ATTR_NAME);
        ((HttpServletResponse) response).sendRedirect("/public/login.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        httpRequest.removeAttribute(EasyCabSession.ATTR_NAME);
        ((HttpServletResponse) response).sendRedirect("/public/login.jsp");

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
