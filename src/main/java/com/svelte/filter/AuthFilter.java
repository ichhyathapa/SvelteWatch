package com.svelte.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.svelte.util.SessionUtil;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // ALLOW CSS + IMAGES
        if (uri.endsWith(".css")|| uri.endsWith(".jpg")|| uri.endsWith(".png")|| uri.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }

        boolean loggedIn = SessionUtil.getAttribute(req,"user") != null;
        boolean authPage= uri.contains("login.jsp") || uri.contains("register.jsp") || uri.contains("/user");

        if (loggedIn || authPage) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath()+ "/login.jsp");
        }
    }
}
