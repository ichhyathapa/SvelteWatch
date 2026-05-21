<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <title>403 - Unauthorized Access</title>

    <!-- error css -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/error.css">

</head>

<body>

    <!-- error container -->
    <div class="error-container">

        <!-- error code -->
        <h1>403</h1>

        <!-- title -->
        <h2>Unauthorized Access</h2>

        <!-- message -->
        <p>
            You do not have permission to access this page.
        </p>

        <!-- back button -->
        <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">

            Return To Dashboard

        </a>

    </div>

</body>

</html>