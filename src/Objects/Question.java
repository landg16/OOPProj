package Objects;

import java.util.ArrayList;
import java.util.HashMap;

public class Question {

    private int QuestionId;
    private int QuizId;
    private String Question;
    private int QuestionId;
    private String SecondPart;
    private String Type;

    public Question(int questionId, int quizId, int type, String question, String secondPart){
        QuestionId = questionId;
        QuizId = quizId;
        Question = question;
        Type = type;
        SecondPart = secondPart;
    }

    public int getQuizId(){
        return QuizId;
    }

    public String getSecondPart(){
        return SecondPart;
    }

    public String getQuestionType(){
        return Type;
    }

}
