<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="jakarta.servlet.http.Cookie"%>
<%@page import="com.svelte.util.CookieUtil"%>

<!-- GET REMEMBERED EMAIL -->
<%
    Cookie emailCookie
            = CookieUtil.getCookie(request, "rememberEmail");

    String savedEmail = "";

    if (emailCookie != null) {
        savedEmail = emailCookie.getValue();
    }
%>

<!DOCTYPE html>
<html>

    <head>

        <!-- META -->
        <meta charset="UTF-8">

        <!-- PAGE TITLE -->
        <title>SvelteWatch Login</title>

        <!-- LOGIN CSS -->
        <link rel="stylesheet"
              href="css/login.css">

        <!-- GOOGLE ICONS -->
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />

    </head>

    <body>

        <!-- LOGIN CONTAINER -->
        <div class="container">

            <!-- PAGE TITLE -->
            <h2>Login</h2>

            <!-- ERROR MESSAGE -->
            <p class="error-message">${error}</p>

            <!-- SUCCESS MESSAGE -->
            <p class="success-message">${success}</p>

            <!-- LOGIN FORM -->
            <form action="${pageContext.request.contextPath}/user"
                  method="post">

                <!-- ACTION -->
                <input type="hidden"
                       name="action"
                       value="login">

                <!-- EMAIL -->
                <input type="email"
                       name="email"
                       placeholder="Enter Email"
                       value="<%= savedEmail%>"
                       required>

                <!-- PASSWORD -->
                <input type="password"
                       name="password"
                       placeholder="Enter Password"
                       required>

                <!-- LOGIN BUTTON -->
                <button type="submit">
                    Login
                </button>

            </form>

            <!-- REGISTER LINK -->
            <p>
                Don't have account?

                <a href="user?action=register">
                    Register
                </a>
            </p>

        </div>

    </body>
</html>