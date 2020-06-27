/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.controllers;

import com.easyride.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author miljau_a
 */
public class RegisterDriverServlet extends RegisterServlet {

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
        response.sendRedirect("/admin/registerdriver.jsp");
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
        ArrayList<String> messages = new ArrayList();
        ArrayList<String> errors = new ArrayList();
        request.setAttribute("errors", errors);
        request.setAttribute("messages", messages);
        
        User user = validateUser(request, User.UserType.Driver);
        String licenseNumber = request.getParameter("licenseNumber");
        validateString("licenseNumber", licenseNumber, errors);
        
        String vehicalRegistrationNumber = request.getParameter("vehicalRegistrationNumber");
        validateString("vehicalRegistrationNumber", vehicalRegistrationNumber, errors);
        
        if (errors.isEmpty() && user != null) {
            user.setLicenseNumber(licenseNumber);
            user.setVehicalRegistrationNumber(vehicalRegistrationNumber);
            user.setDriverStatus(User.DriverStatus.Busy);
            persistUser(request, user);
        }
        request.getRequestDispatcher("/admin/registerdriver.jsp").forward(request, response);
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
