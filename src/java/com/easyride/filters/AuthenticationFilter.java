package com.easyride.filters;

import com.easyride.utils.EasyCabSession;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // Session creation
        HttpSession session = httpRequest.getSession(false);
        EasyCabSession appSession;

        if (session == null || session.getAttribute(EasyCabSession.ATTR_NAME) == null) {
            session = httpRequest.getSession(true);
            // Timeout in 10 minutes.
            session.setMaxInactiveInterval(10 * 60);
            appSession = new EasyCabSession();

            session.setAttribute(EasyCabSession.ATTR_NAME, appSession);
        } else {
            appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
        }

        // If the user is logged in and tries to get to the login page again, redirect to the index page.
        if (appSession.getUserType() == EasyCabSession.SessionUserType.Anonymous && httpRequest.getRequestURI().equals("/public/index.jsp")) {
            httpResponse.sendRedirect("/public/login.jsp");
            return;
        }

        // If the user is logged in and tries to get to the login page again, redirect to the index page.
        if (appSession.getUserType() == EasyCabSession.SessionUserType.Anonymous && httpRequest.getRequestURI().equals("/public/index.jsp")) {
            httpResponse.sendRedirect("/public/login.jsp");
            return;
        }

        // If the user is requesting the login page, ignore the filter.
        if (httpRequest.getRequestURI().startsWith("/public")) {
            chain.doFilter(request, response);
            return;
        } else if (httpRequest.getRequestURI().startsWith("/admin") && appSession.getUserType() != EasyCabSession.SessionUserType.Admin) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        } else if (httpRequest.getRequestURI().startsWith("/driver") && appSession.getUserType() != EasyCabSession.SessionUserType.Driver) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        } else {
            chain.doFilter(request, response);
            return;
        }

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }

}
