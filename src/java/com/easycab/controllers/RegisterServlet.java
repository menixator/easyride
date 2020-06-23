package com.easycab.controllers;

import com.easycab.dao.UserDao;
import com.easycab.models.User;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author a2-miljau
 */
public class RegisterServlet extends BaseServlet {

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
        response.sendRedirect("/public/register.jsp");
    }

    protected User validateUser(HttpServletRequest request, User.UserType type) {

        ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");

        String email = request.getParameter("email");
        validateString("email", email, errors);

        String name = request.getParameter("name");
        validateString("name", name, errors);
        String contactNumber = request.getParameter("contactNumber");
        validateString("contactNumber", contactNumber, errors);
        String password = request.getParameter("password");
        validateString("password", password, errors);
        String passwordAgain = request.getParameter("passwordAgain");
        if (!passwordAgain.equals(password)) {
            errors.add("The passwords do not match!");
        }

        if (errors.size() > 0) {
            return null;
        } else {

            if (UserDao.getUserByEmail(email) != null) {
                errors.add(String.format("A user for the email '%s' already exists. Please login.", email));
                return null;
            }

            User user = new User();
            user.setType(type);
            user.setName(name);
            user.setEmail(email);
            try {
                user.setHash(password);
            } catch (NoSuchAlgorithmException ex) {
                errors.add("Failed to create user. Please try again!");
                return null;
            }
            user.setContactNumber(contactNumber);

            return user;
        }
    }

    protected User persistUser(HttpServletRequest request, User user) {
        ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");

        if (!UserDao.createUser(user)) {
            errors.add("Failed to create user. Please try again!");
            return null;
        } else {
            ArrayList<String> messages = (ArrayList<String>) request.getAttribute("messages");
            messages.add(String.format("The user for '%s' has been created. Please log in.", user.getEmail()));

            return user;
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
        ArrayList<String> messages = new ArrayList();
        ArrayList<String> errors = new ArrayList();
        request.setAttribute("errors", errors);
        request.setAttribute("messages", messages);

        User user = validateUser(request, User.UserType.Customer);
        if (user != null) {
            persistUser(request, user);
        }
        request.getRequestDispatcher("/public/register.jsp").forward(request, response);
    }

    protected void validateString(String prop, String value, ArrayList<String> errors) {
        validateString(prop, value, errors, 255);
    }

    protected void validateString(String prop, String value, ArrayList<String> errors, int length) {
        if (value == null || value.length() == 0 || value.trim().length() == 0) {
            errors.add(String.format("%s cannot be empty!", prop));
        } else if (value.length() > length) {
            errors.add(String.format("%s cannot be longer than %d", prop, length));
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
