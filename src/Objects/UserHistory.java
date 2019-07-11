package Objects;

import java.sql.Time;
import java.util.Date;

public class UserHistory {
    private int quizId;
    private int quizDate;
    private int quizTime;
    private int score;

    public UserHistory(int quizId, int quizDate, int quizTime, int score) {
        this.quizId = quizId;
        this.quizDate = quizDate;
        this.quizTime = quizTime;
        this.score = score;
    }

    public int getQuizId() {
        return quizId;
    }

    public int getQuizDate() {
        return quizDate;
    }

    public int getQuizTime() {
        return quizTime;
    }

    public int getScore() {
        return score;
    }
}
