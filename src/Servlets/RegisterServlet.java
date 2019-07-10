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
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean emptyBox = false;
        boolean smallPass = false;

        String firstName = request.getParameter("firstName");
        if(firstName == "")emptyBox = true;
        String lastName = request.getParameter("lastName");
        if(lastName == "")emptyBox = true;
        String userName = request.getParameter("userName");
        if(userName == "")emptyBox = true;
        String email = request.getParameter("email");
        if(email == "")emptyBox = true;
        String password = request.getParameter("password");
        if(password.length() < 7)smallPass = true;

        if(emptyBox){
            request.setAttribute("errorMessage", "Please fill all fields");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        if(smallPass){
            request.setAttribute("errorMessage", "Password must contain at least 6 characters");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }

        DatabaseManager dataManager = new DatabaseManager();
        try {
            if(dataManager.usernameExists(userName)){

            }

            if(dataManager.emailExists(email)){

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

//        User newUser = new User(firstName, lastName, userName, email, password);
//        dataManager.insertUser(newUser);

        request.setAttribute("successMessage", "You have successfully created account");
        request.getRequestDispatcher("/userPage.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
