package com.svelte.controller;

import com.svelte.dao.OrderDAO;
import com.svelte.dao.ProductDAO;
import com.svelte.dao.UserDAO;
import com.svelte.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/AdminServlet")
@MultipartConfig
public class AdminServlet extends HttpServlet {

    ProductDAO productDAO = new ProductDAO();
    OrderDAO orderDAO = new OrderDAO();
    UserDAO userDAO = new UserDAO();

    // =========================================
    // DO GET
    // =========================================
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "dashboard";
        }

        switch (action) {

            // =========================================
            // DASHBOARD
            // =========================================
            case "dashboard":

                try {

                    request.setAttribute(
                            "totalProducts",
                            productDAO.countProducts());

                    request.setAttribute(
                            "totalOrders",
                            orderDAO.countOrders());

                    request.setAttribute(
                            "totalUsers",
                            userDAO.countUsers());

                    request.setAttribute(
                            "totalRevenue",
                            orderDAO.sumRevenue());

                    // =========================
                    // RECENT ORDERS
                    // =========================
                    request.setAttribute(
                            "recentOrders",
                            orderDAO.getRecentOrders());

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/AdminDashboard.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // MANAGE PRODUCTS
            // =========================================
            case "manageProducts":

                try {

                    request.setAttribute(
                            "productList",
                            productDAO.getAllProducts());

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageProducts.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // EDIT PRODUCT FORM
            // =========================================
            case "editProductForm":

                try {

                    int id
                            = Integer.parseInt(
                                    request.getParameter("id"));

                    Product product
                            = productDAO.getProductById(id);

                    request.setAttribute(
                            "product",
                            product);

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/editProduct.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // MANAGE ORDERS
            // =========================================
            case "manageOrders":

                try {

                    request.setAttribute(
                            "orderList",
                            orderDAO.getAllOrders());

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageOrders.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // UPDATE ORDER STATUS
            // =========================================
            case "updateOrderStatus":

                try {

                    int orderId
                            = Integer.parseInt(
                                    request.getParameter("id"));

                    String status
                            = request.getParameter("status");

                    orderDAO.updateStatus(orderId, status);

                    request.setAttribute(
                            "successMsg",
                            "Order status updated successfully.");

                    request.setAttribute(
                            "orderList",
                            orderDAO.getAllOrders());

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageOrders.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // MANAGE USERS
            // =========================================
            case "manageUsers":

                try {

                    request.setAttribute(
                            "userList",
                            userDAO.getAllUsers());

                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageUsers.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // DELETE USER
            // =========================================
            case "deleteUser":

                try {

                    int id
                            = Integer.parseInt(
                                    request.getParameter("id"));

                    userDAO.deleteUser(id);

                    request.setAttribute(
                            "successMsg",
                            "User deleted successfully.");

                    request.setAttribute(
                            "userList",
                            userDAO.getAllUsers());

                } catch (Exception e) {

                    request.setAttribute(
                            "errorMsg",
                            "Error deleting user.");

                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageUsers.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // DELETE PRODUCT
            // =========================================
            case "deleteProduct":

                try {

                    int id
                            = Integer.parseInt(
                                    request.getParameter("id"));

                    productDAO.deleteProduct(id);

                    request.setAttribute(
                            "successMsg",
                            "Product deleted successfully.");

                    request.setAttribute(
                            "productList",
                            productDAO.getAllProducts());

                } catch (Exception e) {

                    request.setAttribute(
                            "errorMsg",
                            "Error deleting product.");

                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageProducts.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // LOGOUT
            // =========================================
            case "logout":

                HttpSession session
                        = request.getSession(false);

                if (session != null) {
                    session.invalidate();
                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp");

                break;

            // =========================================
            // DEFAULT
            // =========================================
            default:

                request.getRequestDispatcher(
                        "/pages/AdminDashboard.jsp")
                        .forward(request, response);
        }
    }

    // =========================================
    // DO POST
    // =========================================
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {

            // =========================================
            // ADD PRODUCT
            // =========================================
            case "addProduct":
                try {
                    Product p = new Product();

                    p.setProductName(request.getParameter("name"));
                    p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                    p.setGender(request.getParameter("gender"));
                    p.setBrand(request.getParameter("brand"));
                    p.setPrice(Double.parseDouble(request.getParameter("price")));
                    p.setStockQuantity(Integer.parseInt(request.getParameter("stock")));
                    p.setDescription(request.getParameter("description"));

                    // IMAGE UPLOAD (null-safe)
                    Part imagePart = request.getPart("image");
                    String imageName = (imagePart != null) ? imagePart.getSubmittedFileName() : null;

                    if (imageName != null && !imageName.isEmpty()) {
                        String uploadPath = request.getServletContext().getRealPath("/images");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        imagePart.write(uploadPath + File.separator + imageName);
                    }

                    p.setImageUrl(imageName);

                    boolean result = productDAO.addProduct(p);

                    if (result) {
                        request.setAttribute("successMsg", "Product added successfully.");
                    } else {
                        request.setAttribute("errorMsg", "Failed to add product.");
                    }

                    request.setAttribute("productList", productDAO.getAllProducts());

                } catch (Exception e) {
                    request.setAttribute("errorMsg", "Error adding product.");
                    e.printStackTrace();
                }
                request.getRequestDispatcher("/pages/manageProducts.jsp")
                        .forward(request, response);
                break;

            // =========================================
            // UPDATE PRODUCT
            // =========================================
            case "updateProduct":

                try {

                    Product product = new Product();

                    product.setProductId(
                            Integer.parseInt(
                                    request.getParameter("productId")));

                    product.setProductName(
                            request.getParameter("productName"));

                    product.setCategoryId(
                            Integer.parseInt(
                                    request.getParameter("categoryId")));

                    product.setGender(
                            request.getParameter("gender"));

                    product.setBrand(
                            request.getParameter("brand"));

                    product.setDescription(
                            request.getParameter("description"));

                    product.setStockQuantity(
                            Integer.parseInt(
                                    request.getParameter("stockQuantity")));

                    product.setPrice(
                            Double.parseDouble(
                                    request.getParameter("price")));

                    // IMAGE
                    Part imagePart
                            = request.getPart("image");

                    String imageName
                            = imagePart.getSubmittedFileName();

                    if (imageName != null
                            && !imageName.isEmpty()) {

                        String uploadPath
                                = request.getServletContext()
                                        .getRealPath("/watchtemp");

                        File uploadDir
                                = new File(uploadPath);

                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        imagePart.write(
                                uploadPath
                                + File.separator
                                + imageName);

                        product.setImageUrl(imageName);

                    } else {

                        product.setImageUrl(
                                request.getParameter("oldImage"));
                    }

                    boolean result
                            = productDAO.updateProduct(product);

                    if (result) {

                        request.setAttribute(
                                "successMsg",
                                "Product updated successfully.");

                    } else {

                        request.setAttribute(
                                "errorMsg",
                                "Failed to update product.");
                    }

                    request.setAttribute(
                            "productList",
                            productDAO.getAllProducts());

                } catch (Exception e) {

                    request.setAttribute(
                            "errorMsg",
                            "Error updating product.");

                    e.printStackTrace();
                }

                request.getRequestDispatcher(
                        "/pages/manageProducts.jsp")
                        .forward(request, response);

                break;

            // =========================================
            // DEFAULT
            // =========================================
            default:

                response.sendRedirect(
                        "AdminServlet?action=dashboard");
        }
    }
    // =========================================
// UPDATE ORDER STATUS METHOD
// =========================================

    private void updateOrderStatus(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int orderId
                    = Integer.parseInt(
                            request.getParameter("orderId"));

            String status
                    = request.getParameter("status");

            boolean result
                    = orderDAO.updateStatus(orderId, status);

            if (result) {

                request.setAttribute(
                        "successMsg",
                        "Order status updated successfully.");

            } else {

                request.setAttribute(
                        "errorMsg",
                        "Failed to update order status.");
            }

            request.setAttribute(
                    "orderList",
                    orderDAO.getAllOrders());

            request.getRequestDispatcher(
                    "/pages/manageOrders.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMsg",
                    "Error updating order status.");

            request.setAttribute(
                    "orderList",
                    orderDAO.getAllOrders());

            request.getRequestDispatcher(
                    "/pages/manageOrders.jsp")
                    .forward(request, response);
        }
    }
}
