package com.svelte.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// Utility class for handling session management operations
public class SessionUtil {

    // Stores an attribute inside the current user session
    public static void setAttribute(
            HttpServletRequest request,
            String key,
            Object value
    ) {

        HttpSession session = request.getSession();

        session.setAttribute(key, value);
    }

    // Retrieves an attribute from the existing session
    public static Object getAttribute(
            HttpServletRequest request,
            String key
    ) {

        HttpSession session
                = request.getSession(false);

        if (session != null) {
            return session.getAttribute(key);
        }

        return null;
    }

    // Invalidates and destroys the current session
    public static void invalidateSession(
            HttpServletRequest request
    ) {

        HttpSession session
                = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }
    }
}
