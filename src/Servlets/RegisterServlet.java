package Servlets;

import DataAccess.DatabaseManager;
import Objects.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";

        String firstName = request.getParameter("firstName");
        if (firstName.length() < 1) errors += "<p class='error'>You must enter first name</p>";
        String lastName = request.getParameter("lastName");
        if (lastName.length() < 1) errors += "<p class='error'>You must enter first name</p>";
        String userName = request.getParameter("userName");
        if (userName.length() < 1) errors += "<p class='error'>You must enter first name</p>";
        String email = request.getParameter("email");
        if (email.length() < 1) errors += "<p class='error'>You must enter first name</p>";
        String password = request.getParameter("password");
        if (password.length() < 6) errors += "<p class='error'>You must enter first name</p>";

        if (errors.length() != 0) {
            request.setAttribute("error", errors);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        DatabaseManager dataManager = new DatabaseManager();
        if (dataManager.usernameExists(userName)) {
            errors += "<p class='error'>Username already exists</p>";
        }

        if (dataManager.emailExists(email)) {
            errors += "<p class='error'>E-Mail already exists</p>";
        }

        if (errors.length() != 0) {
            request.setAttribute("error", errors);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        User newUser = new User(firstName, lastName, userName, email, password, "image");
        dataManager.insertUser(newUser);

        request.setAttribute("successMessage", "You have successfully created account");
        request.getRequestDispatcher("/userPage.jsp").forward(request, response);
    }
}
