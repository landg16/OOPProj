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

@WebServlet("/ChallengeRequest")
public class ChallengeRequest extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";
        String recieverId = request.getParameter("receiverId");
        String senderId = request.getParameter("senderId");
        String quizId = request.getParameter("quizId");
        int receiver = Integer.parseInt(recieverId);
        int sender = Integer.parseInt(senderId);
        int quiz = Integer.parseInt(quizId);
        DatabaseManager.insertChallenge(sender, receiver, quiz);
        response.sendRedirect("quiz_start.jsp?id="+ quiz);
    }
}