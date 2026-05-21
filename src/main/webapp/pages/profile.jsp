<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.svelte.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Profile | SVELTE</title>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/profile.css">

</head>

<body>

<!-- ========================= -->
<!-- HEADER -->
<!-- ========================= -->

<!-- NAVBAR -->
<jsp:include page="/pages/navbar.jsp" />

       

<!-- ========================= -->
<!-- MAIN DASHBOARD -->
<!-- ========================= -->

<main class="dashboard-main">
    <%
        String success
                = (String) session.getAttribute("success");

        if (success != null) {
    %>

    <div class="success-message" id="successMessage">

        <%= success%>

    </div>

    <%
            session.removeAttribute("success");
        }
    %>
    <!-- ========================= -->
    <!-- GREETING -->
    <!-- ========================= -->

    <section class="greeting-section">

        <div class="greeting-text">

            <p class="small-title">
                USER DASHBOARD
            </p>

            <h1>

                Welcome Back,

                <span>
                    <%= user != null
                        ? user.getName()
                        : "Guest" %>
                </span>

            </h1>

            <p class="sub-text">

                Manage your shopping experience,
                orders and account information
                effortlessly.

            </p>

        </div>

    </section>

    <!-- ========================= -->
    <!-- QUICK ACTIONS -->
    <!-- ========================= -->

    <section class="dashboard-section">

        <div class="section-header">

            <h2>
                Quick Actions
            </h2>

        </div>

        <div class="dashboard-grid">

            <!-- ========================= -->
            <!-- MY ORDERS -->
            <!-- ========================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    📦
                </div>

                <h3>
                    My Orders
                </h3>

                <p>

                    View your recent purchases,
                    order history and delivery
                    status updates.

                </p>

                <a href="${pageContext.request.contextPath}/order?action=viewOrders">

                    View Orders

                </a>

            </div>

            <!-- ========================= -->
            <!-- SHOPPING CART -->
            <!-- ========================= -->

            <div class="dashboard-card">

                <div class="card-icon">
                    🛒
                </div>

                <h3>
                    Shopping Cart
                </h3>

                <p>

                    Review selected watches,
                    update quantities and
                    proceed to checkout.

                </p>

                <a href="${pageContext.request.contextPath}/cart">

                    Open Cart

                </a>

            </div>

        </div>

    </section>

    <!-- ========================= -->
    <!-- ACCOUNT OVERVIEW -->
    <!-- ========================= -->

    <section class="dashboard-section">

        <div class="section-header">

            <h2>
                Account Overview
            </h2>

        </div>

        <div class="account-card">

            <!-- NAME -->

            <div class="info-row">

                <span>
                    Full Name
                </span>

                <strong>

                    <%= user != null
                        ? user.getName()
                        : "Guest" %>

                </strong>

            </div>

            <!-- EMAIL -->

            <div class="info-row">

                <span>
                    Email Address
                </span>

                <strong>

                    <%= user != null
                        ? user.getEmailAddress()
                        : "N/A" %>

                </strong>

            </div>

            <!-- ROLE -->

            <div class="info-row">

                <span>
                    Account Role
                </span>

                <strong>

                    <%= user != null
                        ? user.getRole()
                        : "User" %>

                </strong>

            </div>
                        <!-- EDIT PROFILE BUTTON -->

                        <div class="edit-profile-section">

                            <a href="${pageContext.request.contextPath}/pages/editProfile.jsp"
                               class="edit-profile-btn">
                                Edit Profile

                            </a>

                        </div>    

        </div>

    </section>

</main>
                        <script>

                         setTimeout(function(){

                             let successBox =
                                 document.getElementById(
                                     "successMessage"
                                 );

                             if(successBox){

                                 successBox.style.display = "none";
                             }

                         }, 7000);

                        </script>
</body>
</html>