package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddQuiz")
public class AddQuiz extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";
        int user_id = (int) request.getSession().getAttribute("user_id");
        //Title Check
        String title = request.getParameter("title");
        if(title == null || title.length()<1) errors += "<p class='error'>Title is Required</p>";

        //Description Check
        String description = request.getParameter("description");
        if(description == null || description.length()<1) errors += "<p class='error'>Description is Required</p>";
        else if(description.length()>250) errors += "<p class='error'>Description's maximum length is 250 character.";

        //Image Check
        String image = request.getParameter("image");
        if(image == null || image.length()<1) errors += "<p class='error'>Image is Required</p>";

        //Category Check
        int category_id = -1;
        String category_string = request.getParameter("category");
        if(category_string == null || category_string.length()<1) errors += "<p class='error'>You must select category</p>";
        else category_id = Integer.parseInt(category_string);

        //Randomize questions check
        String random = request.getParameter("randomize");
        if(random == null || random.length()<1) errors += "<p class='error'>Random Question is required</p>";

        //One or Multiple page check
        String page = request.getParameter("one_page");
        if(page == null || page.length()<1) errors += "<p class='error'>One or Multiple question required</p>";

        //Immediate correction check
        String immed = request.getParameter("immediate");
        if(immed == null || immed.length()<1) errors += "<p class='error'>Immediate correction is required</p>";

        //Practice mode check
        String prac = request.getParameter("practice");
        if(prac == null || prac.length()<1) errors += "<p class='error'>Practice mode</p>";

        //Questions numeration check
        String question_count = request.getParameter("question_count");
        int question_num = -1;
        if(question_count == null || question_count.length() == 0) errors += "<p class='error'>Wrong question count</p>" ;
        else question_num = Integer.parseInt(question_count);
        if(question_num<1 || question_num > 30) errors += "<p class='error'>You must enter minimum 1 and maximum 30 question";

        //If we have errors REDIRECT.
        if(errors.length() != 0){
            response.sendRedirect("add_quiz.jsp?error="+errors);
            return;
        }

        boolean randomize = random.equals("true");
        boolean onePage = page.equals("true");
        boolean immediate = immed.equals("true");
        boolean practice = prac.equals("true");
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd 'at' HH:mm:ss z");
        Date date = new Date(System.currentTimeMillis());

        //Quiz insert and get quiz ID
        int quiz_id = DatabaseManager.insertQuiz(user_id, title, description, category_id, randomize, onePage, immediate, practice, image);

        //Insert Questions and Answers :)
        label:
        for (int i = 1; i <= question_num; i++) {
            String type = request.getParameter("type" + i);
            switch (type) {
                case "qr": {
                    String question = request.getParameter("question" + i);
                    String answer = request.getParameter("answer" + i);
                    if (question.length() == 0) {
                        errors += "<p class='error'>You must enter question</p>";
                        break label;
                    }
                    if (answer.length() == 0) {
                        errors += "<p class='error'>You must enter answer</p>";
                        break label;
                    }
                    int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                    DatabaseManager.insertAnswer(question_id, answer, true);
                    break;
                }
                case "fitb": {
                    String before_gap = request.getParameter("before_gap" + i);
                    String gap = request.getParameter("gap" + i);
                    String after_gap = request.getParameter("after_gap" + i);
                    if (before_gap.length() == 0 && after_gap.length() == 0) {
                        errors += "<p class='error'>You must enter before or after gap</p>";
                        break label;
                    }
                    if (gap.length() == 0) {
                        errors += "<p class='error'>You must enter gap</p>";
                        break label;
                    }
                    int question_id = DatabaseManager.InsertQuestion(quiz_id, type, before_gap, after_gap);
                    DatabaseManager.insertAnswer(question_id, gap, true);
                    break;
                }
                case "prq": {
                    String question = request.getParameter("question" + i);
                    String answer = request.getParameter("answer" + i);
                    if (question.length() == 0) {
                        errors += "<p class='error'>You must enter image url</p>";
                        break label;
                    }
                    if (answer.length() == 0) {
                        errors += "<p class='error'>You must enter answer</p>";
                        break label;
                    }
                    int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                    DatabaseManager.insertAnswer(question_id, answer, true);
                    break;
                }
                case "mc": {
                    String question = request.getParameter("question" + i);
                    if (question.length() == 0) {
                        errors += "<p class='error'>You must enter question</p>";
                        break label;
                    }
                    int question_id = DatabaseManager.InsertQuestion(quiz_id, type, question, null);
                    String[] answers = request.getParameterValues("answer" + i);
                    if (answers[0].length() == 0) {
                        errors += "<p class='error'>You must enter correct answer</p>";
                        break label;
                    }
                    for (int j = 1; j < answers.length; j++) {
                        if (answers[j].length() == 0) {
                            errors += "<p class='error'>You must enter wrong answers</p>";
                            break;
                        }
                        DatabaseManager.insertAnswer(question_id, answers[j], false);
                    }
                    DatabaseManager.insertAnswer(question_id, answers[0], true);
                    break;
                }
                default:
                    errors += "<p class='error'>Wrong Question Type!</p>";
                    break label;
            }
        }

        //If error occured during answer inserting, delete quiz and redirect to add quiz page with errors :)
        if(errors.length() != 0){
            DatabaseManager.dropQuiz(quiz_id);
            response.sendRedirect("add_quiz.jsp?error="+errors);
            return;
        }
        response.sendRedirect("profile.jsp?success=You have successfuly created quiz!");
    }
}
