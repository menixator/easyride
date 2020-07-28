package com.easyride.controllers;

import com.easyride.utils.EasyCabSession;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author a2-miljau
 */
public class BaseServlet extends HttpServlet {

    public EasyCabSession getSession(ServletRequest request) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        return getSession(httpRequest);
    }

    public EasyCabSession getSession(HttpServletRequest request) {
        // Session creation
        HttpSession session = request.getSession(false);
        return (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
    }

}
