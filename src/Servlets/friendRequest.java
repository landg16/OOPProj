package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/friendRequest")
public class friendRequest extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";
        String recieverId = request.getParameter("id");
        int receiver = Integer.parseInt(recieverId);
        int sender = (int) request.getSession().getAttribute("user_id");
        DatabaseManager.insertFriendRequest(sender, receiver);
        response.sendRedirect("profile.jsp?success=You have sent friend request!");
    }
}