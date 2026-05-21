package com.svelte.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {
        
        // GET SESSION
        HttpSession session
                = request.getSession(false);

        // DESTROY SESSION
        if (session != null) {
            session.invalidate();
        }

        // REDIRECT to Home page
        response.sendRedirect(
                request.getContextPath()
                + "/watches.jsp"
        );
    }
}
