package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;

@WebServlet("/PromoteAdmin")
public class PromoteAdmin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";
        String recieverId = request.getParameter("id");
        int receiver = Integer.parseInt(recieverId);
        DatabaseManager.setAsAdmin(receiver);
        response.sendRedirect("profile.jsp?success=You have set him/her as Admin!");
    }
}