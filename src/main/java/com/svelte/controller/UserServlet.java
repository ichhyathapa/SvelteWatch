package com.svelte.controller;

import com.svelte.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.svelte.model.User;
import com.svelte.util.PasswordUtil;
import com.svelte.util.SessionUtil;
import com.svelte.util.ValidationUtil;

@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // GET ACTION
        String action = request.getParameter("action");

        // DEFAULT REDIRECT
        if (action == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/user?action=login");

            return;
        }

        // HANDLE GET ACTIONS
        switch (action) {

            case "login":

                // OPEN LOGIN PAGE
                request.getRequestDispatcher(
                        "/login.jsp"
                ).forward(request, response);

                break;

            case "register":

                // OPEN REGISTER PAGE
                request.getRequestDispatcher(
                        "/register.jsp"
                ).forward(request, response);

                break;

            default:

                // INVALID ACTION
                response.sendRedirect(
                        request.getContextPath()
                        + "/user?action=login"
                );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET ACTION
        String action = request.getParameter("action");

        // CHECK ACTION
        if (action == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/user?action=login"
            );

            return;
        }

        // HANDLE POST ACTIONS
        switch (action) {

            case "register":
                registerUser(request, response);
                break;

            case "login":
                loginUser(request, response);
                break;

            case "updateProfile":
                updateProfile(request, response);
                break;

            default:

                // INVALID ACTION
                response.sendRedirect(
                        request.getContextPath()
                        + "/user?action=login"
                );
        }
    }

    // =====================================
    // REGISTER USER
    // =====================================
    private void registerUser(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET FORM DATA
        String name = request.getParameter("name");

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        // EMPTY CHECK
        if (ValidationUtil.isNullOrEmpty(name)
                || ValidationUtil.isNullOrEmpty(email)
                || ValidationUtil.isNullOrEmpty(password)) {

            request.setAttribute(
                    "error",
                    "All fields are required!"
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }

        // NAME VALIDATION
        if (!ValidationUtil.isValidName(name)) {

            request.setAttribute(
                    "error",
                    "Name should contain letters only!"
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }

        // EMAIL VALIDATION
        if (!ValidationUtil.isValidEmail(email)) {

            request.setAttribute(
                    "error",
                    "Invalid email format!"
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }

        // PASSWORD VALIDATION
        if (!ValidationUtil.isValidPassword(password)) {

            request.setAttribute(
                    "error",
                    "Password must contain uppercase letter, number and special character."
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }

        // HASH PASSWORD
        String hashedPassword
                = PasswordUtil.hashPassword(password);

        // CREATE USER OBJECT
        User user = new User();

        user.setName(name);

        user.setEmailAddress(email);

        user.setPassword(hashedPassword);

        // DEFAULT ROLE
        user.setRole("user");

        // REGISTER USER
        UserDAO userDAO = new UserDAO();

        boolean result = userDAO.registerUser(user);

        // SUCCESS
        if (result) {

            request.setAttribute(
                    "success",
                    "Registration successful! Please login."
            );

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

        } else {

            // EMAIL EXISTS
            request.setAttribute(
                    "error",
                    "Email already exists!"
            );

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);
        }
    }

    // =====================================
    // LOGIN USER
    // =====================================
    private void loginUser(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET FORM DATA
        String email = request.getParameter("email");

        String password = request.getParameter("password");

        // CREATE DAO
        UserDAO userDAO = new UserDAO();

        // GET USER
        User user = userDAO.getUserByEmail(email);

        // USER NOT FOUND
        if (user == null) {

            request.setAttribute(
                    "error",
                    "Invalid email or password!"
            );

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);

            return;
        }

        // CHECK PASSWORD
        boolean matched
                = PasswordUtil.checkPassword(
                        password,
                        user.getPassword()
                );

        // LOGIN SUCCESS
        if (matched) {

            // STORE USER SESSION
            SessionUtil.setAttribute(
                    request,
                    "user",
                    user
            );

            // ADMIN REDIRECT
            if (user.getRole().equals("admin")) {

                response.sendRedirect(
                        "AdminServlet?action=dashboard"
                );

            } else {

                // USER REDIRECT
                response.sendRedirect(
                        request.getContextPath()
                        + "/watches.jsp"
                );
            }

        } else {

            // INVALID PASSWORD
            request.setAttribute(
                    "error",
                    "Invalid email or password!"
            );

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);
        }
    }

    // =====================================
    // UPDATE PROFILE
    // =====================================
    private void updateProfile(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // GET SESSION USER
        User sessionUser
                = (User) SessionUtil.getAttribute(
                        request,
                        "user"
                );

        // CHECK LOGIN
        if (sessionUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/user?action=login"
            );

            return;
        }

        // GET FORM DATA
        String name
                = request.getParameter("name");

        String email
                = request.getParameter("email");

        String currentPassword
                = request.getParameter(
                        "currentPassword"
                );

        String newPassword
                = request.getParameter(
                        "newPassword"
                );

        String confirmPassword
                = request.getParameter(
                        "confirmPassword"
                );

        // CHECK CURRENT PASSWORD
        boolean matched
                = PasswordUtil.checkPassword(
                        currentPassword,
                        sessionUser.getPassword()
                );

        // INVALID CURRENT PASSWORD
        if (!matched) {

            request.setAttribute(
                    "error",
                    "Current password is incorrect!"
            );

            request.getRequestDispatcher(
                    "/pages/editProfile.jsp"
            ).forward(request, response);

            return;
        }

        // CHECK NEW PASSWORD
        if (newPassword != null
                && !newPassword.isEmpty()) {

            // PASSWORD MATCH CHECK
            if (!newPassword.equals(confirmPassword)) {

                request.setAttribute(
                        "error",
                        "New passwords do not match!"
                );

                request.getRequestDispatcher(
                        "/pages/editProfile.jsp"
                ).forward(request, response);

                return;
            }

            // PASSWORD VALIDATION
            if (!ValidationUtil.isValidPassword(
                    newPassword)) {

                request.setAttribute(
                        "error",
                        "Password must contain uppercase, lowercase, number, special character and minimum 6 characters."
                );

                request.getRequestDispatcher(
                        "/pages/editProfile.jsp"
                ).forward(request, response);

                return;
            }
        }

        // KEEP OLD PASSWORD
        String hashedPassword
                = sessionUser.getPassword();

        // HASH NEW PASSWORD
        if (newPassword != null
                && !newPassword.isEmpty()) {

            hashedPassword
                    = PasswordUtil.hashPassword(
                            newPassword
                    );
        }

        // UPDATE USER OBJECT
        sessionUser.setName(name);

        sessionUser.setEmailAddress(email);

        sessionUser.setPassword(
                hashedPassword
        );

        // UPDATE DATABASE
        UserDAO userDAO = new UserDAO();

        boolean result
                = userDAO.updateUser(sessionUser);

        // SUCCESS
        if (result) {

            // UPDATE SESSION
            SessionUtil.setAttribute(
                    request,
                    "user",
                    sessionUser
            );

            // SUCCESS MESSAGE
            request.getSession().setAttribute(
                    "success",
                    "Profile updated successfully!"
            );

            // REDIRECT PROFILE
            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/profile.jsp"
            );

        } else {

            // UPDATE FAILED
            request.setAttribute(
                    "error",
                    "Failed to update profile!"
            );

            request.getRequestDispatcher(
                    "/pages/editProfile.jsp"
            ).forward(request, response);
        }
    }
}
