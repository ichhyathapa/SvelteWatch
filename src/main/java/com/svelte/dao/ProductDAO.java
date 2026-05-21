package com.svelte.dao;

import java.sql.*;
import java.util.ArrayList;

import com.svelte.model.Product;
import com.svelte.util.DBConfig;

public class ProductDAO {

    // DATABASE CONNECTION
    private Connection conn;

    // CONSTRUCTOR
    public ProductDAO() {

        try {

            // CONNECT DATABASE
            conn = DBConfig.getConnection();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    /* ================= ALL PRODUCTS ================= */
    public ArrayList<Product> getAllProducts() {

        ArrayList<Product> products = new ArrayList<>();

        try {

            // SQL QUERY
            String sql = "SELECT * FROM products";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            // FETCH PRODUCTS
            while (rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setGender(rs.getString("gender"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setPrice(rs.getDouble("price"));

                products.add(p);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }

    /* ================= FILTER PRODUCTS ================= */
    public ArrayList<Product> getFilteredProducts(
            String gender,
            String[] categories) {

        ArrayList<Product> products = new ArrayList<>();

        try {

            // CREATE SQL
            StringBuilder sql
                    = new StringBuilder(
                            "SELECT * FROM products WHERE 1=1"
                    );

            // FILTER GENDER
            if (gender != null && !gender.isEmpty()) {

                sql.append(" AND gender=?");
            }

            // FILTER CATEGORY
            if (categories != null
                    && categories.length > 0) {

                sql.append(" AND category_id IN (");

                for (int i = 0;
                        i < categories.length;
                        i++) {

                    sql.append("?");

                    if (i < categories.length - 1) {

                        sql.append(",");
                    }
                }

                sql.append(")");
            }

            PreparedStatement pst
                    = conn.prepareStatement(sql.toString());

            int index = 1;

            // SET GENDER
            if (gender != null && !gender.isEmpty()) {

                pst.setString(index++, gender);
            }

            // SET CATEGORY IDS
            if (categories != null
                    && categories.length > 0) {

                for (String cat : categories) {

                    pst.setInt(index++,
                            Integer.parseInt(cat));
                }
            }

            ResultSet rs = pst.executeQuery();

            // FETCH PRODUCTS
            while (rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setGender(rs.getString("gender"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setPrice(rs.getDouble("price"));

                products.add(p);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }

    /* ================= SEARCH PRODUCTS ================= */
    public ArrayList<Product> searchProducts(String keyword) {

        ArrayList<Product> products = new ArrayList<>();

        try {

            // SQL QUERY
            String sql
                    = "SELECT * FROM products "
                    + "WHERE product_name LIKE ? "
                    + "OR brand LIKE ?";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            pst.setString(1, "%" + keyword + "%");
            pst.setString(2, "%" + keyword + "%");

            ResultSet rs = pst.executeQuery();

            // FETCH PRODUCTS
            while (rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setGender(rs.getString("gender"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setPrice(rs.getDouble("price"));

                products.add(p);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }

    /* ================= PRODUCT DETAILS ================= */
    public Product getProductById(int id) {

        Product p = null;

        try {

            // SQL QUERY
            String sql
                    = "SELECT * FROM products WHERE product_id=?";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();

            // FETCH PRODUCT
            if (rs.next()) {

                p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setGender(rs.getString("gender"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setPrice(rs.getDouble("price"));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return p;
    }

    /* ================= COUNT PRODUCTS ================= */
    public int countProducts() {

        int count = 0;

        try {

            // SQL QUERY
            String sql
                    = "SELECT COUNT(*) FROM products";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            // GET COUNT
            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    /* ================= ADD PRODUCT ================= */
    public boolean addProduct(Product p) {

        try {

            // SQL INSERT
            String sql
                    = "INSERT INTO products "
                    + "(product_name, category_id, gender, brand, description, stock_quantity, image_url, price) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            pst.setString(1, p.getProductName());
            pst.setInt(2, p.getCategoryId());
            pst.setString(3, p.getGender());
            pst.setString(4, p.getBrand());
            pst.setString(5, p.getDescription());
            pst.setInt(6, p.getStockQuantity());
            pst.setString(7, p.getImageUrl());
            pst.setDouble(8, p.getPrice());

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    /* ================= UPDATE PRODUCT ================= */
    public boolean updateProduct(Product p) {

        try {

            // SQL UPDATE
            String sql
                    = "UPDATE products SET "
                    + "product_name=?, "
                    + "category_id=?, "
                    + "gender=?, "
                    + "brand=?, "
                    + "description=?, "
                    + "stock_quantity=?, "
                    + "image_url=?, "
                    + "price=? "
                    + "WHERE product_id=?";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            pst.setString(1, p.getProductName());
            pst.setInt(2, p.getCategoryId());
            pst.setString(3, p.getGender());
            pst.setString(4, p.getBrand());
            pst.setString(5, p.getDescription());
            pst.setInt(6, p.getStockQuantity());
            pst.setString(7, p.getImageUrl());
            pst.setDouble(8, p.getPrice());
            pst.setInt(9, p.getProductId());

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    /* ================= DELETE PRODUCT ================= */
    public boolean deleteProduct(int id) {

        try {

            // SQL DELETE
            String sql
                    = "DELETE FROM products "
                    + "WHERE product_id=?";

            PreparedStatement pst
                    = conn.prepareStatement(sql);

            pst.setInt(1, id);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

}
