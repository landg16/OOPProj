package Servlets;

import DataAccess.DatabaseManager;
import Objects.Answer;
import Objects.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/CompleteQuiz")
public class CompleteQuiz extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int user_id = (int) request.getSession().getAttribute("user_id");
        int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
        int correct_count = 0;
        ArrayList<Question> questions = DatabaseManager.getQuestions(quiz_id, false);
        for(int i = 0; i<questions.size(); i++){
            ArrayList<Answer> answers = DatabaseManager.getAnswers(questions.get(i).getId());
            String userAnswer = request.getParameter("answer"+(i+1)).toLowerCase();
            for(Answer tmp : answers){
                if(tmp.isCorrect()) {
                    String correct = tmp.getAnswer().toLowerCase();
                    if(correct.equals(userAnswer)){
                        correct_count++;
                        break;
                    }
                }
            }
        }

    }
}
