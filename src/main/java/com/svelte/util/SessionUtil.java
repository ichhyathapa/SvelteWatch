/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.svelte.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    public static void setAttribute(
            HttpServletRequest request,
            String key,
            Object value
    ) {

        HttpSession session = request.getSession();

        session.setAttribute(key, value);
    }

    public static Object getAttribute(
            HttpServletRequest request,
            String key
    ) {

        HttpSession session =
                request.getSession(false);

        if(session != null) {
            return session.getAttribute(key);
        }

        return null;
    }

    public static void invalidateSession(
            HttpServletRequest request
    ) {

        HttpSession session =
                request.getSession(false);

        if(session != null) {
            session.invalidate();
        }
    }
}