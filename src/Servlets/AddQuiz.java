package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AddQuiz")
public class AddQuiz extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int user_id = (int) request.getSession().getAttribute("user_id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        boolean randomize = request.getParameter("randomize").equals("true");
        boolean onePage = request.getParameter("one_page").equals("true");
        boolean immediate = request.getParameter("immediate").equals("true");
        boolean practice = request.getParameter("practice").equals("true");
        int quiz_id = DatabaseManager.insertQuiz(user_id, title, description, 1, randomize, onePage, immediate, practice, image, 0);
        int question_num = Integer.parseInt(request.getParameter("question_count"));

        for (int i = 1; i <= question_num; i++) {
            String type = request.getParameter("type" + i);
            if (type.equals("qr")) {
                String question = request.getParameter("question" + i);
                String answer = request.getParameter("answer" + i);
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                DatabaseManager.insertAnswer(question_id, answer, true);
            } else if (type.equals("fitb")) {
                String before_gap = request.getParameter("before_gap" + i);
                String gap = request.getParameter("gap" + i);
                String after_gap = request.getParameter("after_gap" + i);
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, before_gap, after_gap);
                DatabaseManager.insertAnswer(question_id, gap, true);
            } else if (type.equals("prq")) {
                String question = request.getParameter("question" + i);
                String answer = request.getParameter("answer" + i);
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                DatabaseManager.insertAnswer(question_id, answer, true);
            } else if (type.equals("mc")) {
                String question = request.getParameter("question" + i);
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                String[] answers = request.getParameterValues("answer" + i);
                DatabaseManager.insertAnswer(question_id, answers[0], true);
                for (int j = 1; j < answers.length; j++) {
                    DatabaseManager.insertAnswer(question_id, answers[i], false);
                }
            }
        }
        response.sendRedirect("profile.jsp?success=You have successfuly created quiz!");
    }
}
