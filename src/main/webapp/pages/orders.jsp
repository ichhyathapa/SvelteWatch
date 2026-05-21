<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.svelte.model.Order"%>

<!-- GET ORDERS -->
<%
    List<Order> orders
            = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>

    <head>

        <!-- PAGE TITLE -->
        <title>My Orders | SVELTE</title>

        <!-- META -->
        <meta charset="UTF-8">

        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">

        <!-- CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/orders.css">

    </head>

    <body>

        <!-- ORDER SUCCESS MESSAGE -->
        <%
            String orderSuccess
                    = (String) session.getAttribute(
                            "orderSuccess"
                    );

            if (orderSuccess != null) {
        %>

        <!-- SUCCESS POPUP -->
        <div class="success-popup"
             id="successPopup">

            <!-- SUCCESS ICON -->
            <div class="success-icon">
                ✓
            </div>

            <!-- SUCCESS TITLE -->
            <h3>
                Order Confirmed
            </h3>

            <!-- SUCCESS MESSAGE -->
            <p>
                <%= orderSuccess%>
            </p>

        </div>

        <%
                session.removeAttribute(
                        "orderSuccess"
                );
            }
        %>

        <!-- NAVBAR -->
        <jsp:include page="/pages/navbar.jsp" />

        <!-- HERO SECTION -->
        <section class="orders-hero">

            <h1>My Orders</h1>

            <p>
                Track your recent purchases and
                order history.
            </p>

        </section>

        <!-- ORDERS CONTAINER -->
        <div class="orders-container">

            <%
                if (orders == null || orders.isEmpty()) {
            %>

            <!-- EMPTY ORDERS -->
            <div class="empty-orders">

                <h2>No Orders Yet</h2>

                <p>
                    You haven't placed any orders yet.
                </p>

                <!-- SHOP BUTTON -->
                <a href="${pageContext.request.contextPath}/product">
                    Start Shopping
                </a>

            </div>

            <%
            } else {

                for (Order order : orders) {
            %>

            <!-- ORDER CARD -->
            <div class="order-card">

                <!-- ORDER TOP -->
                <div class="order-top">

                    <!-- ORDER INFO -->
                    <div>

                        <h3>
                            Order #<%= order.getOrderId()%>
                        </h3>

                        <p>
                            <%= order.getCreatedAt()%>
                        </p>

                    </div>

                    <!-- ORDER STATUS -->
                    <div class="status <%= order.getStatus().toLowerCase()%>">

                        <%= order.getStatus()%>

                    </div>

                </div>

                <!-- ORDER BOTTOM -->
                <div class="order-bottom">

                    <!-- ORDER AMOUNT -->
                    <div class="amount">

                        Rs. <%= order.getTotalAmount()%>

                    </div>

                    <!-- DETAILS BUTTON -->
                    <a href="${pageContext.request.contextPath}/order?action=details&id=<%= order.getOrderId()%>">

                        <button>
                            View Details
                        </button>

                    </a>

                </div>

            </div>

            <%
                    }
                }
            %>

        </div>

        <!-- AUTO HIDE POPUP -->
        <script>

            setTimeout(function () {

                let popup =
                        document.getElementById(
                                "successPopup"
                                );

                if (popup) {

                    popup.style.display = "none";
                }

            }, 7000);

        </script>

    </body>
</html>