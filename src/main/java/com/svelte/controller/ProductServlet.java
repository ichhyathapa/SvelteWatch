package com.svelte.controller;

import com.svelte.dao.ProductDAO;
import com.svelte.model.Product;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // CREATE DAO
        ProductDAO dao = new ProductDAO();

        // GET ACTION
        String action = request.getParameter("action");

        /* ================= PRODUCT DETAILS ================= */
        if ("details".equals(action)) {

            try {

                // GET PRODUCT ID
                int id = Integer.parseInt(
                        request.getParameter("id")
                );

                // GET PRODUCT
                Product product = dao.getProductById(id);

                System.out.println(product);

                // PRODUCT NOT FOUND
                if (product == null) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/pages/error.jsp"
                    );

                    return;
                }

                // SEND PRODUCT
                request.setAttribute("product", product);

                // OPEN DETAILS PAGE
                RequestDispatcher rd
                        = request.getRequestDispatcher(
                                "/pages/watchdetails.jsp"
                        );

                rd.forward(request, response);

            } catch (Exception e) {

                e.printStackTrace();

                // ERROR PAGE
                response.sendRedirect(
                        request.getContextPath()
                        + "/pages/error.jsp"
                );
            }

            return;
        }

        /* ================= SEARCH ================= */
        if ("search".equals(action)) {

            // GET SEARCH KEYWORD
            String keyword
                    = request.getParameter("search");

            // NULL CHECK
            if (keyword == null) {

                keyword = "";
            }

            // SEARCH PRODUCTS
            ArrayList<Product> products
                    = dao.searchProducts(keyword);

            // SEND PRODUCTS
            request.setAttribute("products", products);

            // OPEN PRODUCT PAGE
            RequestDispatcher rd
                    = request.getRequestDispatcher(
                            "/pages/product.jsp"
                    );

            rd.forward(request, response);

            return;
        }

        /* ================= FILTER ================= */
        // GET FILTER VALUES
        String gender
                = request.getParameter("gender");

        String[] categories
                = request.getParameterValues("category");

        ArrayList<Product> products;

        // APPLY FILTER
        if ((gender != null && !gender.isEmpty())
                || categories != null) {

            products
                    = dao.getFilteredProducts(
                            gender,
                            categories
                    );

        } else {

            // GET ALL PRODUCTS
            products
                    = dao.getAllProducts();
        }

        // SEND PRODUCTS
        request.setAttribute("products", products);

        // OPEN PRODUCT PAGE
        RequestDispatcher rd
                = request.getRequestDispatcher(
                        "/pages/product.jsp"
                );

        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // HANDLE POST WITH GET
        doGet(request, response);
    }
}
