package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

/*
This is servlet for forgot password
*/

@WebServlet(name = "forgotPassword", urlPatterns = "/forgotpassword")
public class ForgotPassword extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String errors = "";
        String username = request.getParameter("uzername");
        String email =  request.getParameter("email");

        if (!DatabaseManager.emailExists(email)) {
            response.sendRedirect("index.jsp?error=Incorrect e-mail address");
            return;
        }

        if (!DatabaseManager.usernameExists(username)) {
            response.sendRedirect("index.jsp?error=Username doesn't exist");
            return;
        }

        response.sendRedirect("index.jsp?success=Password reset mail has been sent");
    }
}
