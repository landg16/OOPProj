package Servlets;

import DataAccess.DatabaseManager;
import Helper.Calculate;
import Objects.Answer;
import Objects.Question;
import Objects.UserHistory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

@WebServlet("/CompleteQuiz")
public class CompleteQuiz extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int user_id = (int) request.getSession().getAttribute("user_id");
        int history_id = Integer.parseInt(request.getParameter("historyId"));
        int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));
        int correct_count = 0;
        ArrayList<Question> questions = DatabaseManager.getQuestions(quiz_id, false);
        for(int i = 0; i<questions.size(); i++){
            ArrayList<Answer> answers = DatabaseManager.getAnswers(questions.get(i).getId());
            String userAnswer = request.getParameter("answer"+questions.get(i).getId()).toLowerCase();
            for(Answer tmp : answers){
                if(tmp.isCorrect()) {
                    String correct = tmp.getAnswer().toLowerCase();
                    System.out.println("my answer: "+userAnswer);
                    System.out.println("corr answ: "+correct);
                    if(correct.equals(userAnswer)){
                        correct_count++;
                        break;
                    }
                }
            }
        }
        ArrayList<UserHistory> uh = DatabaseManager.getUserHistory(user_id);
        UserHistory current = null;
        for(UserHistory tmp : uh){
            if(!tmp.getIsEnded() && tmp.getQuizId() == quiz_id) current= tmp;
        }
        if(current != null) {
            Timestamp ts = DatabaseManager.getSQLTime();
            long time = ts.getTime() - current.getQuizStart();
            int score = Calculate.getScore(questions.size(), correct_count, time);
            long minutes = TimeUnit.MILLISECONDS.toMinutes(time);
            long seconds = TimeUnit.MILLISECONDS.toSeconds(time)%60;
            String timeStr;
            if(seconds<10){
                timeStr = minutes+":0"+seconds;
            } else {
                timeStr = minutes+":"+seconds;
            }
            DatabaseManager.updateHistory(history_id, quiz_id, score);
            response.sendRedirect("quiz_summary.jsp?quizID="+quiz_id+"&quizSize="+questions.size()+
                    "&correctAnswers="+correct_count+"&score="+score+"&time="+timeStr);
        }
    }
}
