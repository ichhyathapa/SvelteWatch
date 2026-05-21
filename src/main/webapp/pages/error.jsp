<%@page isErrorPage="true" contentType="text/html"
        pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <title>System Error</title>

        <!-- error css -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/error.css">

    </head>

    <body>

        <!-- error container -->
        <div class="error-container">

            <!-- error code -->
            <h1>500</h1>

            <!-- title -->
            <h2>Internal Server Error</h2>

            <!-- message -->
            <p>
                Something went wrong while processing your request.
            </p>

            <!-- optional exception message -->
            <%
                if (exception != null) {
            %>

            <p class="error-details">

                <%= exception.getMessage()%>

            </p>

            <%
                }
            %>

            <!-- back button -->
            <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">

                Back To Home

            </a>

        </div>

    </body>

</html>