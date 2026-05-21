<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.svelte.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <title>Edit Profile | SVELTE</title>

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
<!-- MAIN SECTION -->
<!-- ========================= -->

<main class="dashboard-main">

    <section class="dashboard-section">

        <div class="section-header">

            <h2>
                Edit Profile
            </h2>

        </div>

        <!-- ========================= -->
        <!-- FORM CARD -->
        <!-- ========================= -->

        <div class="account-card">
            <%
                String error
                        = (String) request.getAttribute("error");

                if (error != null) {
            %>

            <p style="color:red;
              margin-bottom:20px;">

                <%= error%>

            </p>

            <%
                }
            %>
            
            <form action="${pageContext.request.contextPath}/user"
                  method="post"
                  class="edit-form">

                <!-- ACTION -->

                <input type="hidden"
                       name="action"
                       value="updateProfile">

                <!-- USER ID -->

                <input type="hidden"
                       name="userId"
                       value="<%= user.getUserId() %>">

                <!-- NAME -->

                <div class="form-group">

                    <label>
                        Full Name
                    </label>

                    <input type="text"
                           name="name"
                           value="<%= user.getName() %>"
                           required>

                </div>

                <!-- EMAIL -->

                <div class="form-group">

                    <label>
                        Email Address
                    </label>

                    <input type="email"
                           name="email"
                           value="<%= user.getEmailAddress() %>"
                           required>

                </div>

                <!-- PASSWORD -->

                <!-- CURRENT PASSWORD -->

                <div class="form-group">

                    <label>
                        Current Password
                    </label>

                    <input type="password"
                           name="currentPassword"
                           required>

                </div>

                <!-- NEW PASSWORD -->

                <div class="form-group">

                    <label>
                        New Password
                    </label>

                    <input type="password"
                           name="newPassword"
                           placeholder="Enter new password">

                </div>

                <!-- CONFIRM PASSWORD -->

                <div class="form-group">

                    <label>
                        Confirm New Password
                    </label>

                    <input type="password"
                           name="confirmPassword"
                           placeholder="Confirm new password">

                </div>

                <!-- BUTTON -->

                <button type="submit"
                        class="edit-profile-btn">

                    Save Changes

                </button>

            </form>

        </div>

    </section>

</main>

</body>
</html>