package com.svelte.filter;

import com.svelte.model.User;
import com.svelte.util.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        // GET LOGGED IN USER
        User user =
                (User) SessionUtil.getAttribute(req, "user");

       // CHECK IF USER IS ADMIN
        if (user != null
                && user.getRole() != null
                && user.getRole().equalsIgnoreCase("admin")) {

            // ALLOW ACCESS
            chain.doFilter(request, response);

        } else {

            // REDIRECT NON-ADMIN USERS
            res.sendRedirect(
                    req.getContextPath() + "/product"
            );
        }
    }
}