/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.svelte.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.svelte.model.User;
import com.svelte.util.DBConfig;

public class UserDAO {

    private Connection conn;

    public UserDAO() {

        try {

            conn = DBConfig.getConnection();

        } catch(Exception e) {

            e.printStackTrace();
        }
    }

    // REGISTER USER
    public boolean registerUser(User user) {

        try {

            // CHECK EMAIL EXISTS
            String checkQuery =
                    "SELECT * FROM users WHERE email_address=?";

            PreparedStatement checkStmt =
                    conn.prepareStatement(checkQuery);

            checkStmt.setString(
                    1,
                    user.getEmailAddress()
            );

            ResultSet rs =
                    checkStmt.executeQuery();

            // EMAIL ALREADY EXISTS
            if(rs.next()) {

                return false;
            }

            // INSERT USER
            String insertQuery =
                    "INSERT INTO users(name,email_address,password,role)"
                    + " VALUES(?,?,?,?)";

            PreparedStatement pst =
                    conn.prepareStatement(insertQuery);

            pst.setString(1, user.getName());

            pst.setString(
                    2,
                    user.getEmailAddress()
            );

            pst.setString(
                    3,
                    user.getPassword()
            );

            pst.setString(
                    4,
                    user.getRole()
            );

            int result = pst.executeUpdate();

            return result > 0;

        } catch(SQLException e) {

            e.printStackTrace();
        }

        return false;
    }

    // LOGIN USER
    public User getUserByEmail(String email) {

        try {

            String query =
                    "SELECT * FROM users WHERE email_address=?";

            PreparedStatement pst =
                    conn.prepareStatement(query);

            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if(rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setName(
                        rs.getString("name")
                );

                user.setEmailAddress(
                        rs.getString("email_address")
                );

                user.setPassword(
                        rs.getString("password")
                );

                user.setRole(
                        rs.getString("role")
                );

                return user;
            }

        } catch(SQLException e) {

            e.printStackTrace();
        }

        return null;
    }
}