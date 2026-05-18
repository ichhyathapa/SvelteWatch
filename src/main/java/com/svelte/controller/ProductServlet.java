package com.svelte.controller;

import com.svelte.dao.ProductDAO;
import com.svelte.model.Product;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
                
        List<Product> products = dao.getAllProducts(); // IMPORTANT

        request.setAttribute("products", products);
        RequestDispatcher rd = request.getRequestDispatcher("watches.jsp");
        rd.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
