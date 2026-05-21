package com.svelte.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.svelte.util.SessionUtil;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req
                = (HttpServletRequest) request;

        HttpServletResponse res
                = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // ALLOW STATIC FILES
        if (uri.endsWith(".css")
                || uri.endsWith(".jpg")
                || uri.endsWith(".jpeg")
                || uri.endsWith(".png")
                || uri.endsWith(".js")) {

            chain.doFilter(request, response);
            return;
        }

        // CHECK USER SESSION
        boolean loggedIn
                = SessionUtil.getAttribute(
                        req,
                        "user"
                ) != null;

        // PUBLIC PAGES
        boolean publicPage
                = uri.contains("/user")
                || uri.contains("/watches.jsp")
                || uri.contains("/pages/about.jsp")
                || uri.contains("/pages/contact.jsp");

        // ALLOW ACCESS
        if (loggedIn || publicPage) {

            chain.doFilter(request, response);

        } else {

            // REDIRECT TO LOGIN
            res.sendRedirect(
                    req.getContextPath()
                    + "/user?action=login"
            );
        }
    }
}
