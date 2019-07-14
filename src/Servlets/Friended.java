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

@WebServlet("/Friended")
public class Friended extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recieverId = request.getParameter("receiverId");
        String senderId = request.getParameter("senderId");
        int receiver = Integer.parseInt(recieverId);
        int sender = Integer.parseInt(senderId);
        DatabaseManager.insertFriend(receiver,sender);
        response.sendRedirect("profile.jsp?success=You are now friends!");
    }
}