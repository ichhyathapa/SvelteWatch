package com.svelte.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // CHECK IF FIELD IS EMPTY
    public static boolean isNullOrEmpty(String value) {

        return value == null || value.trim().isEmpty();
    }

    // VALIDATE EMAIL FORMAT
    public static boolean isValidEmail(String email) {

        String emailRegex
                = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";

        return email != null
                && Pattern.matches(emailRegex, email);
    }

    // VALIDATE PASSWORD
    // password must contain:
    // 1 uppercase letter
    // 1 number
    // 1 special character
    // minimum 6 characters
    public static boolean isValidPassword(String password) {

        String passwordRegex
                = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{6,}$";

        return password != null
                && password.matches(passwordRegex);
    }

    // VALIDATE NAME
    // only letters and spaces allowed
    public static boolean isValidName(String name) {

        return name != null
                && name.matches("^[A-Za-z][A-Za-z ]*$");
    }
}
