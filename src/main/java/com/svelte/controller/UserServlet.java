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

        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case "login":
                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);
                break;

            case "register":
                request.getRequestDispatcher(
                        "register.jsp"
                ).forward(request, response);
                break;

            default:
                response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action
                = request.getParameter("action");

        if (action.equals("register")) {
            registerUser(request, response);

        } else if (action.equals("login")) {
            loginUser(request, response);
        }
    }

    // REGISTER METHOD
    private void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
                    "register.jsp"
            ).forward(request, response);

            return;
        }

        // NAME CHECK
        if (!ValidationUtil.isValidName(name)) {

            request.setAttribute(
                    "error",
                    "Name should contain letters only!"
            );

            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);

            return;
        }

        // EMAIL CHECK
        if (!ValidationUtil.isValidEmail(email)) {

            request.setAttribute(
                    "error",
                    "Invalid email format!"
            );

            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);

            return;
        }

        // PASSWORD CHECK
        if (!ValidationUtil.isValidPassword(password)) {

            request.setAttribute(
                    "error",
                    "Password must contain uppercase letter, number and special character."
            );

            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);

            return;
        }
        
        //HASH PASSWORD
        String hashedPassword = PasswordUtil.hashPassword(password);
        
        User user = new User();
        user.setName(name);
        user.setEmailAddress(email);
        user.setPassword(hashedPassword);

        //DEFAULT ROLE
        user.setRole("user");

        UserDAO userDAO = new UserDAO();

        boolean result = userDAO.registerUser(user);

        if (result) {
            request.setAttribute("success","Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {
            request.setAttribute("error","Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    //LOGIN METHOD
    private void loginUser(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        String email= request.getParameter("email");
        String password= request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user= userDAO.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("error","Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        boolean matched= PasswordUtil.checkPassword(password,user.getPassword());

        if (matched){
            SessionUtil.setAttribute(request,"user",user);

            // ROLE REDIRECT
            if (user.getRole().equals("admin")) {response.sendRedirect(request.getContextPath()+ "/admin/dashboard.jsp");

            } else{
                response.sendRedirect(request.getContextPath()+ "/watches.jsp"
                );
            }

        } else {
            request.setAttribute("error","Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
