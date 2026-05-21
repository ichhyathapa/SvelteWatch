package com.svelte.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Arrays;

public class CookieUtil {

    // Add Cookie
    public static void addCookie(HttpServletResponse response,
                                 String name,
                                 String value,
                                 int maxAge) {

        Cookie cookie = new Cookie(name, value);

        cookie.setMaxAge(maxAge);

        cookie.setPath("/");

        response.addCookie(cookie);
    }

    // Get Cookie
    public static Cookie getCookie(HttpServletRequest request,
                                   String name) {

        if (request.getCookies() != null) {

            return Arrays.stream(request.getCookies())

                    .filter(cookie ->
                            name.equals(cookie.getName()))

                    .findFirst()

                    .orElse(null);
        }

        return null;
    }

    // Delete Cookie
    public static void deleteCookie(HttpServletResponse response,
                                    String name) {

        Cookie cookie = new Cookie(name, null);

        cookie.setMaxAge(0);

        cookie.setPath("/");

        response.addCookie(cookie);
    }
}