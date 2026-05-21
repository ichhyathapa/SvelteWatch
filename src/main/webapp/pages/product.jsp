<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.svelte.model.Product"%>

<!DOCTYPE html>
<html>


    <head>
        <title>Product</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/product.css" />


        <link
            rel="stylesheet"
            href="https://unpkg.com/boxicons@latest/css/boxicons.min.css"
            />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet"
            />

        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            />



    </head>

    <body>
        <jsp:include page="/pages/navbar.jsp" />

        <!-- PRODUCT PAGE -->

        <div class="product-page">

            <!-- FILTER SIDEBAR -->

            <!-- FILTER SIDEBAR -->

            <div class="filter-section">

                <!-- TOP BAR -->

                <div class="filter-header">

                    <h1>FILTER ITEMS</h1>

                    <button class="filter-toggle" onclick="toggleFilter()">
                        <i class="fa fa-sliders"></i>
                    </button>

                </div>

                <!-- HIDDEN FILTER CONTENT -->

                <div id="filterContent" class="filter-content">

                    <form action="${pageContext.request.contextPath}/product" method="get">

                        <div class="filter-box">

                            <h3>Gender</h3>

                            <label>
                                <input type="radio" name="gender" value="Men"> Men
                            </label>

                            <label>
                                <input type="radio" name="gender" value="Women"> Women
                            </label>

                        </div>

                        <div class="filter-box">

                            <h3>Category</h3>

                            <label>
                                <input type="checkbox" name="category" value="1"> Luxury
                            </label>

                            <label>
                                <input type="checkbox" name="category" value="2"> Sports
                            </label>

                            <label>
                                <input type="checkbox" name="category" value="4"> Casual
                            </label>

                            <label>
                                <input type="checkbox" name="category" value="5"> Classic
                            </label>

                        </div>

                        <!-- SHOW ITEMS BUTTON -->

                        <button type="submit" class="show-btn">
                            Show Items
                        </button>

                    </form>

                </div>

            </div>

            <!-- PRODUCTS -->

            <div class="products-section">

                <div class="top-title">

                    <h1>WATCH COLLECTION</h1>

                </div>

                <!-- PRODUCT GRID -->

                <div class="product-container">

                    <%

                        ArrayList<Product> products
                                = (ArrayList<Product>) request.getAttribute("products");

                        if (products != null && !products.isEmpty()) {

                            for (Product p : products) {

                    %>

                    <!-- PRODUCT CARD -->

                    <div class="product-card">

                        <div class="product-image">

                            <img src="${pageContext.request.contextPath}/watchtemp/<%= p.getImageUrl()%>"
                                 alt="watch">

                        </div>

                        <div class="product-info">

                            <h3><%= p.getProductName()%></h3>

                            <p class="gender">
                                <%= p.getGender()%>
                            </p>

                            <p class="price">
                                NPR <%= p.getPrice()%>
                            </p>
                            <!-- QUANTITY -->


                            <a href="${pageContext.request.contextPath}/product?action=details&id=<%= p.getProductId()%>">

                                <button class="details-btn">
                                    View Details
                                </button>

                            </a>

                        </div>

                    </div>

                    <%

                            }
                        } else {

                    %>
                    <!-- NO PRODUCT MESSAGE -->

                    <div class="no-product">

                        <h2>
                            Item not available currently.
                        </h2>

                        <p>
                            Please try another search or filter.
                        </p>

                    </div>
                    
                    <%

                        }

                    %>
                    
                </div>

            </div>
        </div>

        <br><br>

        <jsp:include page="/pages/footer.jsp" />

        <script>

            function toggleFilter() {

                let filter = document.getElementById("filterContent");
                if (filter.style.display === "block") {

                    filter.style.display = "none";

                } else {

                    filter.style.display = "block";
                }
            }

        </script>




    </body>
</html>