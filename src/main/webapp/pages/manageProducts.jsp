<%@page import="java.util.List"%>
<%@page import="com.svelte.model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Manage Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
</head>

<body>
<div class="adminLayout">

    <!-- SIDEBAR -->
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

            <li class="active">

                <a href="${pageContext.request.contextPath}/AdminServlet?action=manageProducts">

                    Products

                </a>

            </li>

            <li>

                <a href="${pageContext.request.contextPath}/AdminServlet?action=manageOrders">

                    Orders

                </a>

            </li>

            <li>

                <a href="${pageContext.request.contextPath}/AdminServlet?action=manageUsers">

                    Users

                </a>

            </li>


            <li class="logout">

                <a href="${pageContext.request.contextPath}/logout">

                    Logout

                </a>

            </li>

        </ul>

    </aside>

    <div class="mainArea">
        <header class="topBar"><span>Manage Products</span></header>

        <main class="content">

            <div class="pageHeader">
                <h2>Products</h2>
                <a href="${pageContext.request.contextPath}/pages/addProduct.jsp"
                   class="add-btn">
                    + Add Product
                </a>
            </div>

            <!-- Messages -->
            <% if (request.getAttribute("successMsg") != null) { %>
                <p class="successMsg"><%= request.getAttribute("successMsg") %></p>
            <% } %>

            <% if (request.getAttribute("errorMsg") != null) { %>
                <p class="errorMsg"><%= request.getAttribute("errorMsg") %></p>
            <% } %>

            <!-- TABLE -->
            <table class="dataTable">

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>  
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>

                <% if (productList != null && !productList.isEmpty()) {
                    for (Product p : productList) { %>

                    <tr>
                        <td><%= p.getProductId() %></td>

                        <!-- IMAGE COLUMN -->
                        <td>
                            <img src="${pageContext.request.contextPath}/watchtemp/<%= p.getImageUrl() %>"
                                 width="60"
                                 height="60"
                                 style="object-fit:cover; border-radius:6px;">
                        </td>

                        <td><%= p.getProductName() %></td>
                        <td><%= p.getCategoryId() %></td>
                        <td>NPR <%= p.getPrice() %></td>
                        <td><%= p.getStockQuantity() %></td>

                        <td>
                            <a href="AdminServlet?action=editProductForm&id=<%= p.getProductId() %>"
                               class="btnEdit">Edit</a>

                            <a href="AdminServlet?action=deleteProduct&id=<%= p.getProductId() %>"
                               class="btnDelete"
                               onclick="return confirm('Delete this product?')">
                               Delete
                            </a>
                        </td>
                    </tr>

                <% } } else { %>

                    <tr>
                        <td colspan="7" style="text-align:center;">
                            No products found.
                        </td>
                    </tr>

                <% } %>

                </tbody>
            </table>

        </main>
    </div>
</div>
</body>
</html>