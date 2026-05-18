package com.svelte.util;

public class TestConnection {

    public static void main(String[] args) {
        try {
            if (DBConfig.getConnection() != null) {
                System.out.println("Database Connected!");
            } else {
                System.out.println("Connection Failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}