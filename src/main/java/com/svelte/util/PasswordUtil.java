package com.svelte.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // HASH PASSWORD
    public static String hashPassword(String password) {

        return BCrypt.hashpw(
                password,
                BCrypt.gensalt()
        );
    }

    // CHECK PASSWORD
    public static boolean checkPassword(
            String plainPassword,
            String hashedPassword
    ) {

        return BCrypt.checkpw(
                plainPassword,
                hashedPassword
        );
    }
}
