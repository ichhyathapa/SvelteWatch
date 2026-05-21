<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.svelte.model.User"%>

<!doctype html>
<html>

    <head>

        <!-- PAGE META -->
        <meta charset="UTF-8"/>

        <!-- PAGE TITLE -->
        <title>Manage Users</title>

        <!-- ADMIN CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/admin.css"/>

    </head>

    <body>

        <div class="adminLayout">

            <!-- SIDEBAR -->
            <aside class="sidebar">

                <!-- LOGO -->
                <div class="logo">
                    SVELTE
                </div>

                <!-- PANEL LABEL -->
                <p class="panelLabel">
                    Admin Panel
                </p>

                <!-- NAVIGATION -->
                <ul class="navList">

                    <!-- DASHBOARD -->
                    <li>
                        <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard">
                            Dashboard
                        </a>
                    </li>

                    <!-- PRODUCTS -->
                    <li>
                        <a href="${pageContext.request.contextPath}/AdminServlet?action=manageProducts">
                            Products
                        </a>
                    </li>

                    <!-- ORDERS -->
                    <li>
                        <a href="${pageContext.request.contextPath}/AdminServlet?action=manageOrders">
                            Orders
                        </a>
                    </li>

                    <!-- USERS -->
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/AdminServlet?action=manageUsers">
                            Users
                        </a>
                    </li>

                    <!-- LOGOUT -->
                    <li class="logout">
                        <a href="${pageContext.request.contextPath}/logout">
                            Logout
                        </a>
                    </li>

                </ul>

            </aside>

            <!-- MAIN AREA -->
            <div class="mainArea">

                <!-- TOP BAR -->
                <header class="topBar">
                    <span>Manage Users</span>
                </header>

                <!-- CONTENT -->
                <main class="content">

                    <!-- PAGE HEADER -->
                    <div class="pageHeader">
                        <h2>All Users</h2>
                    </div>

                    <!-- SUCCESS MESSAGE -->
                    <% if (request.getAttribute("successMsg") != null) {%>

                    <div class="successMsg">
                        <%= request.getAttribute("successMsg")%>
                    </div>

                    <% } %>

                    <!-- ERROR MESSAGE -->
                    <% if (request.getAttribute("errorMsg") != null) {%>

                    <div class="errorMsg">
                        <%= request.getAttribute("errorMsg")%>
                    </div>

                    <% } %>

                    <!-- USERS TABLE -->
                    <table class="dataTable">

                        <!-- TABLE HEADER -->
                        <thead>

                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>

                        </thead>

                        <!-- TABLE BODY -->
                        <tbody>

                            <%
                                List<User> userList = (List<User>) request.getAttribute("userList");

                                if (userList != null && !userList.isEmpty()) {

                                    for (User u : userList) {
                            %>

                            <!-- USER ROW -->
                            <tr>

                                <!-- USER ID -->
                                <td><%= u.getUserId()%></td>

                                <!-- USER NAME -->
                                <td><%= u.getName()%></td>

                                <!-- USER EMAIL -->
                                <td><%= u.getEmailAddress()%></td>

                                <!-- USER ROLE -->
                                <td><%= u.getRole()%></td>

                                <!-- ACTIONS -->
                                <td>

                                    <!-- DELETE BUTTON -->
                                    <a class="btnDelete"
                                       href="AdminServlet?action=deleteUser&id=<%= u.getUserId()%>"
                                       onclick="return confirm('Delete user <%= u.getName()%>?')">
                                        Delete
                                    </a>

                                </td>

                            </tr>

                            <%
                                }

                            } else {
                            %>

                            <!-- NO USERS ROW -->
                            <tr>

                                <td colspan="5" style="text-align:center; color:#6b7280;">
                                    No users found.
                                </td>

                            </tr>

                            <%
                                }
                            %>

                        </tbody>

                    </table>

                </main>

            </div>

        </div>

    </body>

</html>