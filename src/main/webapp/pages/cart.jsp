<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.svelte.model.Cart"%>
<%@page import="java.util.List"%>
<%
    List<Cart> cartItems =
            (List<Cart>) request.getAttribute("cartItems");
%>
<%
    double subtotal = 0;

    if(cartItems != null){

        for(Cart cart : cartItems){

            subtotal +=
                    cart.getPrice()
                    * cart.getQuantity();
        }
    }

    double vat = subtotal * 0.13;

    double total = subtotal + vat;
%>



<!DOCTYPE html>
<html>

<head>

    <title>Shopping Cart | SVELTE</title>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/cart.css">


</head>

<body>

<!-- ========================= -->
<!-- NAVBAR -->
<!-- ========================= -->

<!-- NAVBAR -->
        <jsp:include page="/pages/navbar.jsp" />


<!-- ========================= -->
<!-- HERO -->
<!-- ========================= -->

<section class="cart-hero">

    <h1>Your Shopping Cart</h1>

    <p>
        Review your selected watches and
        proceed to secure checkout.
    </p>

</section>

<!-- ========================= -->
<!-- MAIN CART SECTION -->
<!-- ========================= -->

<div class="cart-container">

    <!-- ========================= -->
    <!-- LEFT SIDE -->
    <!-- ========================= -->

    <div class="cart-items">

        <div class="section-title">

            <h2>Cart Items</h2>

        </div>

        <%
            if(cartItems == null || cartItems.isEmpty()) {
        %>

        <!-- EMPTY CART -->

        <div class="empty-cart">

            <h3>Your cart is empty</h3>

            <p>
                Add watches to your cart
                to continue shopping.
            </p>

            <a href="${pageContext.request.contextPath}/product">
                Continue Shopping
            </a>

        </div>

        <%
            } else {

                for(Cart cart : cartItems) {
        %>

        <!-- ========================= -->
        <!-- CART CARD -->
        <!-- ========================= -->

        <div class="cart-card">

            <!-- IMAGE -->

            <div class="cart-image">

                <img src="${pageContext.request.contextPath}/watchtemp/<%= cart.getImageUrl()%>"
                     alt="Watch">

            </div>

            <!-- DETAILS -->

            <div class="cart-details">

                <h3><%= cart.getProductName() %></h3>

                <p>
                    Brand: <%= cart.getBrand() %>
                </p>

                <div class="item-meta">

                    <span class="price">
                        Rs. <%= cart.getPrice() %>
                    </span>

                    <span class="stock">
                        In Stock
                    </span>

                </div>

                <!-- QUANTITY -->

                <div class="quantity-box">

                    <!-- MINUS -->

                    <form action="${pageContext.request.contextPath}/cart"
                          method="post">

                        <input type="hidden"
                               name="action"
                               value="update">

                        <input type="hidden"
                               name="cartId"
                               value="<%= cart.getCartId() %>">

                        <input type="hidden"
                               name="quantity"
                               value="<%= cart.getQuantity() - 1 %>">

                        <button type="submit">
                            -
                        </button>

                    </form>

                    <!-- CURRENT QUANTITY -->

                    <span>
                        <%= cart.getQuantity() %>
                    </span>

                    <!-- PLUS -->

                    <form action="${pageContext.request.contextPath}/cart"
                          method="post">

                        <input type="hidden"
                               name="action"
                               value="update">

                        <input type="hidden"
                               name="cartId"
                               value="<%= cart.getCartId() %>">

                        <input type="hidden"
                               name="quantity"
                               value="<%= cart.getQuantity() + 1 %>">

                        <button type="submit">
                            +
                        </button>

                    </form>

                </div>

                <!-- ACTION BUTTONS -->

                <div class="cart-actions">

                    <!-- REMOVE BUTTON -->

                    <form action="${pageContext.request.contextPath}/cart"
                          method="post">

                        <input type="hidden"
                               name="action"
                               value="remove">

                        <input type="hidden"
                               name="cartId"
                               value="<%= cart.getCartId() %>">

                        <button type="submit"
                                class="remove-btn">

                            Remove

                        </button>

                    </form>

                    <!-- VIEW PRODUCT -->

                    <a href="${pageContext.request.contextPath}/product?action=details&id=<%= cart.getProductId()%>"
                       class="save-btn">

                        View Product

                    </a>

                </div>

            </div>

        </div>

        <%
                }
            }
        %>

    </div>

    <!-- ========================= -->
    <!-- RIGHT SIDE -->
    <!-- ========================= -->

    <div class="cart-summary">

        <div class="summary-card">

            <h2>Order Summary</h2>

            <div class="summary-row">

                <span>Items</span>

                <span>
                    <%= cartItems != null ? cartItems.size() : 0 %>
                </span>

            </div>

                    <div class="summary-row">

                        <span>Subtotal</span>

                        <span>
                            Rs. <%= subtotal%>
                        </span>

                    </div>

                    <div class="summary-row">

                        <span>VAT (13%)</span>

                        <span>
                            Rs. <%= vat%>
                        </span>

                    </div>

            <hr>

            <div class="summary-total">

                <span>Total</span>

                <span>
                    Rs. <%= total%>
                </span>

            </div>

            <!-- CHECKOUT -->

            <<form action="${pageContext.request.contextPath}/order"
                   method="post">

                <input type="hidden"
                       name="action"
                       value="placeOrder">

                <button type="submit"
                        class="checkout-btn">

                    Buy Now

                </button>

            </form>

            <!-- CONTINUE SHOPPING -->

            <a href="${pageContext.request.contextPath}/product"
               class="continue-shopping">

                Continue Shopping

            </a>
        </div>

        <!-- SECURITY BOX -->

        <div class="secure-box">

            <h3>Secure Checkout</h3>

            <p>
                All payments are encrypted and
                securely processed.
            </p>

        </div>

    </div>

</div>

</body>
</html>