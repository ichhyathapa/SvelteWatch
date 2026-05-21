<%@page import="java.util.List"%>
<%@page import="com.svelte.model.Order"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html>

    <head>

        <meta charset="UTF-8"/>

        <title>Admin Dashboard</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/admin.css"/>

    </head>

    <body>

        <div class="adminLayout">

            <!-- SIDEBAR -->

            <aside class="sidebar">

                <div class="brandRow">

                    <span class="brandName">
                        SVELTE
                    </span>

                </div>

                <!-- PANEL TITLE -->
                <p class="panelLabel">
                    Admin Panel
                </p>


                <!-- NAVIGATION -->

                <ul class="navList">

                    <!-- DASHBOARD -->
                    <li class="active">

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
                    <li>

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

                <header class="topBar">

                    <span>
                        Welcome, Admin
                    </span>

                </header>


                <!-- PAGE CONTENT -->
                <main class="content">

                    <!-- PAGE HEADER -->
                    <div class="pageHeader">

                        <h2>
                            Dashboard Overview
                        </h2>

                    </div>

                    <!-- METRIC CARDS -->
                    <div class="cardRow">

                        <!-- TOTAL PRODUCTS -->
                        <div class="card">

                            <h3>Total Products</h3>

                            <p class="metric">

                                <%= request.getAttribute("totalProducts") != null
                                        ? request.getAttribute("totalProducts")
                                        : "0"%>

                            </p>

                        </div>

                        <!-- TOTAL ORDERS -->
                        <div class="card">

                            <h3>Total Orders</h3>

                            <p class="metric">

                                <%= request.getAttribute("totalOrders") != null
                                        ? request.getAttribute("totalOrders")
                                        : "0"%>

                            </p>

                        </div>

                        <!-- TOTAL USERS -->
                        <div class="card">

                            <h3>Total Users</h3>

                            <p class="metric">

                                <%= request.getAttribute("totalUsers") != null
                                        ? request.getAttribute("totalUsers")
                                        : "0"%>

                            </p>

                        </div>

                        <!-- TOTAL REVENUE -->
                        <div class="card">

                            <h3>Total Revenue</h3>

                            <p class="metric">

                                NPR
                                <%= request.getAttribute("totalRevenue") != null
                                        ? request.getAttribute("totalRevenue")
                                        : "0.00"%>

                            </p>

                        </div>

                    </div>

                    <!-- RECENT ORDERS SECTION -->
                    <div class="bottom">

                        <div class="recentBox">

                            <h3>
                                Recent Orders
                            </h3>

                            <%
                                List<Order> recentOrders
                                        = (List<Order>) request.getAttribute("recentOrders");
                            %>

                            <!-- RECENT ORDERS LIST -->
                            <ul class="recentList">

                                <%
                                    if (recentOrders != null && !recentOrders.isEmpty()) {

                                        for (Order order : recentOrders) {
                                %>

                                <!-- SINGLE ORDER -->
                                <li>

                                    <span>

                                        Order #<%= order.getOrderId()%>

                                    </span>

                                    <span>

                                        Rs. <%= order.getTotalAmount()%>

                                    </span>

                                </li>

                                <%
                                    }

                                } else {
                                %>

                                <!-- NO ORDERS -->
                                <li>

                                    <span>
                                        No recent orders
                                    </span>

                                </li>

                                <%
                                    }
                                %>

                            </ul>

                        </div>

                    </div>

                </main>

            </div>

        </div>