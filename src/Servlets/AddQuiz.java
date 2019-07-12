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
        String errors = "";
        int user_id = (int) request.getSession().getAttribute("user_id");
        String title = request.getParameter("title");
        if(title == null || title.length()<1) errors += "<p class='error'>Title is Required</p>";
        String description = request.getParameter("description");
        if(description == null || description.length()<1) errors += "<p class='error'>Description is Required</p>";
        String image = request.getParameter("image");
        if(image == null || image.length()<1) errors += "<p class='error'>Image is Required</p>";
        String random = request.getParameter("randomize");
        if(random == null || random.length()<1) errors += "<p class='error'>Random Question is required</p>";
        String page = request.getParameter("one_page");
        if(page == null || page.length()<1) errors += "<p class='error'>One or Multiple question required</p>";
        String immed = request.getParameter("immediate");
        if(immed == null || immed.length()<1) errors += "<p class='error'>Immediate correction is required</p>";
        String prac = request.getParameter("practice");
        if(prac == null || prac.length()<1) errors += "<p class='error'>Practice mode</p>";

        if(errors.length() != 0){
            response.sendRedirect("add_quiz.jsp?error="+errors);
            return;
        }

        boolean randomize = random.equals("true");
        boolean onePage = page.equals("true");
        boolean immediate = immed.equals("true");
        boolean practice = prac.equals("true");
        int quiz_id = DatabaseManager.insertQuiz(user_id, title, description, 1, randomize, onePage, immediate, practice, image, 0);
        int question_num = Integer.parseInt(request.getParameter("question_count"));

        for (int i = 1; i <= question_num; i++) {
            String type = request.getParameter("type" + i);
            if (type.equals("qr")) {
                String question = request.getParameter("question" + i);
                String answer = request.getParameter("answer" + i);
                if(question.length()==0) {
                    errors += "<p class='error'>You must enter question</p>";
                    break;
                }
                if(answer.length()==0) {
                    errors += "<p class='error'>You must enter answer</p>";
                    break;
                }
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                DatabaseManager.insertAnswer(question_id, answer, true);
            } else if (type.equals("fitb")) {
                String before_gap = request.getParameter("before_gap" + i);
                String gap = request.getParameter("gap" + i);
                String after_gap = request.getParameter("after_gap" + i);
                if(before_gap.length()==0 || after_gap.length()==0) {
                    errors += "<p class='error'>You must enter before or after gap</p>";
                    break;
                }
                if(gap.length()==0) {
                    errors += "<p class='error'>You must enter gap</p>";
                    break;
                }
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, before_gap, after_gap);
                DatabaseManager.insertAnswer(question_id, gap, true);
            } else if (type.equals("prq")) {
                String question = request.getParameter("question" + i);
                String answer = request.getParameter("answer" + i);
                if(question.length()==0) {
                    errors += "<p class='error'>You must enter image url</p>";
                    break;
                }
                if(answer.length()==0) {
                    errors += "<p class='error'>You must enter answer</p>";
                    break;
                }
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                DatabaseManager.insertAnswer(question_id, answer, true);
            } else if (type.equals("mc")) {
                String question = request.getParameter("question" + i);
                if(question.length()==0) {
                    errors += "<p class='error'>You must enter question</p>";
                    break;
                }
                int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                String[] answers = request.getParameterValues("answer_" + i);
                if(answers[0].length()==0) {
                    errors += "<p class='error'>You must enter correct answer</p>";
                    break;
                }
                for (int j = 1; j < answers.length; j++) {
                    if(answers[i].length()==0) {
                        errors += "<p class='error'>You must enter wrong answers</p>";
                        break;
                    }
                    DatabaseManager.insertAnswer(question_id, answers[i], false);
                }
                DatabaseManager.insertAnswer(question_id, answers[0], true);
            } else {
                errors += "<p class='error'>Wrong Question Type!</p>";
                break;
            }
        }
        if(errors.length() != 0){
            response.sendRedirect("add_quiz.jsp?error="+errors);
            return;
        }
        response.sendRedirect("profile.jsp?success=You have successfuly created quiz!");
    }
}
