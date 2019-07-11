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
        DatabaseManager dm = new DatabaseManager();
        String email =  request.getParameter("email");
        String uzername = request.getParameter("uzername");

        response.sendRedirect("index.jsp?success=Password reset mail has been sent");
    }
}
