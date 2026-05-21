<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.svelte.model.Order"%>

<%
    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Orders | Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/manageOrders.css">

</head>

<body>

<div class="adminLayout">

    <!-- ========================= -->
    <!-- SIDEBAR -->
    <!-- ========================= -->

    <aside class="sidebar">

        <div class="logo">
            SVELTE
        </div>

        <p class="panelLabel">
            Admin Panel
        </p>

        <ul class="navList">

            <li>
                <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard">
                    Dashboard
                </a>
            </li>

            <li>
                <a href="AdminServlet?action=manageProducts">
                    Products
                </a>
            </li>

            <li class="active">
                <a href="AdminServlet?action=manageOrders">
                    Orders
                </a>
            </li>

            <li>
                <a href="AdminServlet?action=manageUsers">
                    Users
                </a>
            </li>

            

            <li class="logout">
                <a href="AdminServlet?action=logout">
                    Logout
                </a>
            </li>

        </ul>

    </aside>

    <!-- ========================= -->
    <!-- MAIN AREA -->
    <!-- ========================= -->

    <div class="mainArea">

        <!-- TOPBAR -->

        <header class="topBar">

            <h2>
                Manage Orders
            </h2>

        </header>

        <!-- CONTENT -->

        <main class="content">

            <!-- SUCCESS MESSAGE -->

            <%
                String successMsg =
                        (String) request.getAttribute("successMsg");

                if(successMsg != null){
            %>

            <div class="successBox">

                <%= successMsg %>

            </div>

            <%
                }
            %>

            <!-- TABLE -->

            <div class="table-container">

                <table class="orderTable">

                    <thead>

                    <tr>

                        <th>Order ID</th>

                        <th>Customer</th>

                        <th>Total Amount</th>

                        <th>Status</th>

                        <th>Created At</th>

                        <th>Actions</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        if(orderList != null && !orderList.isEmpty()) {

                            for(Order order : orderList) {
                    %>

                    <tr>

                        <!-- ORDER ID -->

                        <td>
                            #<%= order.getOrderId() %>
                        </td>

                        <!-- CUSTOMER -->

                        <td>
                            <%= order.getCustomerName() != null
                                    ? order.getCustomerName()
                                    : "User #" + order.getUserId()
                            %>
                        </td>

                        <!-- TOTAL -->

                        <td>
                            Rs. <%= order.getTotalAmount() %>
                        </td>

                        <!-- STATUS -->

                        <td>

                            <span class="status
                                  <%= order.getStatus().toLowerCase() %>">

                                <%= order.getStatus() %>

                            </span>

                        </td>

                        <!-- DATE -->

                        <td>
                            <%= order.getCreatedAt() %>
                        </td>

                        <!-- ACTIONS -->

                        <td class="actionBtns">

                            <form action="AdminServlet"
                                  method="post">

                                <input type="hidden"
                                       name="action"
                                       value="updateOrderStatus">

                                <input type="hidden"
                                       name="orderId"
                                       value="<%= order.getOrderId()%>">

                                <select name="status"
                                        class="statusSelect">

                                    <option value="Pending"
                                            <%= order.getStatus().equals("Pending")
                        ? "selected"
                        : ""%>>
                                        Pending
                                    </option>

                                    <option value="Processing"
                                            <%= order.getStatus().equals("Processing")
                        ? "selected"
                        : ""%>>
                                        Processing
                                    </option>

                                    <option value="Shipped"
                                            <%= order.getStatus().equals("Shipped")
                        ? "selected"
                        : ""%>>
                                        Shipped
                                    </option>

                                    <option value="Delivered"
                                            <%= order.getStatus().equals("Delivered")
                        ? "selected"
                        : ""%>>
                                        Delivered
                                    </option>

                                    <option value="Cancelled"
                                            <%= order.getStatus().equals("Cancelled")
                        ? "selected"
                        : ""%>>
                                        Cancelled
                                    </option>

                                </select>

                                <button type="submit"
                                        class="updateBtn">

                                    Update

                                </button>

                            </form>

                        </td>

                    </tr>

                    <%
                            }
                        } else {
                    %>

                    <!-- EMPTY -->

                    <tr>

                        <td colspan="6"
                            class="emptyRow">

                            No orders found.

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </main>

    </div>

</div>

</body>
</html>