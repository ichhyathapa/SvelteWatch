package com.svelte.controller;

import com.svelte.dao.CartDAO;
import com.svelte.model.Cart;
import com.svelte.model.User;
import com.svelte.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    // =========================
    // VIEW CART (GET)
    // =========================
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Cart> cartItems
                = cartDAO.getCartByUser(user.getUserId());

        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("/pages/cart.jsp")
                .forward(request, response);
    }
    // =========================
    // CART ACTIONS (POST)
    // =========================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {

            case "add":
                addToCart(request, response);
                break;

            case "remove":
                removeItem(request, response);
                break;

            case "update":
                updateQuantity(request, response);
                break;

            default:
                response.sendRedirect("cart");
        }
    }

    // =========================
    // ADD TO CART
    // =========================
    private void addToCart(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        User user
                = (User) SessionUtil.getAttribute(request, "user");

        // USER NOT LOGGED IN
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp");

            return;
        }

        int productId
                = Integer.parseInt(
                        request.getParameter("productId"));

        int quantity
                = Integer.parseInt(
                        request.getParameter("quantity"));

        Cart cart = new Cart();

        cart.setUserId(user.getUserId());
        cart.setProductId(productId);
        cart.setQuantity(quantity);

        boolean result
                = cartDAO.addToCart(cart);

        if (result) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart");

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/product");
        }
    }

    // =========================
    // REMOVE ITEM
    // =========================
    private void removeItem(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));

        cartDAO.removeCartItem(cartId);

        response.sendRedirect(
        request.getContextPath()
        + "/cart");
    }

    // =========================
    // UPDATE QUANTITY (+ / -)
    // =========================
    private void updateQuantity(HttpServletRequest request,
                                HttpServletResponse response)
            throws IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (quantity <= 0) {
            cartDAO.removeCartItem(cartId);
        } else {
            cartDAO.updateQuantity(cartId, quantity);
        }

        response.sendRedirect(
        request.getContextPath()
        + "/cart");
    }
}