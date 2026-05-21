package com.svelte.dao;
import com.svelte.model.Cart;
import com.svelte.util.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Database connection
    private Connection conn;

    // Constructor
    public CartDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ==============================
    // ADD TO CART
    // ==============================
    public boolean addToCart(Cart cart) {

        String query = "INSERT INTO cart "
                + "(user_id, product_id, quantity) "
                + "VALUES (?, ?, ?)";

        try {

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setInt(1, cart.getUserId());
            pst.setInt(2, cart.getProductId());
            pst.setInt(3, cart.getQuantity());

            int rows = pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ==============================
// GET USER CART ITEMS
// ==============================
    public List<Cart> getCartByUser(int userId) {

        List<Cart> cartList = new ArrayList<>();

        String query
                = "SELECT c.*, p.product_name, "
                + "p.image_url, p.price, p.brand "
                + "FROM cart c "
                + "JOIN products p "
                + "ON c.product_id = p.product_id "
                + "WHERE c.user_id = ?";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setInt(1, userId);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                Cart cart = new Cart();

                cart.setCartId(
                        rs.getInt("cart_id"));

                cart.setUserId(
                        rs.getInt("user_id"));

                cart.setProductId(
                        rs.getInt("product_id"));

                cart.setQuantity(
                        rs.getInt("quantity"));

                cart.setCreatedAt(
                        rs.getTimestamp("created_at"));

                cart.setUpdatedAt(
                        rs.getTimestamp("updated_at"));

                // =========================
                // PRODUCT DETAILS
                // =========================
                cart.setProductName(
                        rs.getString("product_name"));

                cart.setImageUrl(
                        rs.getString("image_url"));

                cart.setPrice(
                        rs.getDouble("price"));

                cart.setBrand(
                        rs.getString("brand"));

                cartList.add(cart);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartList;
    }
    // ==============================
    // REMOVE CART ITEM
    // ==============================
    public boolean removeCartItem(int cartId) {

        String query = "DELETE FROM cart WHERE cart_id = ?";

        try {

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setInt(1, cartId);

            int rows = pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ==============================
    // UPDATE QUANTITY
    // ==============================
    public boolean updateQuantity(int cartId, int quantity) {

        String query = "UPDATE cart "
                + "SET quantity = ? "
                + "WHERE cart_id = ?";

        try {

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setInt(1, quantity);
            pst.setInt(2, cartId);

            int rows = pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ==============================
    // CLEAR USER CART
    // ==============================
    public boolean clearCart(int userId) {

        String query = "DELETE FROM cart WHERE user_id = ?";

        try {

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setInt(1, userId);

            int rows = pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}