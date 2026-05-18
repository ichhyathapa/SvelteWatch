package com.svelte.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.svelte.model.Product;
import com.svelte.util.DBConfig;

public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET ALL PRODUCTS
    public List<Product> getAllProducts() {

        List<Product> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM product";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setBrand(rs.getString("brand"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
