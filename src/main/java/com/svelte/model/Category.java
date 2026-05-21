package com.svelte.model;

public class Category {

    // CATEGORY DETAILS
    private int categoryId;
    private String categoryName;

    // DEFAULT CONSTRUCTOR
    public Category() {

    }

    // GET CATEGORY ID
    public int getCategoryId() {
        return categoryId;
    }

    // SET CATEGORY ID
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // GET CATEGORY NAME
    public String getCategoryName() {
        return categoryName;
    }

    // SET CATEGORY NAME
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}