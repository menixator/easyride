/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.controllers;

import com.easyride.models.User;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author miljau_a
 */
public class RegisterAdminServlet extends RegisterServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().setAttribute("postPath", "/admin/registeradmin");
        request.getRequestDispatcher("/public/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<String> messages = new ArrayList();
        ArrayList<String> errors = new ArrayList();
        request.setAttribute("errors", errors);
        request.setAttribute("messages", messages);

        User user = validateUser(request, User.UserType.Admin);
        if (errors.isEmpty() && user != null) {
            persistUser(request, user);
        }
        request.getSession().setAttribute("postPath", "/admin/registeradmin");
        request.getRequestDispatcher("/public/register.jsp").forward(request, response);
    }

}
