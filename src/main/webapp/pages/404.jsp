<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <title>404 - Page Not Found</title>

        <!-- error css -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/error.css">

    </head>

    <body>

        <!-- error container -->
        <div class="error-container">

            <!-- error code -->
            <h1>404</h1>

            <!-- title -->
            <h2>Page Not Found</h2>

            <!-- message -->
            <p>
                The page you are looking for does not exist.
            </p>

            <!-- back button -->
            <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">

                Back To Home

            </a>

        </div>

    </body>

</html>