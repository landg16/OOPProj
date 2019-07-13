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

@WebServlet(name = "Register", urlPatterns = "/Register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";

        String firstName = request.getParameter("firstName");
        if (firstName.length() < 1) errors += "<p class='error'>You must enter first name</p>";
        String lastName = request.getParameter("lastName");
        if (lastName.length() < 1) errors += "<p class='error'>You must enter last name</p>";
        String userName = request.getParameter("userName");
        if (userName.length() < 1) errors += "<p class='error'>You must enter user name</p>";
        String email = request.getParameter("email");
        if (email.length() < 1) errors += "<p class='error'>You must enter email</p>";
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeatPassword");
        if (password.length() < 6) errors += "<p class='error'>Password must contain at least 6 symbol</p>";
        if (!password.equals(repeatPassword)) errors += "<p class='error'>Passwords do not match</p>";

        if (errors.length() != 0) {
            request.setAttribute("error", errors);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (DatabaseManager.usernameExists(userName)) {
            errors += "<p class='error'>Username already exists</p>";
        }

        if (DatabaseManager.emailExists(email)) {
            errors += "<p class='error'>E-Mail already exists</p>";
        }

        if (errors.length() != 0) {
            request.setAttribute("error", errors);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        String image = request.getParameter("image");
        if(image.length()<4) {
            image = "img/default-avatar.png";
        }

        User newUser = new User(0, firstName, lastName, userName, email, password, false, image);
        DatabaseManager.insertUser(newUser);

        response.sendRedirect("index.jsp?success=You have successfully created account");
    }
}
