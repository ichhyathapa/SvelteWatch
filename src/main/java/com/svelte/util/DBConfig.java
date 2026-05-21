package com.svelte.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {

    // DATABASE NAME
    private static final String DB_NAME = "svelte_db";

    // DATABASE USERNAME
    private static final String USER = "root";

    // DATABASE PASSWORD
    private static final String PASSWORD = "";

    // DATABASE URL
    private static final String URL =
            "jdbc:mysql://localhost:3306/" + DB_NAME;

    // GET DATABASE CONNECTION
    public static Connection getConnection()
            throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}