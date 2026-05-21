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
     // =====================================
// UPDATE USER PROFILE
// =====================================

    public boolean updateUser(User user) {

        String query
                = "UPDATE users "
                + "SET name = ?, "
                + "email_address = ?, "
                + "password = ? "
                + "WHERE user_id = ?";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setString(1, user.getName());

            pst.setString(2,
                    user.getEmailAddress());

            pst.setString(3,
                    user.getPassword());

            pst.setInt(4,
                    user.getUserId());

            int rows = pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    // =====================================
// GET ALL USERS
// =====================================

    public java.util.List<User> getAllUsers() {

        java.util.List<User> userList
                = new java.util.ArrayList<>();

        String query
                = "SELECT * FROM users";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            ResultSet rs
                    = pst.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id"));

                user.setName(
                        rs.getString("name"));

                user.setEmailAddress(
                        rs.getString("email_address"));

                user.setPassword(
                        rs.getString("password"));

                user.setRole(
                        rs.getString("role"));

                userList.add(user);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return userList;
    }
    
    // =====================================
// DELETE USER
// =====================================
    public boolean deleteUser(int userId) {

        String query
                = "DELETE FROM users "
                + "WHERE user_id = ?";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            pst.setInt(1, userId);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }
    // =====================================
// COUNT USERS
// =====================================

    public int countUsers() {

        String query
                = "SELECT COUNT(*) FROM users";

        try {

            PreparedStatement pst
                    = conn.prepareStatement(query);

            ResultSet rs
                    = pst.executeQuery();

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }
    
    
}