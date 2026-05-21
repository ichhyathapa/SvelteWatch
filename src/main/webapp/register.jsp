<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        
        <!-- PAGE TITLE -->
        <title>SvelteWatch Register</title>

        <!-- LOGIN CSS -->
        <link rel="stylesheet"
              href="css/login.css">

    </head>

    <body>
        <!-- REGISTER CONTAINER -->
        <div class="container">

            <h2>Create Account</h2>

            <!-- ERROR MESSAGE -->
            <p style="color:red;">
                ${error}
            </p>

            <!-- SUCCESS MESSAGE -->
            <p style="color:green;">
                ${success}
            </p>

             <!-- REGISTER FORM -->
            <form action="user" method="post">

                <!-- ACTION -->
                <input type="hidden"
                       name="action"
                       value="register">

                <!-- NAME -->
                <input type="text"
                       name="name"
                       placeholder="Full Name"
                       required>

                <!-- EMAIL -->
                <input type="email"
                       name="email"
                       placeholder="Email Address"
                       required>

                <!-- PASSWORD -->
                <input type="password"
                       name="password"
                       placeholder="Password"
                       required>

                <!-- REGISTER BUTTON -->
                <button type="submit">
                    Register
                </button>
                
                
            <!-- LOGIN LINK -->
            </form>

            <p>
                Already have an account?

                <a href="login.jsp">
                    Login
                </a>
            </p>

        </div>

    </body>
</html>