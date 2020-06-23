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

        ArrayList<String> errors = new ArrayList();

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
            request.setAttribute("errors", errors);

        } else {

            if (UserDao.getUserByEmail(email) != null) {
                errors.add(String.format("A user for the email '%s' already exists. Please login."));
                request.getRequestDispatcher("/public/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setType(User.UserType.Customer);
            user.setName(name);
            user.setEmail(email);
            try {
                user.setHash(password);
            } catch (NoSuchAlgorithmException ex) {
                errors.add("Failed to create user. Please try again!");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/public/register.jsp").forward(request, response);
            }
            user.setContactNumber(contactNumber);

            if (!UserDao.createUser(user)) {
                errors.add("Failed to create user. Please try again!");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/public/register.jsp").forward(request, response);
            } else {
                ArrayList<String> messages = new ArrayList();
                messages.add(String.format("The user for '%s' has been created. Please log in.", email));
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("/public/register.jsp").forward(request, response);
            }
        }
    }

    private void validateString(String prop, String value, ArrayList<String> errors) {
        validateString(prop, value, errors, 255);
    }

    private void validateString(String prop, String value, ArrayList<String> errors, int length) {
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
