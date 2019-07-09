package Objects;

import java.sql.Time;
import java.util.Date;

public class UserHistory {
    private int quizId;
    private Date quizDate;
    private Time quizTime;
    private int score;

    public UserHistory(int quizId, Date quizDate, Time quizTime, int score) {
        this.quizId = quizId;
        this.quizDate = quizDate;
        this.quizTime = quizTime;
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

    public int getScore() {
        return score;
    }
}
