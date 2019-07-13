package Objects;

import java.sql.Time;
import java.util.Date;

public class UserHistory {
    private int quizId;
    private String quizName;
    private Date quizDate;
    private int quizTime;
    private int quizScore;

    public UserHistory(int quizId, String quizName, Date quizDate, int quizTime, int score) {
        this.quizId = quizId;
        this.quizName = quizName;
        this.quizDate = quizDate;
        this.quizTime = quizTime;
        this.quizScore = score;
    }

    public int getQuizId() {
        return quizId;
    }

    public Date getQuizDate() {
        return quizDate;
    }

    public int getQuizTime() {
        return quizTime;
    }

    public int getScore() {
        return quizScore;
    }

    public String getQuizName() {
        return quizName;
    }

}
