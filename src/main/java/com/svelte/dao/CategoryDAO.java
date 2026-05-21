package com.svelte.dao;

import com.svelte.model.Category;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // GET ALL CATEGORIES
    public List<Category> getAllCategories() {

        List<Category> list = new ArrayList<>();

        return list;
    }

    // ADD CATEGORY
    public void addCategory(String name) {

        // TODO: replace with real SQL INSERT when database is ready
        System.out.println("addCategory called: " + name);
    }

    // DELETE CATEGORY
    public void deleteCategory(int id) {

        // TODO: replace with real SQL DELETE when database is ready
        System.out.println("deleteCategory called for id: " + id);
    }
}
