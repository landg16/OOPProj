package Objects;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

public class UserHistory {

    private int id;
    private int userId;
    private int quizId;
    private long quizStart;
    private long quizEnd;
    private double quizScore;
    private boolean isEnded;

    public UserHistory(int id, int userId, int quizId, double quizScore, Timestamp quizStart, Timestamp quizEnd, boolean isEnded) {
        this.id = id;
        this.userId = userId;
        this.quizId = quizId;
        this.quizStart = quizStart.getTime();
        if(quizEnd != null) {
            this.quizEnd = quizEnd.getTime();
        }
        this.quizScore = quizScore;
        this.isEnded = isEnded;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public long getQuizStart() {
        return quizStart;
    }

    public long getQuizEnd() {
        return quizEnd;
    }

    public double getScore() {
        return quizScore;
    }

    public boolean getIsEnded() {
        return isEnded;
    }

    public void setIsEnded(boolean isEnded) {
        this.isEnded = isEnded;
    }
}
