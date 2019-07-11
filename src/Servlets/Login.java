package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Login", urlPatterns = "/Login")
public class Login extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        DatabaseManager dm = new DatabaseManager();
        String username =  request.getParameter("username");
        String password = request.getParameter("password");
        if(!dm.usernameExists(username)){
            response.sendRedirect("index.jsp?error=Username doesn't exist");
            return;
        }

        if(!dm.checkLogin(username,password)){
            response.sendRedirect("index.jsp?error=Password is incorrect");
            return;
        }

        request.getSession().setAttribute("username", username);
        request.getSession().setAttribute("password", password);
        response.sendRedirect("profile.jsp");
    }
}