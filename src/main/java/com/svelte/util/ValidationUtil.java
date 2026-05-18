package com.svelte.util;
import java.util.regex.Pattern ;

public class ValidationUtil {

        //check if string is null or empty
        public static boolean isNullOrEmpty(String value) {
        //returns true if value is null or blank
            return value == null || value.trim().isEmpty();
        }

        // check if email format is valid
        public static boolean isValidEmail(String email) {
            // regex pattern for email format
            String emailRegex = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
            return email != null 
                   && Pattern.matches(emailRegex, email);   //match email with pattern
        }

        //check if password is strong enough
        //must contain uppercase and number
        public static boolean isValidPassword(String password) {

        // REQUIREMENTS:
        // 1 uppercase
        // 1 number
        // 1 special character
        // minimum 6 characters
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{6,}$";

        return password != null
                && password.matches(passwordRegex);
    }
        // check if name contains only letters
        public static boolean isValidName(String name) {

            // allow alphabets and spaces only
            return name != null
                    && name.matches("^[A-Za-z ]+$");
        }

    }
