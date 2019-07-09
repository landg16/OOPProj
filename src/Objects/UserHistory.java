package Objects;

import java.sql.Time;
import java.util.Date;

public class UserHistory {
    private int quizId;
    private Date quizDate;
    private Time quizTime;
    private String quizName;
    private int score;

    public UserHistory(int quizId, Date quizDate, Time quizTime, String quizName, int score) {
        this.quizId = quizId;
        this.quizDate = quizDate;
        this.quizTime = quizTime;
        this.quizName = quizName;
        this.score = score;
    }

    public int getQuizId() {
        return quizId;
    }

    public Date getQuizDate() {
        return quizDate;
    }

    public Time getQuizTime() {
        return quizTime;
    }

    public String getQuizName() {
        return quizName;
    }

    public int getScore() {
        return score;
    }
}
