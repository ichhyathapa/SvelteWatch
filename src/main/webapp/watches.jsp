<%@page import="java.util.List"%>
<%@page import="com.svelte.model.Product"%>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");

    if (products == null) {
        products = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Watches | Svelte</title>

    <!-- SAFE CSS PATHS (NetBeans) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/watches.css">

</head>

<body>

    <!-- NAVBAR -->
    <jsp:include page="/pages/navbar.jsp" />

    <!-- HERO SECTION -->
    <section class="hero">
        <div class="hero-content">
            <h1>Luxury Watches Collection</h1>
            <p>Timeless elegance crafted for every moment.</p>

            <a href="watches" class="btn">Explore Collection</a>
        </div>
    </section>

    <!-- FILTER SECTION -->
    <section class="filter-bar">
        <h2>Featured Timepieces</h2>
    </section>

    <!-- PRODUCT GRID -->
    <section class="products">

        <div class="product-grid">

            <% if (products != null && !products.isEmpty()) { %>

                <% for (Product p : products) { %>

                    <div class="product-card">

                        <img src="<%= p.getImageUrl() %>" alt="watch">

                        <h3><%= p.getProductName() %></h3>

                        <p class="brand"><%= p.getBrand() %></p>

                        <p class="price">Rs. <%= p.getPrice() %></p>

                        <a class="btn-small"
                           href="watchDetails?id=<%= p.getProductId() %>">
                            View Details
                        </a>

                    </div>

                <% } %>

            <% } else { %>

                <p class="empty-msg">No watches available right now.</p>

            <% } %>

        </div>

    </section>

    <!-- FOOTER -->
    <jsp:include page="/pages/footer.jsp" />

</body>
</html>