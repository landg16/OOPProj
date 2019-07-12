package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.annotation.WebServlet;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Login", urlPatterns = "/Login")
public class Login extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String username =  request.getParameter("username");
        String password = request.getParameter("password");

        if(!DatabaseManager.usernameExists(username)){
            response.sendRedirect("index.jsp?error=Username doesn't exist");
            return;
        }
        int k = DatabaseManager.checkLogin(username,password);
        if(k==-1){
            response.sendRedirect("index.jsp?error=Password is incorrect");
            return;
        }

        request.getSession().setAttribute("user_id", k);
        request.getSession().setAttribute("username", username);
        request.getSession().setAttribute("password", password);
        response.sendRedirect("profile.jsp");
    }
}