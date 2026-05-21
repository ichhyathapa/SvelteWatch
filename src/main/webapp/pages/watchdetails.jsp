<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.svelte.model.Product"%>

<!-- GET PRODUCT -->
<%
    Product p = (Product) request.getAttribute("product");

    if (p == null) {
        response.sendRedirect(
            request.getContextPath() + "/product"
        );
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
           <!-- PAGE TITLE -->
        <title>Product Details</title>

        <!-- PAGE CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/watchdetails.css" />

        <!-- BOX ICONS -->
        <link
            rel="stylesheet"
            href="https://unpkg.com/boxicons@latest/css/boxicons.min.css"
            />

        <!-- GOOGLE FONTS -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet"
            />

        <!-- FONT AWESOME -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            />



    </head>

    <body>

        <!-- HEADER -->

        <jsp:include page="/pages/navbar.jsp" />


        <div class="details-container">

            <!-- LEFT IMAGE -->

            <div class="left">

                <img src="${pageContext.request.contextPath}/watchtemp/<%= p.getImageUrl()%>"
                     alt="watch">

            </div>

            <!-- RIGHT DETAILS -->

            <div class="right">

                <h1><%= p.getProductName()%></h1>

                <h2>NPR <%= p.getPrice()%></h2>

                <p class="description">
                    <%= p.getDescription()%>
                </p>

                <div class="product-extra">

                    <p>
                        <strong>Brand:</strong>
                        <%= p.getBrand()%>
                    </p>

                    <p>
                        <strong>Gender:</strong>
                        <%= p.getGender()%>
                    </p>





                </div>


                <!-- QUANTITY + BUTTON -->

                <form action="${pageContext.request.contextPath}/cart"
                      method="post">

                    <div class="cart-section">

                        <!-- HIDDEN ACTION -->

                        <input type="hidden"
                               name="action"
                               value="add">

                        <!-- PRODUCT ID -->

                        <input type="hidden"
                               name="productId"
                               value="<%= p.getProductId()%>">

                        <!-- QUANTITY -->

                        <div class="quantity-box">

                            <button type="button"
                                    onclick="increaseQuantity(); return false;">

                                +

                            </button>

                            <input type="text"
                                   id="quantity"
                                   name="quantity"
                                   value="1"
                                   readonly>

                            <button type="button"
                                    onclick="decreaseQuantity(); return false;">

                                -

                            </button>

                        </div>

                        <!-- ADD TO CART -->

                        <button type="submit"
                                class="cart-btn">

                            ADD TO CART

                        </button>

                    </div>

                </form>

            </div>

        </div>

       <!-- YOU MIGHT ALSO LIKE -->

       <section class="related-products">

           <h2>YOU MIGHT ALSO LIKE</h2>

           <div class="related-grid">

               <a href="${pageContext.request.contextPath}/product?action=details&id=8"
                  class="related-card">

                   <img src="${pageContext.request.contextPath}/watchtemp/m8.png"
                        alt="watch">

                   <h3>Rolex (Platinum Lee Blue)</h3>

                   <p>NPR 9000</p>

               </a>

               <a href="${pageContext.request.contextPath}/product?action=details&id=11"
                  class="related-card">

                   <img src="${pageContext.request.contextPath}/watchtemp/w3.png"
                        alt="watch">

                   <h3>Rolex (Lady President)</h3>

                   <p>NPR 10200</p>

               </a>

               <a href="${pageContext.request.contextPath}/product?action=details&id=5"
                  class="related-card">

                   <img src="${pageContext.request.contextPath}/watchtemp/m3.png"
                        alt="watch">

                   <h3>Audemars Piguet (Swiss Luxury)</h3>

                   <p>NPR 12000</p>

               </a>

               <a href="${pageContext.request.contextPath}/product?action=details&id=14"
                  class="related-card">

                   <img src="${pageContext.request.contextPath}/watchtemp/w6.png"
                        alt="watch">

                   <h3>Casio (LTP-V007D)</h3>

                   <p>NPR 3200</p>

               </a>

           </div>

       </section>
        <script>

            function increaseQuantity() {

                let quantity = document.getElementById("quantity");

                let value = parseInt(quantity.value);

                quantity.value = value + 1;
            }

            function decreaseQuantity() {

                let quantity = document.getElementById("quantity");

                let value = parseInt(quantity.value);

                if (value > 1) {

                    quantity.value = value - 1;
                }
            }

        </script>

        <!-- FOOTER -->
        <jsp:include page="/pages/footer.jsp" />

    </body>
</html>