<%@page import="com.svelte.model.Product"%>

<!-- GET PRODUCT OBJECT -->
<%
    Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>

<head>

    <!-- PAGE META -->
    <meta charset="UTF-8">

    <!-- PAGE TITLE -->
    <title>Edit Product</title>

    <!-- CSS FILE -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/edit.css">

</head>

<body>

<div class="adminLayout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <!-- LOGO -->
        <div class="logo">LOGO</div>

        <!-- PANEL LABEL -->
        <p class="panelLabel">Admin Panel</p>

        <!-- NAVIGATION -->
        <ul class="navList">

            <!-- DASHBOARD -->
            <li>
                <a href="AdminServlet?action=dashboard">
                    Dashboard
                </a>
            </li>

            <!-- PRODUCTS -->
            <li class="active">
                <a href="AdminServlet?action=manageProducts">
                    Products
                </a>
            </li>

            <!-- ORDERS -->
            <li>
                <a href="AdminServlet?action=manageOrders">
                    Orders
                </a>
            </li>

            <!-- USERS -->
            <li>
                <a href="AdminServlet?action=manageUsers">
                    Users
                </a>
            </li>

            <!-- CATEGORIES -->
            <li>
                <a href="AdminServlet?action=manageCategories">
                    Categories
                </a>
            </li>

        </ul>

    </aside>

    <!-- MAIN AREA -->
    <div class="mainArea">

        <!-- TOP BAR -->
        <header class="topBar">

            <span>Edit Product</span>

        </header>

        <!-- CONTENT -->
        <main class="content">

            <!-- FORM CONTAINER -->
            <div class="formContainer">

                <!-- EDIT PRODUCT FORM -->
                <form action="${pageContext.request.contextPath}/AdminServlet"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- ACTION -->
                    <input type="hidden"
                           name="action"
                           value="updateProduct">

                    <!-- PRODUCT ID -->
                    <input type="hidden"
                           name="productId"
                           value="<%= p.getProductId() %>">

                    <!-- OLD IMAGE -->
                    <input type="hidden"
                           name="oldImage"
                           value="<%= p.getImageUrl() %>">

                    <!-- PRODUCT NAME -->
                    <label>Product Name</label>

                    <input type="text"
                           name="productName"
                           value="<%= p.getProductName() %>"
                           required>

                    <!-- CATEGORY ID -->
                    <label>Category ID</label>

                    <input type="number"
                           name="categoryId"
                           value="<%= p.getCategoryId() %>"
                           required>

                    <!-- GENDER -->
                    <label>Gender</label>

                    <input type="text"
                           name="gender"
                           value="<%= p.getGender() %>">

                    <!-- BRAND -->
                    <label>Brand</label>

                    <input type="text"
                           name="brand"
                           value="<%= p.getBrand() %>">

                    <!-- DESCRIPTION -->
                    <label>Description</label>

                    <textarea name="description"><%= p.getDescription() %></textarea>

                    <!-- STOCK QUANTITY -->
                    <label>Stock Quantity</label>

                    <input type="number"
                           name="stockQuantity"
                           value="<%= p.getStockQuantity() %>">

                    <!-- PRICE -->
                    <label>Price</label>

                    <input type="number"
                           step="0.01"
                           name="price"
                           value="<%= p.getPrice() %>">

                    <!-- IMAGE UPLOAD -->
                    <label>Upload New Image</label>

                    <input type="file"
                           name="image">

                    <br><br>

                    <!-- SUBMIT BUTTON -->
                    <button type="submit"
                            class="add-btn">

                        Update Product

                    </button>

                </form>

            </div>

        </main>

    </div>

</div>

</body>
</html>