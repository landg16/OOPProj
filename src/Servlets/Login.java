package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/Login")
public class Login extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        DatabaseManager dm = new DatabaseManager();
        String username =  request.getParameter("username");
        String password = request.getParameter("password");
        try {
            if(!dm.usernameExists(username)){
                response.sendRedirect("index.jsp?error=Username doesn't exist");
            }

            if(!dm.checkLogin(username,password)){
                response.sendRedirect("index.jsp?error=Password is incorrect");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("profile.jsp");
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }
}
