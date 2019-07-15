package Servlets;

import DataAccess.DatabaseManager;
import Objects.Answer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ImediateCorrection")
public class ImediateCorrection extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("id"));
        String answer = request.getParameter("answer");

        ArrayList<Answer> answers = DatabaseManager.getAnswers(questionId);

        for(Answer ans : answers){
            String currAns = ans.getAnswer();
            if(ans.isCorrect()){
                if(answer.toLowerCase().equals(currAns.toLowerCase())){
                    response.getWriter().write("true");
                }else {
                    response.getWriter().write("false");
                }
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
