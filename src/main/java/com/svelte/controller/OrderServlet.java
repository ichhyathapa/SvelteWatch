package com.svelte.controller;

import com.svelte.dao.CartDAO;
import com.svelte.dao.OrderDAO;
import com.svelte.model.Cart;
import com.svelte.model.Order;
import com.svelte.model.User;
import com.svelte.util.SessionUtil;
import com.svelte.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

    // ORDER DAO
    private OrderDAO orderDAO;

    @Override
    public void init() {

        // INITIALIZE DAO
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET ACTION
        String action = request.getParameter("action");

        // CHECK ACTION
        if (action == null) {
            response.sendRedirect("profile.jsp");
            return;
        }

        // HANDLE ACTIONS
        switch (action) {

            case "viewOrders":
                viewOrders(request, response);
                break;

            case "details":
                showOrderDetails(request, response);
                break;

            default:
                response.sendRedirect("profile.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET ACTION
        String action = request.getParameter("action");

        // PLACE ORDER
        if (action.equals("placeOrder")) {
            placeOrder(request, response);
        }
    }

    // =====================================
    // PLACE ORDER
    // =====================================
    private void placeOrder(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET LOGGED USER
        User user
                = (User) SessionUtil.getAttribute(request, "user");

        // CHECK LOGIN
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // GET CART ITEMS
        CartDAO cartDAO = new CartDAO();

        List<Cart> cartItems
                = cartDAO.getCartByUser(user.getUserId());

        // CHECK EMPTY CART
        if (cartItems.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Cart is empty!"
            );

            request.getRequestDispatcher("/pages/cart.jsp")
                    .forward(request, response);

            return;
        }

        // CALCULATE SUBTOTAL
        double subtotal = 0;

        for (Cart cart : cartItems) {

            subtotal += cart.getPrice()
                    * cart.getQuantity();
        }

        // VAT 13%
        double vat = subtotal * 0.13;

        // FINAL TOTAL
        double totalAmount = subtotal + vat;

        // CREATE ORDER OBJECT
        Order order = new Order();

        order.setUserId(user.getUserId());
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending");

        // PLACE ORDER
        OrderDAO orderDAO = new OrderDAO();

        boolean result
                = orderDAO.placeOrder(order, cartItems);

        // SUCCESS
        if (result) {

            request.setAttribute(
                    "success",
                    "Order placed successfully!"
            );

            // SUCCESS SESSION MESSAGE
            request.getSession().setAttribute(
                    "orderSuccess",
                    "Your order has been placed successfully!"
            );

            // REDIRECT TO ORDERS
            response.sendRedirect(
                    request.getContextPath()
                    + "/order?action=viewOrders"
            );

        } else {

            // ERROR MESSAGE
            request.setAttribute(
                    "error",
                    "Failed to place order!"
            );

            // RETURN TO CART
            request.getRequestDispatcher("/pages/cart.jsp")
                    .forward(request, response);
        }
    }

    // =====================================
    // VIEW ORDERS
    // =====================================
    private void viewOrders(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET LOGGED USER
        User user
                = (User) SessionUtil.getAttribute(request, "user");

        // CHECK LOGIN
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // GET USER ORDERS
        OrderDAO orderDAO = new OrderDAO();

        List<Order> orderList
                = orderDAO.getOrdersByUser(user.getUserId());

        // SEND ORDERS
        request.setAttribute("orders", orderList);

        // OPEN ORDERS PAGE
        request.getRequestDispatcher("/pages/orders.jsp")
                .forward(request, response);
    }

    // =====================================
    // SHOW ORDER DETAILS
    // =====================================
    private void showOrderDetails(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET ORDER ID
        int orderId
                = Integer.parseInt(
                        request.getParameter("id"));

        // GET ORDER ITEMS
        List<OrderItem> items
                = orderDAO.getOrderItems(orderId);

        // SEND DATA
        request.setAttribute("items", items);

        request.setAttribute("orderId", orderId);

        // OPEN DETAILS PAGE
        request.getRequestDispatcher(
                "/pages/orderDetails.jsp")
                .forward(request, response);
    }
}
