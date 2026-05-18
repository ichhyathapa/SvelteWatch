<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SvelteWatch Login</title>
        <link rel="stylesheet"href="css/login.css">

    </head>

    <body>

        <div class="container">

            <h2>Login</h2>
            <p class="error-message">${error}</p>
            <p class="success-message">${success}</p>

            <form action="user" method="post">
                <input type="hidden"
                       name="action"
                       value="login">

                <input type="email"
                       name="email"
                       placeholder="Enter Email"
                       required>

                <input type="password"
                       name="password"
                       placeholder="Enter Password"
                       required>

                <button type="submit">
                    Login
                </button>

            </form>

            <p>Don't have account?
                <a href="user?action=register">Register</a>
            </p>

        </div>

    </body>
</html>