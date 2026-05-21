package com.svelte.dao;

import com.svelte.model.Cart;
import com.svelte.model.Order;
import com.svelte.model.OrderItem;
import com.svelte.util.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection conn;

    // =========================================
    // CONSTRUCTOR
    // =========================================
    public OrderDAO() {

        try {
            conn = DBConfig.getConnection();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================================
    // PLACE ORDER
    // =========================================
    public boolean placeOrder(Order order,
            List<Cart> cartItems) {

        try {

            // ==============================
            // INSERT INTO ORDERS TABLE
            // ==============================
            String orderQuery
                    = "INSERT INTO orders "
                    + "(user_id, total_amount, status) "
                    + "VALUES (?, ?, ?)";

            PreparedStatement orderPst
                    = conn.prepareStatement(
                            orderQuery,
                            Statement.RETURN_GENERATED_KEYS
                    );

            orderPst.setInt(1, order.getUserId());

            orderPst.setDouble(2,
                    order.getTotalAmount());

            orderPst.setString(3,
                    order.getStatus());

            int rows = orderPst.executeUpdate();

            if (rows == 0) {
                return false;
            }

            // ==============================
            // GET GENERATED ORDER ID
            // ==============================
            ResultSet generatedKeys
                    = orderPst.getGeneratedKeys();

            int orderId = 0;

            if (generatedKeys.next()) {

                orderId
                        = generatedKeys.getInt(1);
            }

            // ==============================
            // INSERT ORDER ITEMS
            // ==============================
            String itemQuery
                    = "INSERT INTO order_items "
                    + "(order_id, product_id, quantity, price) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement itemPst
                    = conn.prepareStatement(itemQuery);

            for (Cart cart : cartItems) {

                itemPst.setInt(1, orderId);

                itemPst.setInt(2,
                        cart.getProductId());

                itemPst.setInt(3,
                        cart.getQuantity());

                // TEMP PRICE
                itemPst.setDouble(4, cart.getPrice());

                itemPst.executeUpdate();
            }

            // ==============================
            // CLEAR CART
            // ==============================
            CartDAO cartDAO = new CartDAO();

            cartDAO.clearCart(order.getUserId());

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================================
    // GET ORDERS BY USER
    // =========================================
    public List<Order> getOrdersByUser(int userId) {

        List<Order> orderList
                = new ArrayList<>();

        String query
                = "SELECT * FROM orders "
                + "WHERE user_id = ? "
                + "ORDER BY created_at DESC";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setInt(1, userId);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                order.setCreatedAt(
                        rs.getTimestamp("created_at"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // =========================================
    // GET ALL ORDERS (ADMIN)
    // =========================================
    public List<Order> getAllOrders() {

        List<Order> orderList
                = new ArrayList<>();

        String query
                = "SELECT o.*, u.name "
                + "FROM orders o "
                + "JOIN users u "
                + "ON o.user_id = u.user_id "
                + "ORDER BY o.created_at DESC";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setCustomerName(
                        rs.getString("name"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                order.setCreatedAt(
                        rs.getTimestamp("created_at"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // =========================================
// GET ORDER ITEMS
// =========================================
    public List<OrderItem> getOrderItems(int orderId) {

        List<OrderItem> itemList
                = new ArrayList<>();

        String query
                = "SELECT oi.*, "
                + "p.product_name, "
                + "p.image_url "
                + "FROM order_items oi "
                + "JOIN products p "
                + "ON oi.product_id = p.product_id "
                + "WHERE oi.order_id = ?";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setInt(1, orderId);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                OrderItem item
                        = new OrderItem();

                item.setOrderItemId(
                        rs.getInt("order_item_id"));

                item.setOrderId(
                        rs.getInt("order_id"));

                item.setProductId(
                        rs.getInt("product_id"));

                item.setQuantity(
                        rs.getInt("quantity"));

                item.setPrice(
                        rs.getDouble("price"));

                item.setCreatedAt(
                        rs.getTimestamp("created_at"));

                // =========================
                // PRODUCT DETAILS
                // =========================
                item.setProductName(
                        rs.getString("product_name"));

                item.setImageUrl(
                        rs.getString("image_url"));

                itemList.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return itemList;
    }

    // =========================================
    // UPDATE ORDER STATUS
    // =========================================
    public boolean updateStatus(int orderId,
            String status) {

        String query
                = "UPDATE orders "
                + "SET status = ? "
                + "WHERE order_id = ?";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setString(1, status);

            pst.setInt(2, orderId);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================================
    // COUNT ORDERS
    // =========================================
    public int countOrders() {

        String query
                = "SELECT COUNT(*) FROM orders";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
    // =====================================
// GET RECENT ORDERS
// =====================================
// =====================================
// GET RECENT ORDERS
// =====================================

    public List<Order> getRecentOrders() {

        List<Order> orderList = new ArrayList<>();

        String sql
                = "SELECT o.*, u.name "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.user_id "
                + "ORDER BY o.created_at DESC LIMIT 5";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setCustomerName(
                        rs.getString("name"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                order.setCreatedAt(
                        rs.getTimestamp("created_at"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // =========================================
    // TOTAL REVENUE
    // =========================================
    public double sumRevenue() {

        String query
                = "SELECT SUM(total_amount) "
                + "FROM orders";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
